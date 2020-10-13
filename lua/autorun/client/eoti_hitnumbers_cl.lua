print('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x')
print('C-C-Combo CLIENT: Starting...')

EOTI_HitNumbers = EOTI_HitNumbers or {}
EOTI_HitNumbers.Combo = EOTI_HitNumbers.Combo or {}
EOTI_HitNumbers.Color = EOTI_HitNumbers.Color or {}
EOTI_HitNumbers.Draw = EOTI_HitNumbers.Draw or {}
EOTI_HitNumbers.Text = EOTI_HitNumbers.Text or {}
EOTI_HitNumbers.Multiplier = EOTI_HitNumbers.Multiplier or {}
EOTI_HitNumbers.Hits = EOTI_HitNumbers.Hits or {}

--------------------------------------------------------------

AddCSLuaFile( "eoti_hitnumbers_config.lua" )
include( "eoti_hitnumbers_config.lua" )

if EOTI_HitNumbers.Style == 'Minimalist' then
    EOTI_HitNumbers.Draw.FontDesc = 'Trebuchet24'

    EOTI_HitNumbers.Draw.DecayTimer = 1000
    EOTI_HitNumbers.Draw.ScaleTimer = 40
    EOTI_HitNumbers.Draw.ScaleFloat = 100
    EOTI_HitNumbers.Draw.YOffset = 80

    EOTI_HitNumbers.Combo.FontY = 28
    EOTI_HitNumbers.Combo.FontDescY = 9
    EOTI_HitNumbers.Combo.WindowX = 20
    EOTI_HitNumbers.Combo.WindowY = 12
    EOTI_HitNumbers.Combo.WindowTime = 4
    EOTI_HitNumbers.Combo.Timer = 2.5
    EOTI_HitNumbers.Combo.ShakeIntensity = 0.1
    EOTI_HitNumbers.Combo.ShakeComboIntensity = 0.001

    -- Colors for weapon attacks, alpha values will be ignored.
    EOTI_HitNumbers.Color.Critical = Color(255,179,179)
    EOTI_HitNumbers.Color.Bodyshot = Color(179,255,179)
    EOTI_HitNumbers.Color.Headshot = Color(204,238,255)
    EOTI_HitNumbers.Color.Limbshot = Color(255,255,179)
    EOTI_HitNumbers.Color.NoDamage = Color(230,230,230)
    EOTI_HitNumbers.Color.Boom = Color(252,157,51)
    EOTI_HitNumbers.Color.Dead = Color(255,204,204)
    EOTI_HitNumbers.Color.DRPGEvasion = Color(200,200,200) -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
    EOTI_HitNumbers.Color.DRPGReflect = Color(232,204,232) -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
end

if EOTI_HitNumbers.Style == 'NoTextOnlyColors' then
    -- Text displayed next to a hit.
    EOTI_HitNumbers.Text.Headshot = ''
    EOTI_HitNumbers.Text.Limbshot = ''
    EOTI_HitNumbers.Text.Bodyshot = ''
    EOTI_HitNumbers.Text.Critical = 'Crit! '
    EOTI_HitNumbers.Text.NoDamage = ''
    EOTI_HitNumbers.Text.Dead = ''
    EOTI_HitNumbers.Text.Boom = ''
    EOTI_HitNumbers.Text.DRPGEvasion = 'Evade!' -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
    EOTI_HitNumbers.Text.DRPGReflect = 'Reflect!' -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
end

--------------------------------------------------------------

EOTI_HitNumbers.Draw.Font = EOTI_HitNumbers.Draw.Font or 'EOTI_HIT_32'
EOTI_HitNumbers.Draw.FontDesc = EOTI_HitNumbers.Draw.FontDesc or 'EOTI_HIT_9'
EOTI_HitNumbers.Combo.FontY = ScreenScale(EOTI_HitNumbers.Combo.FontY) or ScreenScale(28)
EOTI_HitNumbers.Combo.FontDescY = ScreenScale(EOTI_HitNumbers.Combo.FontDescY) or ScreenScale(9)

EOTI_HitNumbers.Draw.DecayTimer = EOTI_HitNumbers.Draw.DecayTimer or 2000
EOTI_HitNumbers.Draw.ScaleTimer = EOTI_HitNumbers.Draw.ScaleTimer/500 or 0.2
EOTI_HitNumbers.Draw.ScaleFloat = EOTI_HitNumbers.Draw.ScaleFloat or 255
EOTI_HitNumbers.Draw.YOffset = EOTI_HitNumbers.Draw.YOffset or 80
EOTI_HitNumbers.Combo.WindowX = ScrW()/EOTI_HitNumbers.Combo.WindowX or ScrW()/20
EOTI_HitNumbers.Combo.WindowY = ScrH()/EOTI_HitNumbers.Combo.WindowY or ScrH()/12
EOTI_HitNumbers.Combo.WindowTime = EOTI_HitNumbers.Combo.WindowTime or 5
EOTI_HitNumbers.Combo.Timer = EOTI_HitNumbers.Combo.Timer or 3
EOTI_HitNumbers.Combo.ShakeIntensity = EOTI_HitNumbers.Combo.ShakeIntensity or 1
EOTI_HitNumbers.Combo.ShakeComboIntensity = EOTI_HitNumbers.Combo.ShakeComboIntensity or 0.01

EOTI_HitNumbers.Color.Critical = EOTI_HitNumbers.Color.Critical or Color(252,15,15)
EOTI_HitNumbers.Color.Bodyshot = EOTI_HitNumbers.Color.Bodyshot or Color(14,252,14)
EOTI_HitNumbers.Color.Headshot = EOTI_HitNumbers.Color.Headshot or Color(6,38,232)
EOTI_HitNumbers.Color.Limbshot = EOTI_HitNumbers.Color.Limbshot or Color(255,241,29)
EOTI_HitNumbers.Color.NoDamage = EOTI_HitNumbers.Color.NoDamage or Color(50,50,50)
EOTI_HitNumbers.Color.Boom = EOTI_HitNumbers.Color.Boom or Color(252,157,10)
EOTI_HitNumbers.Color.Dead = EOTI_HitNumbers.Color.Dead or Color(232,10,10)

EOTI_HitNumbers.Multiplier.Headshot = EOTI_HitNumbers.Multiplier.Headshot or '200%'
EOTI_HitNumbers.Multiplier.Bodyshot = EOTI_HitNumbers.Multiplier.Bodyshot or '100%'
EOTI_HitNumbers.Multiplier.Limbshot = EOTI_HitNumbers.Multiplier.Limbshot or '25%'

EOTI_HitNumbers.Text.Headshot = EOTI_HitNumbers.Text.Headshot or 'Headshot! '
EOTI_HitNumbers.Text.Limbshot = EOTI_HitNumbers.Text.Limbshot or 'Graze! '
EOTI_HitNumbers.Text.Bodyshot = EOTI_HitNumbers.Text.Bodyshot or 'Hit! '
EOTI_HitNumbers.Text.Critical = EOTI_HitNumbers.Text.Critical or 'Critical '
EOTI_HitNumbers.Text.NoDamage = EOTI_HitNumbers.Text.NoDamage or 'Immune! '
EOTI_HitNumbers.Text.Dead = EOTI_HitNumbers.Text.Dead or 'Dead! '
EOTI_HitNumbers.Text.Boom = EOTI_HitNumbers.Text.Boom or 'BOOM! '

EOTI_HitNumbers.Text.DRPGEvasion = EOTI_HitNumbers.Text.DRPGEvasion or 'Evasion!'
EOTI_HitNumbers.Text.DRPGReflect = EOTI_HitNumbers.Text.DRPGReflect or 'Reflect!'

--------------------------------------------------------------

EOTI_HitNumbers.Multiplier.Headshot = isstring(EOTI_HitNumbers.Multiplier.Headshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Headshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Headshot or 2.0
EOTI_HitNumbers.Multiplier.Bodyshot = isstring(EOTI_HitNumbers.Multiplier.Bodyshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Bodyshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Bodyshot or 1.0
EOTI_HitNumbers.Multiplier.Limbshot = isstring(EOTI_HitNumbers.Multiplier.Limbshot) and tonumber(string.Replace(EOTI_HitNumbers.Multiplier.Limbshot,'%',''))/100 or EOTI_HitNumbers.Multiplier.Limbshot or 0.25

if EOTI_HitNumbers.Enable then
    function EOTI_HN_CreateFont(size,font,weight,title)
        surface.CreateFont( "EOTI_"..title.."_"..size, {
        font = font,
        size = ScreenScale(size),
        weight = 400,
        blursize = 0,
        scanlines = 0,
        antialias = true,
        underline = false,
        italic = false,
        strikeout = false,
        symbol = false,
        rotary = false,
        shadow = false,
        additive = false,
        outline = false,
        } )
    end
    EOTI_HN_CreateFont(32,"Coolvetica",800,"HIT")
    EOTI_HN_CreateFont(9,"Coolvetica",400,"HIT")
    EOTI_HN_CreateFont = nil
end

--------------------------------------------------------------
if EOTI_HitNumbers.Enable and EOTI_HitNumbers.ShowComboWindow then
    function EOTI_HitNumbers.ComboCompleted()
        EOTI_HitNumbers.PreviousCombo = EOTI_HitNumbers.CurrentCombo

        EOTI_HitNumbers.PreviousCombo.totalDamage = 'You did '..EOTI_HitNumbers.PreviousCombo.Damage..' damage total!'
        EOTI_HitNumbers.PreviousCombo.totalStats = 'Headshots: '..(EOTI_HitNumbers.PreviousCombo.Headshots or 0)..' - Bodyshots: '..(EOTI_HitNumbers.PreviousCombo.Bodyshots or 0)..' - Limbshots: '..(EOTI_HitNumbers.PreviousCombo.Limbshots or 0)..' - Criticals: '..(EOTI_HitNumbers.PreviousCombo.Criticals or 0)..' - Exploded: '..(EOTI_HitNumbers.PreviousCombo.Explodes or 0)
        EOTI_HitNumbers.PreviousCombo.x = EOTI_HitNumbers.Combo.WindowX
        EOTI_HitNumbers.CurrentCombo = nil
        ---------------------
        if timer.Exists('EOTI_HitNumbers_PopIn') then
            timer.Adjust('EOTI_HitNumbers_PopIn', 0.5, 1, function() EOTI_HitNumbers.PreviousCombo.showStats = true end)
        else
            timer.Create('EOTI_HitNumbers_PopIn', 0.5, 1, function() EOTI_HitNumbers.PreviousCombo.showStats = true end)
        end
        ---------------------
        if timer.Exists('EOTI_HitNumbers_PopOut') then
            timer.Adjust('EOTI_HitNumbers_PopOut', EOTI_HitNumbers.Combo.WindowTime+EOTI_HitNumbers.PreviousCombo.Hits/100-1.5, 1, function() EOTI_HitNumbers.PreviousCombo.AnimatingOff = true end)
        else
            timer.Create('EOTI_HitNumbers_PopOut', EOTI_HitNumbers.Combo.WindowTime+EOTI_HitNumbers.PreviousCombo.Hits/100-1.5, 1, function() EOTI_HitNumbers.PreviousCombo.AnimatingOff = true end)
        end
        ---------------------
        if timer.Exists('EOTI_HitNumbers_Delete') then
            timer.Adjust('EOTI_HitNumbers_Delete', EOTI_HitNumbers.Combo.WindowTime+EOTI_HitNumbers.PreviousCombo.Hits/100, 1, function() 
                if EOTI_HitNumbers.PreviousCombo == nil then return end
                EOTI_HitNumbers.PreviousCombo = nil
            end)
        else
            timer.Create('EOTI_HitNumbers_Delete', EOTI_HitNumbers.Combo.WindowTime+EOTI_HitNumbers.PreviousCombo.Hits/100, 1, function() 
                if EOTI_HitNumbers.PreviousCombo == nil then return end
                EOTI_HitNumbers.PreviousCombo = nil
            end)
        end
        ---------------------
    end
end

if EOTI_HitNumbers.Enable then
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
            if EOTI_HitNumbers.ShowComboWindow then EOTI_HitNumbers.CurrentCombo.Explodes = (EOTI_HitNumbers.CurrentCombo.Explodes or 0) + 1 end
            return
        end

        EOTI_HitNumbers.Hits[tgt] = EOTI_HitNumbers.Hits[tgt] or {}
        EOTI_HitNumbers.Hits[tgt].pos = pos or EOTI_HitNumbers.Hits[tgt].pos
        EOTI_HitNumbers.Hits[tgt].combo = (EOTI_HitNumbers.Hits[tgt].combo or 0) + 1
        EOTI_HitNumbers.Hits[tgt].damage = (EOTI_HitNumbers.Hits[tgt].damage or 0) + dmg
        EOTI_HitNumbers.Hits[tgt].decay = EOTI_HitNumbers.Draw.DecayTimer or 2000
        EOTI_HitNumbers.Hits[tgt].scale = EOTI_HitNumbers.Draw.ScaleTimer or 0.2
        
        if dmg <= 0 and EOTI_HitNumbers.Text.NoDamage then
            EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Text.NoDamage
            EOTI_HitNumbers.Hits[tgt].color = EOTI_HitNumbers.Color.NoDamage
        else
            if grp == 0 then
                local iscritical = EOTI_HitNumbers.Multiplier.Headshot*unm < dmg
                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Headshot or EOTI_HitNumbers.Text.Headshot
                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Headshot
                if EOTI_HitNumbers.ShowComboWindow then
                    EOTI_HitNumbers.CurrentCombo.Headshots = (EOTI_HitNumbers.CurrentCombo.Headshots or 0) + 1
                    EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
                end
            elseif grp == 1 then
                local iscritical = EOTI_HitNumbers.Multiplier.Bodyshot*unm < dmg
                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Bodyshot or EOTI_HitNumbers.Text.Bodyshot
                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Bodyshot
                if EOTI_HitNumbers.ShowComboWindow then
                    EOTI_HitNumbers.CurrentCombo.Bodyshots = (EOTI_HitNumbers.CurrentCombo.Bodyshots or 0) + 1
                    EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
                end
            else
                local iscritical = EOTI_HitNumbers.Multiplier.Limbshot*unm < dmg
                EOTI_HitNumbers.Hits[tgt].text = iscritical and EOTI_HitNumbers.Text.Critical..EOTI_HitNumbers.Text.Limbshot or EOTI_HitNumbers.Text.Limbshot
                EOTI_HitNumbers.Hits[tgt].color = iscritical and EOTI_HitNumbers.Color.Critical or EOTI_HitNumbers.Color.Limbshot
                if EOTI_HitNumbers.ShowComboWindow then
                    EOTI_HitNumbers.CurrentCombo.Limbshots = (EOTI_HitNumbers.CurrentCombo.Limbshots or 0) + 1
                    EOTI_HitNumbers.CurrentCombo.Criticals = (EOTI_HitNumbers.CurrentCombo.Criticals or 0) + (iscritical and 1 or 0) 
                end
            end
            EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Hits[tgt].text..EOTI_HitNumbers.Hits[tgt].damage

            timer.Simple(0.05,function()
                if EOTI_HitNumbers.Hits[tgt] == nil then return end
                local ent = ents.GetByIndex(tgt)
                if ent:IsValid() and ent:Health() > 0 then return end
                EOTI_HitNumbers.Hits[tgt].text = EOTI_HitNumbers.Text.Dead..EOTI_HitNumbers.Hits[tgt].damage
                EOTI_HitNumbers.Hits[tgt].color = EOTI_HitNumbers.Color.Dead
            end)
        end
    end)
end

if EOTI_HitNumbers.Enable then
	hook.Add( "PostDrawTranslucentRenderables", "eoti_HitNumber_Draw", function()
        cam.IgnoreZ(true);
        if EOTI_HitNumbers.Enable then
    		if table.Count(EOTI_HitNumbers.Hits) > 0 then
    			for i, hit in pairs( EOTI_HitNumbers.Hits ) do
    				local Pos = EOTI_HitNumbers.Hits[i].pos
    				local Ang = Angle( 0, LocalPlayer():EyeAngles()[2], 0 )

    				surface.SetFont(EOTI_HitNumbers.Draw.Font)
    				local textWide, textTall = surface.GetTextSize(EOTI_HitNumbers.Hits[i].text or 'ERROR')

    				Ang:RotateAroundAxis(Ang:Forward(), 90)
    				local TextAng = Ang
    				TextAng:RotateAroundAxis(TextAng:Right(), 90)

                    local scale = hit.decay < EOTI_HitNumbers.Draw.ScaleFloat and hit.decay*0.001 or EOTI_HitNumbers.Draw.ScaleFloat*0.001+(hit.scale or 0)

                    hit.color = hit.color or Color(255,255,255,0)
    				cam.Start3D2D(Pos + Ang:Right() * -(EOTI_HitNumbers.Draw.YOffset-hit.decay*0.01), TextAng, scale )
    					draw.SimpleTextOutlined( EOTI_HitNumbers.Hits[i].text, EOTI_HitNumbers.Draw.Font, -textWide*0.5 + 5, -100, Color(hit.color.r,hit.color.g,hit.color.b,hit.decay), 0, 0, textTall/20, Color(0,0,0,hit.decay) )
    				cam.End3D2D()
    				
    				EOTI_HitNumbers.Hits[i].decay = EOTI_HitNumbers.Hits[i].decay - 5
                    EOTI_HitNumbers.Hits[i].scale = (EOTI_HitNumbers.Hits[i].scale or 0) > 0 and EOTI_HitNumbers.Hits[i].scale - 0.01 or 0
    				if EOTI_HitNumbers.Hits[i].decay <= 0 then EOTI_HitNumbers.Hits[i] = nil end
    			end
    		end
        end
        cam.IgnoreZ(false);
	end)

    if EOTI_HitNumbers.ShowComboWindow then
        hook.Add( "HUDPaint", "eoti_paint_combonumbers", function()

            if EOTI_HitNumbers.PreviousCombo and EOTI_HitNumbers.PreviousCombo.Hits > 1 then
                surface.SetFont(EOTI_HitNumbers.Draw.Font)
                local textWide, textTall = surface.GetTextSize('ERROR')

                local shakeit = EOTI_HitNumbers.PreviousCombo.shake
                draw.SimpleTextOutlined(EOTI_HitNumbers.PreviousCombo.Hits.." Hits!", EOTI_HitNumbers.Draw.Font, math.random(-shakeit,shakeit)+EOTI_HitNumbers.PreviousCombo.x, math.random(-shakeit,shakeit)+EOTI_HitNumbers.Combo.WindowY, EOTI_HitNumbers.PreviousCombo.Color, 0, 0, textTall/20, Color(0,0,0))
                EOTI_HitNumbers.PreviousCombo.shake = EOTI_HitNumbers.PreviousCombo.shake > 0 and EOTI_HitNumbers.PreviousCombo.shake/4 or 0

                surface.SetFont(EOTI_HitNumbers.Draw.FontDesc)
                local textWide, textTall = surface.GetTextSize('ERROR')

                draw.SimpleTextOutlined(EOTI_HitNumbers.PreviousCombo.totalDamage, EOTI_HitNumbers.Draw.FontDesc, EOTI_HitNumbers.PreviousCombo.x, EOTI_HitNumbers.Combo.WindowY+EOTI_HitNumbers.Combo.FontY, Color(255,255,255), 0, 0, textTall/16, Color(0,0,0))

                if EOTI_HitNumbers.PreviousCombo.showStats then
                    draw.SimpleTextOutlined(EOTI_HitNumbers.PreviousCombo.totalStats, EOTI_HitNumbers.Draw.FontDesc, EOTI_HitNumbers.PreviousCombo.x, EOTI_HitNumbers.Combo.WindowY+EOTI_HitNumbers.Combo.FontY+EOTI_HitNumbers.Combo.FontDescY, Color(255,255,255), 0, 0, textTall/16, Color(0,0,0))
                end

                if EOTI_HitNumbers.PreviousCombo.AnimatingOff then
                    EOTI_HitNumbers.PreviousCombo.velx = (EOTI_HitNumbers.PreviousCombo.velx or 8) - 0.55
                    EOTI_HitNumbers.PreviousCombo.x = EOTI_HitNumbers.PreviousCombo.x + EOTI_HitNumbers.PreviousCombo.velx
                end
            elseif EOTI_HitNumbers.CurrentCombo and EOTI_HitNumbers.CurrentCombo.Hits > 1 then
                surface.SetFont(EOTI_HitNumbers.Draw.Font)
                local textWide, textTall = surface.GetTextSize('ERROR')

                local shakeit = EOTI_HitNumbers.CurrentCombo.shake
                draw.SimpleTextOutlined(EOTI_HitNumbers.CurrentCombo.Hits.." Hits!", EOTI_HitNumbers.Draw.Font, math.random(-shakeit,shakeit)+EOTI_HitNumbers.Combo.WindowX, math.random(-shakeit,shakeit)+EOTI_HitNumbers.Combo.WindowY, EOTI_HitNumbers.CurrentCombo.Color, 0, 0, textTall/20, Color(0,0,0))
                EOTI_HitNumbers.CurrentCombo.shake = EOTI_HitNumbers.CurrentCombo.shake > 0 and EOTI_HitNumbers.CurrentCombo.shake - 0.1 or 0
            end
        end )
    end
end
print('C-C-Combo CLIENT: Finished Executing.')
print('x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x')