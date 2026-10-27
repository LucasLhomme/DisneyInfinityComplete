-- Disney Infinity Complete v1.0.0
-- Instant hero swap and unlocks for all 11 official hidden/unreleased figures & costumes.
-- Clean in-memory injection via CrabeLoader.

local HEROES = {
    -- Marvel Battlegrounds (1.05)
    { "AVG_BlackPanther",           "Black Panther" },
    { "AVG_AntMan",                 "Ant-Man" },
    { "AVG_Vision",                 "Vision" },
    { "AVG_CaptainAmerica_CW",      "Captain America (Civil War)" },
    { "SPD_Spiderman_Black",        "Spider-Man (Black Suit)" },

    -- Alice Through the Looking Glass (1.06)
    { "ALI_Alice",                  "Alice" },
    { "ALI_MadHatter",              "The Mad Hatter" },
    { "ALI_Time",                   "Time" },

    -- Unlocked 3.0 Figures & Exclusive Costumes
    { "TBX_Baloo",                  "Baloo" },
    { "TBX_Mickey_KingdomHearts",   "King Mickey (Kingdom Hearts)" },
    { "TBX_JudyHopps_MeterMaid",    "Judy Hopps (Meter Maid)" },
}

-- Resolves the sku_id from the character name through the VirtualReader catalog.
local function swapCharacter(name, label)
    local row = Crabe.VirtualReader.findCharacter(name)
    local sku = (row and row.sku_id) or Crabe.VirtualReader.skuForName(name)
    if not sku then
        return "No sku_id found for " .. name
    end
    Game.SetCharacter(sku, "loadout")
    return "Now playing: " .. label
end

-- Build menu entries for the F5 in-game menu
local heroItems = {}
for _, row in ipairs(HEROES) do
    local key, label = row[1], row[2]
    heroItems[#heroItems + 1] = {
        label = label .. " >",
        action = function() return swapCharacter(key, label) end
    }
end

-- Register dedicated menu in F5
Crabe.Menu.register({
    label = "Disney Infinity Complete",
    submenu = {
        title = "CHOOSE A HERO",
        items = heroItems,
    },
})

-- Also register directly in the native 'Heroes' category if available
if Crabe.Menu.registerInCategory then
    for _, item in ipairs(heroItems) do
        Crabe.Menu.registerInCategory("Heroes", item)
    end
end

Crabe.Events.on("init", function()
    Crabe.write("[DI Complete] Disney Infinity Complete v1.0.0 active (11 heroes registered).")
end)
