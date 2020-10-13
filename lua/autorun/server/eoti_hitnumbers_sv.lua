
EOTI_HitNumbers = EOTI_HitNumbers or {}
EOTI_HitNumbers.Multiplier = EOTI_HitNumbers.Multiplier or {}
EOTI_HitNumbers.Combo = EOTI_HitNumbers.Combo or {}
EOTI_HitNumbers.Color = EOTI_HitNumbers.Color or {}
EOTI_HitNumbers.Draw = EOTI_HitNumbers.Draw or {}
EOTI_HitNumbers.Text = EOTI_HitNumbers.Text or {}

EOTI_HitNumbers.Hits = EOTI_HitNumbers.Hits or {}

--------------------------------------------------------------

AddCSLuaFile( "eoti_hitnumbers_cl.lua" )
AddCSLuaFile( "eoti_hitnumbers_config.lua" )
include( "eoti_hitnumbers_config.lua" )

--------------------------------------------------------------

EOTI_HitNumbers.Enable = EOTI_HitNumbers.Enable or true

EOTI_HitNumbers.ShowPlayer = EOTI_HitNumbers.ShowPlayer or true
EOTI_HitNumbers.ShowNPC = EOTI_HitNumbers.ShowNPC or true

EOTI_HitNumbers.Multiplier.Enable = EOTI_HitNumbers.Multiplier.Enable or true
EOTI_HitNumbers.Multiplier.Headshot = EOTI_HitNumbers.Multiplier.Headshot or '200%'
EOTI_HitNumbers.Multiplier.Bodyshot = EOTI_HitNumbers.Multiplier.Bodyshot or '100%'
EOTI_HitNumbers.Multiplier.Limbshot = EOTI_HitNumbers.Multiplier.Limbshot or '25%'

--------------------------------------------------------------

EOTI_HitNumbers.Combo = nil
EOTI_HitNumbers.Color = nil
EOTI_HitNumbers.Draw = nil
EOTI_HitNumbers.Text = nil
EOTI_HitNumbers.Hits = nil

EOTI_HitNumbers.Multiplier.Headshot = isstring(EOTI_HitNumbers.Multiplier.Headshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Headshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Headshot or 2.0
EOTI_HitNumbers.Multiplier.Bodyshot = isstring(EOTI_HitNumbers.Multiplier.Bodyshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Bodyshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Bodyshot or 1.0
EOTI_HitNumbers.Multiplier.Limbshot = isstring(EOTI_HitNumbers.Multiplier.Limbshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Limbshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Limbshot or 0.25

--------------------------------------------------------------
if EOTI_HitNumbers.Enable then
	local meta = FindMetaTable("Player")
	util.AddNetworkString("eoti_sendHitNumber")
	function meta:eotiSendHitNumbers( target, pos, damage, hitgroup, unmodified )
		net.Start("eoti_sendHitNumber")
		net.WriteInt(target, 10) --check what the entity max is
		net.WriteVector(pos)
		net.WriteInt(damage, 14)
		net.WriteInt(hitgroup, 3)
		net.WriteInt(unmodified, 14)
		net.Send(self)
	end

end


if EOTI_HitNumbers.Enable then
	hook.Add( "InitPostEntity", "eoti_stuff", function()
		local UnmodifiedDamage = false
		local HitGroup = false
		timer.Simple(5, function()
			-- 0 is headshot, 1 is bodyshot, 2 is limbshot
			hook.Add("ScalePlayerDamage", "eoti_hitnumber_scaleplayer", function( ply, hitgroup, dmg ) 
				UnmodifiedDamage = dmg:GetMaxDamage() or dmg:GetDamage() or false
				HitGroup = hitgroup > 3 and hitgroup < 8 and 2 or hitgroup == 1 and 0 or 1
				if EOTI_HitNumbers.Multiplier.Enable then
					dmg:ScaleDamage(hitgroup > 3 and hitgroup < 8 and EOTI_HitNumbers.Multiplier.Limbshot/0.25 or hitgroup == 1 and EOTI_HitNumbers.Multiplier.Headshot/2.0 or EOTI_HitNumbers.Multiplier.Bodyshot)
				end
			end)

			-- 0 is headshot, 1 is bodyshot, 2 is limbshot
			hook.Add("ScaleNPCDamage", "eoti_hitnumber_scalenpc", function( ply, hitgroup, dmg ) 
				UnmodifiedDamage = dmg:GetMaxDamage() or dmg:GetDamage() or false
				HitGroup = hitgroup > 3 and hitgroup < 8 and 2 or hitgroup == 1 and 0 or 1
				if EOTI_HitNumbers.Multiplier.Enable then
					dmg:ScaleDamage(hitgroup > 3 and hitgroup < 8 and EOTI_HitNumbers.Multiplier.Limbshot/0.25 or hitgroup == 1 and EOTI_HitNumbers.Multiplier.Headshot/2.0 or EOTI_HitNumbers.Multiplier.Bodyshot)
				end
			end)

			hook.Add("EntityTakeDamage", "eoti_hitnumber_etd", function( ply, dmg ) 
				if ply:IsValid() and dmg != nil then
					local atk = dmg:GetAttacker()
					local isnpc = EOTI_HitNumbers.ShowNPC and ply:IsNPC()
		        	local isply = EOTI_HitNumbers.ShowPlayer and ply:IsPlayer()
		        	local isall = EOTI_HitNumbers.ShowOtherEnts and ply:IsValid()

					if atk:IsPlayer() and (isply or isnpc or isall) then 
						atk:eotiSendHitNumbers( ply:EntIndex(), ply:GetPos(), dmg:GetDamage(), dmg:IsExplosionDamage() and 3 or HitGroup or 2, UnmodifiedDamage or dmg:GetDamage() )
					end

					UnmodifiedDamage = false
					HitGroup = false
				end
			end)
		end)
	end)
else
	EOTI_HitNumbers = nil
end