---------------------------------------------------------------
-------------------- The Combo Hit Numbers --------------------
---------------------------------------------------------------

-- Controls whether its on/off and on what entities hit numbers appear.
EOTI_HitNumbers.Enable = true
EOTI_HitNumbers.ShowPlayerHits = true
EOTI_HitNumbers.ShowNPCHits = true
EOTI_HitNumbers.ShowOtherEnts = false -- Shows damage on entities.
EOTI_HitNumbers.ShowComboWindow = true

-- You can set a basic style instead of having to set these yourself.
-- 'Default' is what settings you change in this config file
-- 'Minimalist' is tiny font with lighter colors
-- 'NoTextOnlyColors' there is no messages such as 'Headshot!'
EOTI_HitNumbers.Style = 'Default'

-- EOTI font is Coolvetica generated in the autorun/client folder.
EOTI_HitNumbers.Draw.Font = 'EOTI_HIT_32'
EOTI_HitNumbers.Draw.FontDesc = 'EOTI_HIT_9'

-- Controls how long, how big and how high off the ground the Hit Numbers are.
EOTI_HitNumbers.Draw.DecayTimer = 2000 -- how long text floats in air
EOTI_HitNumbers.Draw.ScaleTimer = 80 -- text fly in size
EOTI_HitNumbers.Draw.ScaleFloat = 200 -- float size
EOTI_HitNumbers.Draw.YOffset = 90 -- how high above your target it floats

 -- Below values are based on ScreenScale (compensates for multiple resolution sizes)
 -- higher values = higher up in the left of the screen
 -- lower values = closer to centered on the screen
EOTI_HitNumbers.Combo.FontY = 28
EOTI_HitNumbers.Combo.FontDescY = 9
EOTI_HitNumbers.Combo.WindowX = 20
EOTI_HitNumbers.Combo.WindowY = 12
EOTI_HitNumbers.Combo.WindowTime = 5 -- How much time you have to read the combo window before it flies away.
EOTI_HitNumbers.Combo.Timer = 3 -- How much time between shots you have before your combo finishes.
EOTI_HitNumbers.Combo.ShakeIntensity = 0.5 -- How much the combo window shakes from multiple hits.
EOTI_HitNumbers.Combo.ShakeComboIntensity = 0.005 -- This intensifies shaking based on how many combos you have.

-- Colors for weapon attacks, alpha values will be ignored.
EOTI_HitNumbers.Color.Critical = Color(252,15,15)
EOTI_HitNumbers.Color.Bodyshot = Color(14,252,14)
EOTI_HitNumbers.Color.Headshot = Color(6,38,232)
EOTI_HitNumbers.Color.Limbshot = Color(255,241,29)
EOTI_HitNumbers.Color.NoDamage = Color(50,50,50)
EOTI_HitNumbers.Color.Boom = Color(252,157,10)
EOTI_HitNumbers.Color.Dead = Color(232,10,10)
EOTI_HitNumbers.Color.DRPGEvasion = Color(150,150,150) -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
EOTI_HitNumbers.Color.DRPGReflect = Color(232,10,232) -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)

-- Multipliers for hitting specific body parts, enabling these will override server settings.
EOTI_HitNumbers.Multiplier.Enable = false
EOTI_HitNumbers.Multiplier.Headshot = '200%' -- GMOD Default headshot damage is 200%
EOTI_HitNumbers.Multiplier.Bodyshot = '100%' -- GMOD Default torso / generic damage is 100%
EOTI_HitNumbers.Multiplier.Limbshot = '25%' -- GMOD Default leg / arm damage is 25%

-- Text displayed next to a hit.
EOTI_HitNumbers.Text.Headshot = 'Headshot! '
EOTI_HitNumbers.Text.Limbshot = 'Graze! '
EOTI_HitNumbers.Text.Bodyshot = 'Hit! '
EOTI_HitNumbers.Text.Critical = 'Critical '
EOTI_HitNumbers.Text.NoDamage = 'Immune! '
EOTI_HitNumbers.Text.Dead = 'Dead! '
EOTI_HitNumbers.Text.Boom = 'BOOM! '
EOTI_HitNumbers.Text.DRPGEvasion = 'Evasion!' -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
EOTI_HitNumbers.Text.DRPGReflect = 'Reflect!' -- DarkRPG2 Only (https://scriptfodder.com/scripts/view/2410)
















