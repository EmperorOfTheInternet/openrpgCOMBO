timer.Simple(10, function()
	if DarkRPG then
	    if CLIENT then 
	    	DarkRPG.Config.HitNumbers = false
	    end
	    print('EOTI Hit Numbers: DarkRPG Detected!')
	else
		print('EOTI Hit Numbers: DarkRPG Not Detected!')
		return
	end
	
	if DarkRPG and EOTI_HitNumbers.Enable and SERVER then
		hook.Remove("InitPostEntity", "DarkRPG_resistCheckTimer") -- FROM EOTI
		hook.Remove("EntityTakeDamage", "eoti_hitnumber_etd")

		local UnmodifiedDamage = false -- FROM EOTI
		local HitGroup = false -- FROM EOTI
		-- FROM EOTI --
		hook.Remove("EntityTakeDamage", "eoti_hitnumber_scaleplayer") -- FROM EOTI
		hook.Add("ScalePlayerDamage", "eoti_hitnumber_scaleplayer", function( ply, hitgroup, dmg ) 
			UnmodifiedDamage = dmg:GetMaxDamage() or dmg:GetDamage() or false
			HitGroup = hitgroup > 3 and hitgroup < 8 and 2 or hitgroup == 1 and 0 or 1
			if EOTI_HitNumbers.Multiplier.Enable then
				dmg:ScaleDamage(hitgroup > 3 and hitgroup < 8 and EOTI_HitNumbers.Multiplier.Limbshot/0.25 or hitgroup == 1 and EOTI_HitNumbers.Multiplier.Headshot/2.0 or EOTI_HitNumbers.Multiplier.Bodyshot)
			end
		end)

		-- 0 is headshot, 1 is bodyshot, 2 is limbshot
		hook.Remove("EntityTakeDamage", "eoti_hitnumber_scalenpc") -- FROM EOTI
		hook.Add("ScaleNPCDamage", "eoti_hitnumber_scalenpc", function( ply, hitgroup, dmg ) 
			UnmodifiedDamage = dmg:GetMaxDamage() or dmg:GetDamage() or false
			HitGroup = hitgroup > 3 and hitgroup < 8 and 2 or hitgroup == 1 and 0 or 1
			if EOTI_HitNumbers.Multiplier.Enable then
				dmg:ScaleDamage(hitgroup > 3 and hitgroup < 8 and EOTI_HitNumbers.Multiplier.Limbshot/0.25 or hitgroup == 1 and EOTI_HitNumbers.Multiplier.Headshot/2.0 or EOTI_HitNumbers.Multiplier.Bodyshot)
			end
		end)

		-- 0 is headshot, 1 is bodyshot, 2 is limbshot
		print('DarkRPG SERVER: Damage Now Activated.')
		function GAMEMODE:EntityTakeDamage(ply,dmg)
			if ply:IsValid() and dmg != nil then

				local atk = dmg:GetAttacker()
				local crit = (atk:IsPlayer() and DarkRPG.Server.Player[atk:SteamID()] != nil and DarkRPG.Server.Player[atk:SteamID()].critical or -1) >= math.random(0,100) and DarkRPG.Server.CritScale or 1
				local atkisply = atk:IsPlayer()
				local hitvalid = atk:IsPlayer() and (EOTI_HitNumbers.ShowPlayer and ply:IsPlayer() or EOTI_HitNumbers.ShowNPC and ply:IsNPC()) or EOTI_HitNumbers.ShowOtherEnts and ply:IsValid() -- FROM EOTI

				if atkisply and DarkRPG.Server.Player[atk:SteamID()].damage < 0 then
					ply:SetHealth( math.Clamp( ply:Health() + 100*math.abs(DarkRPG.Server.Player[atk:SteamID()].damage or 1), ply:Health(), ply:GetMaxHealth() ) )
					return true
				elseif ply:IsPlayer() then

					local steamid = DarkRPG.Server.Player[ply:SteamID()]
					if steamid != nil then
						if atkisply or atk:IsNPC() then
							if (steamid.evasion or 0) > 0 and (steamid.evasion or 0) >= math.random(0,100) then 
								ply:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav")
								if hitvalid then  -- FROM EOTI
									atk:eotiSendHitNumbers( ply:EntIndex(), ply:GetPos(), 0, dmg:IsExplosionDamage() and 3 or HitGroup or 2, 2 ) 
									HitGroup = false
									UnmodifiedDamage = false
								end -- FROM EOTI
								return true
							elseif (steamid.reflect or 0) > 0 and ( atk:IsPlayer() and atk != nil and atk != ply ) and (steamid.reflect or 0) >= math.random(0,100) then
								ply:EmitSound("npc/manhack/grind"..math.random(1,5)..".wav")
								dmg:SetInflictor(atk)
								atk:TakeDamageInfo( dmg )
								if hitvalid then -- FROM EOTI
									atk:eotiSendHitNumbers( ply:EntIndex(), ply:GetPos(), 0, dmg:IsExplosionDamage() and 3 or HitGroup or 2, 3 )
									HitGroup = false
									UnmodifiedDamage = false
								end -- FROM EOTI
								return true
							end
						end

						local dtype = DarkRPG.Resists.List[dmg:GetDamageType()]
						dmg:ScaleDamage( (dtype and (steamid[dtype] or 0) < (steamid.resists or 0) and (steamid[dtype] or 1) or steamid.resists or 1) * (crit or 1) or 1 )
						if hitvalid then -- FROM EOTI
							atk:eotiSendHitNumbers( ply:EntIndex(), ply:GetPos(), dmg:GetDamage(), dmg:IsExplosionDamage() and 3 or HitGroup or 2, crit > 1 and 1 or 0 )
							HitGroup = false
							UnmodifiedDamage = false
						end -- FROM EOTI
					end
				else
					dmg:ScaleDamage( crit )
					if hitvalid then -- FROM EOTI
						atk:eotiSendHitNumbers( ply:EntIndex(), ply:GetPos(), dmg:GetDamage(), dmg:IsExplosionDamage() and 3 or HitGroup or 2, crit > 1 and 1 or 0 )
						HitGroup = false
						UnmodifiedDamage = false
					end -- FROM EOTI
				end
			end
		end
		print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx')
	end

	-- CLIENT SHIIIIIIIIIIT
	if DarkRPG and EOTI_HitNumbers.Enable and CLIENT then
		
		net.Receive("eoti_sendHitNumber", function(len)
	    	local tgt = net.ReadInt( 10 )
	        local pos = net.ReadVector()
	        local dmg = net.ReadInt( 14 )
	        local grp = net.ReadInt( 3 )
	        local unm = net.ReadInt( 14 )

	        if EOTI_HitNumbers.ShowComboWindow then
		        EOTI_HitNumbers.CurrentCombo = EOTI_HitNumbers.CurrentCombo or {}
		        EOTI_HitNumbers.CurrentCombo.Hits = (EOTI_HitNumbers.CurrentCombo.Hits or 0) + 1
		        EOTI_HitNumbers.CurrentCombo.Damage = (EOTI_HitNumbers.CurrentCombo.Damage or 0) + dmg
		        EOTI_HitNumbers.CurrentCombo.shake = (EOTI_HitNumbers.CurrentCombo.shake or 0) + EOTI_HitNumbers.Combo.ShakeIntensity + EOTI_HitNumbers.CurrentCombo.Hits*EOTI_HitNumbers.Combo.ShakeComboIntensity
		        local chits = EOTI_HitNumbers.CurrentCombo.Hits
		        EOTI_HitNumbers.CurrentCombo.Color = chits < 51 and Color(255-chits*5,255-chits*5,255) or chits < 101 and Color((chits-51)*5,0,255) or Color(255,(chits-51)*5,255-(chits-101)*5)

		        if timer.Exists('EOTI_HitNumbers_ComboInProgress') then
		            timer.Adjust('EOTI_HitNumbers_ComboInProgress', EOTI_HitNumbers.Combo.Timer, 1, function() EOTI_HitNumbers.ComboCompleted() end)
		        else
		            timer.Create('EOTI_HitNumbers_ComboInProgress', EOTI_HitNumbers.Combo.Timer, 1, function() EOTI_HitNumbers.ComboCompleted() end)
		        end
	    	end

	        if grp == 3 then
	            EOTI_HitNumbers.Hits['BOOM'] = EOTI_HitNumbers.Hits['BOOM'] or {}
	            EOTI_HitNumbers.Hits['BOOM'].pos = EOTI_HitNumbers.Hits['BOOM'].pos or pos
	            if EOTI_HitNumbers.Hits['BOOM'].average == nil then
	                timer.Simple(0.1, function()
	                    if istable(EOTI_HitNumbers.Hits['BOOM'].average) then
	                        local count = table.Count( EOTI_HitNumbers.Hits['BOOM'].average )
	                        if count < 2 then return end
	                        local x = 0
	                        local y = 0
	                        local z = 0
	                        for i, avg in pairs( EOTI_HitNumbers.Hits['BOOM'].average ) do
	                            x = x + avg.x
	                            y = y + avg.y
	                            z = z + avg.z
	                        end
	                        EOTI_HitNumbers.Hits['BOOM'].pos = Vector( x/count, y/count, z/count )
	                        EOTI_HitNumbers.Hits['BOOM'].decay = EOTI_HitNumbers.Hits['BOOM'].decay+(count*100)
	                        EOTI_HitNumbers.Hits['BOOM'].scale = EOTI_HitNumbers.Hits['BOOM'].scale+(count/100)
	                        EOTI_HitNumbers.Hits['BOOM'].average = nil
	                    end
	                end)
	            end
	            EOTI_HitNumbers.Hits['BOOM'].color = EOTI_HitNumbers.Color.Boom
	            EOTI_HitNumbers.Hits['BOOM'].average = EOTI_HitNumbers.Hits['BOOM'].average or {}
	            EOTI_HitNumbers.Hits['BOOM'].average[tgt] = EOTI_HitNumbers.Hits['BOOM'].average[tgt] or pos
	            EOTI_HitNumbers.Hits['BOOM'].combo = (EOTI_HitNumbers.Hits['BOOM'].combo or 0) + 1
	            EOTI_HitNumbers.Hits['BOOM'].damage = (EOTI_HitNumbers.Hits['BOOM'].damage or 0) + dmg
	            EOTI_HitNumbers.Hits['BOOM'].decay = EOTI_HitNumbers.Draw.DecayTimer or 2000
	            EOTI_HitNumbers.Hits['BOOM'].scale = EOTI_HitNumbers.Draw.ScaleTimer or 0.2
	            EOTI_HitNumbers.Hits['BOOM'].text = EOTI_HitNumbers.Text.Boom..EOTI_HitNumbers.Hits['BOOM'].damage..' (x'..EOTI_HitNumbers.Hits['BOOM'].combo..')'
	            if EOTI_HitNumbers.ShowComboWindow then
	            	EOTI_HitNumbers.CurrentCombo.Explodes = (EOTI_HitNumbers.CurrentCombo.Explodes or 0) + 1
	            end
	            return
	        end

	        EOTI_HitNumbers.Hits[tgt] = EOTI_HitNumbers.Hits[tgt] or {}
	        EOTI_HitNumbers.Hits[tgt].pos = pos or EOTI_HitNumbers.Hits[tgt].pos
	        EOTI_HitNumbers.Hits[tgt].combo = (EOTI_HitNumbers.Hits[tgt].combo or 0) + 1
	        EOTI_HitNumbers.Hits[tgt].damage = (EOTI_HitNumbers.Hits[tgt].damage or 0) + dmg
	        EOTI_HitNumbers.Hits[tgt].decay = EOTI_HitNumbers.Draw.DecayTimer or 2000
	        EOTI_HitNumbers.Hits[tgt].scale = EOTI_HitNumbers.Draw.ScaleTimer or 0.2
	        
	        if unm == 2 and EOTI_HitNumbers.Text.DRPGEvasion then
	            EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Text.DRPGEvasion
	            EOTI_HitNumbers.Hits[tgt].color = EOTI_HitNumbers.Color.DRPGEvasion
	        elseif unm == 3 and EOTI_HitNumbers.Text.DRPGReflect then
	            EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Text.DRPGReflect
	            EOTI_HitNumbers.Hits[tgt].color = EOTI_HitNumbers.Color.DRPGReflect
	        else
	        	-- FROM EOTI
	        	local iscritical = unm == 1
	            if grp == 0 then
	                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Headshot or EOTI_HitNumbers.Text.Headshot
	                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Headshot
	                if EOTI_HitNumbers.ShowComboWindow then
		                EOTI_HitNumbers.CurrentCombo.Headshots = (EOTI_HitNumbers.CurrentCombo.Headshots or 0) + 1
		                EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
	            	end
	            elseif grp == 1 then
	                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Bodyshot or EOTI_HitNumbers.Text.Bodyshot
	                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Bodyshot
	                if EOTI_HitNumbers.ShowComboWindow then
		                EOTI_HitNumbers.CurrentCombo.Bodyshots = (EOTI_HitNumbers.CurrentCombo.Bodyshots or 0) + 1
		                EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
		            end
	            else
	                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Limbshot or EOTI_HitNumbers.Text.Limbshot
	                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Limbshot
	                if EOTI_HitNumbers.ShowComboWindow then
		                EOTI_HitNumbers.CurrentCombo.Limbshots = (EOTI_HitNumbers.CurrentCombo.Limbshots or 0) + 1
		                EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
		            end
	            end
	            -- FROM EOTI
	            EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Hits[tgt].text..EOTI_HitNumbers.Hits[tgt].damage

	            timer.Simple(0.05,function()
	                if EOTI_HitNumbers.Hits[tgt] == nil then return end
	                local ent = ents.GetByIndex(tgt)
	                if ent:IsValid() and ent:Health() > 0 then return end
	                EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Text.Dead..EOTI_HitNumbers.Hits[tgt].damage
	                EOTI_HitNumbers.Hits[tgt].color = EOTI_HitNumbers.Color.Dead
	            end)
	        end
	    end )
	end
end)