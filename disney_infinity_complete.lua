-- Disney Infinity Complete v1.0.0
-- 11 Unlocked Figures & Costumes + Experimental DI 3.0 Cut Content & Prototypes.
-- Clean in-memory injection via CrabeLoader.

-- ============================================================================
-- 1. PLAYABLE CHARACTERS (11 Fully Functional Figures)
-- ============================================================================
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

-- ============================================================================
-- 2. EXPERIMENTAL CUT CONTENT & PROTOTYPES (DI 3.0 abandoned assets)
-- ============================================================================

-- Loads a world safely
local function launchLevel(levelName, label)
    Game.LoadLevel(levelName, true)
    return "Loading: " .. label .. "..."
end

-- Rogue One - Scarif (Unreleased PlaysetZ for DI 3.0)
local ROGUE_ONE = {
    { "PSZ_Barbados_TERRAIN",       "Scarif - surface" },
    { "PSZ_Barbados_INTERIOR",      "Scarif - interior" },
    { "PSZ_Barbados_SPACE",         "Scarif - orbit" },
    { "psz_bar_jungle_01",          "Jungle prototype" },
    { "Rouge_One_Scarif",           "Scarif surface - on foot (Toy Box)" },
    { "Rouge_One_Interior",         "Scarif interior - on foot (Toy Box)" },
}

-- Aladdin cancelled prototype levels
local ALADDIN = {
    { "aladdin_palette",               "Art palette (Agrabah)" },
    { "aladdin_ribbon_whitebox",       "Ribbon level - whitebox" },
    { "aladdin_ribbon_whitebox_2_4_2", "Ribbon level - whitebox 2.4.2" },
    { "aladdinribbonedit",             "Ribbon edit" },
}

local function launchAladdin(levelName, label)
    Game.SetLockAvailable("TBX_ALA_SKYDOME")
    return launchLevel(levelName, label) .. " (Agrabah sky unlocked)"
end

-- Star Wars 3.0 cut challenges and test scenes
local STAR_WARS_CUT = {
    { "TCW_Chal03_IceFire",                   "Clone Wars challenge - Ice & Fire" },
    { "TCW_Chal01_DeathStar",                 "Clone Wars challenge - Death Star" },
    { "TCW_Chal04_Rock",                      "Clone Wars challenge - Rock" },
    { "tcw_challengemoons",                   "Clone Wars challenge moons" },
    { "tcw_cor_jeditemplemarketing",          "Jedi Temple (marketing)" },
    { "geonosis_geometry_wip",                "Geonosis (work in progress)" },
    { "deathstar_throneroom14_1",             "Death Star throne room v14" },
    { "deathstar_throneroom15",               "Death Star throne room v15" },
    { "EMP_Endor_Main",                       "Endor" },
    { "emp_hoth_render",                      "Hoth (render scene)" },
    { "reb_moonsystemtestbed_01",             "Rebels moon system test bed" },
    { "tat_assets",                           "Tatooine asset showcase" },
    { "proto_artset_tatooine",                "Tatooine art set prototype" },
}

-- Inside Out prototype 2D/3D platformer sections
local INSIDE_OUT_PROTOTYPES = {
    { "out_cloudintro",           "Cloud intro" },
    { "out_clouds",               "Clouds" },
    { "out_clouds2",              "Clouds 2" },
    { "out_lava_side2",           "Lava side-scroller 2" },
    { "out_lava_side4",           "Lava side-scroller 4" },
    { "out_lvl2_section1",        "Level 2 - section 1" },
    { "out_lvl5_section1",        "Level 5 - section 1" },
    { "out_mark_sidescroll_v002", "Side-scroller v002" },
    { "out_mark_sidescroll_v003", "Side-scroller v003" },
}

-- Toy Box early prototypes & race hubs
local TOY_BOX_PROTOTYPES = {
    { "sugarrushtest",               "Sugar Rush test" },
    { "RumpusRoom_cavesWorld",       "Caves world" },
    { "RumpusRoom_ledgeland",        "Ledge land" },
    { "TBX_Launch",                  "Launch world" },
    { "TBX_Transition",              "Transition world" },
    { "onehundred_geo",              "One hundred (geometry)" },
    { "hubf",                        "Speedway race hub prototype F" },
    { "hubd",                        "Speedway race hub prototype D" },
    { "lab",                         "Lab" },
    { "sidescrolling2",              "Side-scrolling 2" },
    { "tbx_toy_proving",             "Toy proving ground" },
}

-- Developer test rooms
local DEV_ROOMS = {
    { "holovlad",                    "Vlad's holo room (4.5 MB)" },
    { "emp_tatt_01_scaletest",        "Tatooine scale test" },
    { "wounddamagetest_01",          "Wound damage test" },
    { "interiorlight_test",          "Interior light test" },
    { "tat_building_comparison",     "Tatooine building comparison" },
    { "holocombat_nt",               "Combat room (NT)" },
    { "holocombat",                  "Combat room" },
    { "holosidekicks",               "Sidekicks room" },
    { "holomission2",                "Mission room 2" },
    { "tbx_building_logic1_bigger",  "Toy Box logic building" },
    { "yaviniv_brick_corner",        "Yavin IV brick corner" },
    { "tat_outscource_assetpack",    "Tatooine outsourced asset pack" },
}

-- Unreleased 3.0 objects spawned near player
local SPAWNABLES = {
    { "psz_pufferpig",             "Puffer pig (Rogue One, 140 animations)" },
    { "psz_remotedrone",           "Remote spy drone (Rogue One)" },
    { "sr_cart_vanellope",         "Vanellope's kart (Sugar Rush)" },
    { "sr_cart_vanellope_monster", "Vanellope's kart, monster version" },
    { "sr_cart_king",              "King Candy's kart (Sugar Rush)" },
    { "sr_cart_king_monster",      "King Candy's kart, monster version" },
}

local function spawnObject(name, label)
    local built = Game.SpawnActorNearPlayer("DNAFile=characters/" .. name .. ".dnax", 1, 4)
    if built > 0 then return "Spawned: " .. label end
    return "The engine built nothing for " .. name
end

-- Skybox fix for Aladdin prototypes
local WORLD_SKIES = {
    aladdin_palette = "tbx_ala_skydome",
    aladdin_ribbon_whitebox = "tbx_ala_skydome",
    aladdin_ribbon_whitebox_2_4_2 = "tbx_ala_skydome",
    aladdinribbonedit = "tbx_ala_skydome",
    hubf = "tbx_vhub_skydome",
    hubd = "tbx_vhub_skydome",
}

if type(Game.LoadSkyDome) == "function" then
    local skyWait = 0
    Game.onTick(function(dt)
        if skyWait < 0 then return end
        skyWait = skyWait + (dt or 0.016)
        if skyWait < 3 then return end
        skyWait = -1

        local world = Game.CurrentWorld()
        local sky = type(world) == "string" and WORLD_SKIES[world:lower()]
        if sky then
            Game.LoadSkyDome(sky)
        end
    end)
end

-- ============================================================================
-- 3. MENU CONSTRUCTION
-- ============================================================================
local function entries(rows, run)
    local items = {}
    for _, row in ipairs(rows) do
        local key, label = row[1], row[2]
        items[#items + 1] = { label = label .. " >", action = function() return run(key, label) end }
    end
    return items
end

local heroItems = entries(HEROES, swapCharacter)

Crabe.Menu.register({
    label = "Disney Infinity Complete",
    submenu = {
        title = "DISNEY INFINITY COMPLETE",
        items = {
            { label = "Play as a hero (instant swap) >",
              submenu = { title = "CHOOSE A HERO", items = heroItems } },
            { label = "Cut content & Prototypes (Experimental) >",
              submenu = {
                  title = "EXPERIMENTAL CUT CONTENT",
                  items = {
                      { label = "Rogue One - Scarif (PlaysetZ) >",
                        submenu = { title = "ROGUE ONE - SCARIF", items = entries(ROGUE_ONE, launchLevel) } },
                      { label = "Aladdin prototypes (Agrabah) >",
                        submenu = { title = "ALADDIN PROTOTYPES", items = entries(ALADDIN, launchAladdin) } },
                      { label = "Star Wars cut challenges >",
                        submenu = { title = "STAR WARS CUT CONTENT", items = entries(STAR_WARS_CUT, launchLevel) } },
                      { label = "Inside Out prototypes >",
                        submenu = { title = "INSIDE OUT PROTOTYPES", items = entries(INSIDE_OUT_PROTOTYPES, launchLevel) } },
                      { label = "Toy Box & Sugar Rush prototypes >",
                        submenu = { title = "TOY BOX PROTOTYPES", items = entries(TOY_BOX_PROTOTYPES, launchLevel) } },
                      { label = "Spawn unreleased objects >",
                        submenu = { title = "SPAWN UNRELEASED OBJECTS", items = entries(SPAWNABLES, spawnObject) } },
                      { label = "Dev rooms >",
                        submenu = { title = "DEV ROOMS", items = entries(DEV_ROOMS, launchLevel) } },
                  },
              } },
        },
    },
})

-- Register directly in the native 'Heroes' category if available
if Crabe.Menu.registerInCategory then
    for _, item in ipairs(heroItems) do
        Crabe.Menu.registerInCategory("Heroes", item)
    end
end

Crabe.Events.on("init", function()
    Crabe.write("[DI Complete] Disney Infinity Complete v1.0.0 active (11 heroes + cut content).")
end)
