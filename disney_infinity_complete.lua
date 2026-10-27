-- Disney Infinity Complete
-- Direct warps to the Marvel Battlegrounds (1.05) arenas,
-- prototype worlds, and instant swaps for all 11 unlocked figures.
-- Only worlds and actors present in the Steam release's archives are listed.

local MARVEL_BATTLEGROUNDS = {
    { "MBA_Campaign_Intro",   "Campaign prologue" },
    { "MBA_Campaign_Hub",     "Avengers HQ (hub)" },
    { "MBA_Side_Mission_Hub", "Side missions (hub)" },
    { "MBA_Tutorial",         "Combat tutorial" },
    { "MBA_Versus_Hub",       "Versus hub" },
    { "MBA_Asgard",           "Arena: Asgard" },
    { "MBA_Knowhere",         "Arena: Knowhere" },
    { "MBA_Wakanda",          "Arena: Wakanda" },
    { "MBA_LunarBase",        "Arena: Lunar Base" },
    { "MBA_Sewers",           "Arena: New York Sewers" },
    { "MBA_Trainyard",        "Arena: Trainyard" },
    { "MBA_Ultron",           "Arena: Ultron's Lair" },
    { "MBA_Cash_In_Screen",   "Rewards screen" },
}


local MOANA = {
    { "MOA_Motunui",               "Motunui (playset intro)" },
    { "MOA_Polatu",                "Polatu" },
    { "MOA_Tefiti",                "Te Fiti" },
    { "MOA_Ocean",                 "Ocean" },
    { "MOA_Motonui_Dungeon",       "Motunui dungeon" },
    { "MOA_Polatu_Dungeon",        "Polatu dungeon" },
    { "MOA_Tefiti_Dungeon",        "Te Fiti dungeon" },
    { "MOA_Beautiful_Corner_Cove", "Beautiful Corner Cove (unlisted level)" },
    { "MOA_Test_Stuff",            "Test room (unlisted level)" },
    { "MOA_Proto_Dungeon",         "Prototype dungeon (unlisted)" },
    { "Moana_Corner_Cove",         "Beautiful Corner Cove - on foot (Toy Box)" },
    { "moa_test_stuff_tb",         "Test room - on foot (Toy Box)" },
}

-- PlaysetZ, the cancelled Rogue One playset. Only Scarif ships.
local ROGUE_ONE = {
    { "PSZ_Barbados_TERRAIN",       "Scarif - surface" },
    { "PSZ_Barbados_INTERIOR",      "Scarif - interior" },
    { "PSZ_Barbados_SPACE",         "Scarif - orbit" },
    { "psz_bar_jungle_01",          "Jungle prototype" },
    { "Rouge_One_Scarif",           "Scarif surface - on foot (Toy Box)" },
    { "Rouge_One_Interior",         "Scarif interior - on foot (Toy Box)" },
}

local ALADDIN = {
    { "aladdin_palette",               "Art palette (Agrabah)" },
    { "aladdin_ribbon_whitebox",       "Ribbon level - whitebox" },
    { "aladdin_ribbon_whitebox_2_4_2", "Ribbon level - whitebox 2.4.2" },
    { "aladdinribbonedit",             "Ribbon edit" },
}

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
    { "psx_l1_planet_escape_hires_sd",        "Planet escape (high detail)" },
    { "reb_moonsystemtestbed_01",             "Rebels moon system test bed" },
    { "2_player_challenge_room2",             "Two-player challenge room" },
    { "chal_moon_pickup_proto",               "Moon pickup challenge prototype" },
    { "tat_assets",                           "Tatooine asset showcase" },
    { "proto_artset_tatooine",                "Tatooine art set prototype" },
}

local INSIDE_OUT_PROTOTYPES = {
    { "out_cloudintro",           "Cloud intro" },
    { "out_clouds",               "Clouds" },
    { "out_clouds2",              "Clouds 2" },
    { "out_lava_side2",           "Lava side-scroller 2" },
    { "out_lava_side4",           "Lava side-scroller 4" },
    { "out_lvl2_section1",        "Level 2 - section 1" },
    { "out_lvl2_section2",        "Level 2 - section 2" },
    { "out_lvl5_section1",        "Level 5 - section 1" },
    { "out_lvl7_section3",        "Level 7 - section 3" },
    { "out_lvl8_section1",        "Level 8 - section 1" },
    { "out_mark_sidescroll_v002", "Side-scroller v002" },
    { "out_mark_sidescroll_v003", "Side-scroller v003" },
    { "out_mark_sidescroll_v004", "Side-scroller v004" },
    { "out_mark_sidescroll_v005", "Side-scroller v005" },
}

-- Developer test rooms, biggest first. Tools, not levels: expect bare geometry.
local DEV_ROOMS = {
    { "holovlad", "Vlad's holo room (4.5 MB)" },
    { "mba_holo_art_test_tina", "Marvel Battlegrounds art test - Tina" },
    { "emp_tatt_01_scaletest", "Tatooine scale test" },
    { "holokelvinmgame_stealthtest02", "Stealth test 02" },
    { "hextile_distancespeed_test", "Hex tile distance/speed test" },
    { "wounddamagetest_01", "Wound damage test" },
    { "woundblockwindow", "Wound block window" },
    { "interiorlight_test", "Interior light test" },
    { "tat_building_comparison", "Tatooine building comparison" },
    { "logictest", "Logic test" },
    { "mba_holo_art_test_jeffs", "Marvel Battlegrounds art test - Jeff" },
    { "holokelvinmgame_forcetraversal", "Force traversal test" },
    { "hostclientnodetesting", "Host/client node testing" },
    { "holoned-race", "Ned's race room" },
    { "holokelvinmgame_meridiantests", "Meridian tests" },
    { "holojim", "Jim's holo room" },
    { "holocombat_nt", "Combat room (NT)" },
    { "holocombat", "Combat room" },
    { "holodoaction2", "Do-action room 2" },
    { "holosidekicks", "Sidekicks room" },
    { "holomission2", "Mission room 2" },
    { "tbx_building_logic1_bigger", "Toy Box logic building 1 (bigger)" },
    { "yaviniv_brick_corner", "Yavin IV brick corner" },
    { "holoned", "Ned's holo room" },
    { "tbx_building_logic3", "Toy Box logic building 3" },
    { "tbx_building_logic4", "Toy Box logic building 4" },
    { "jose_test_area", "Jose's test area" },
    { "holotylerc", "Tyler C's holo room" },
    { "holoactivities", "Activities room" },
    { "tat_outscource_assetpack", "Tatooine outsourced asset pack" },
    { "gog_automationtests_turrets", "Automation tests - turrets" },
    { "actormovertest", "Actor mover test" },
    { "tbx_building_logic2", "Toy Box logic building 2" },
    { "gog_automationtests_enemytests", "Automation tests - enemies" },
}

-- Known to crash or strand the session. Listed so they can still be tried.
local UNSAFE = {
    { "aladdin_lanes",                        "Aladdin lanes prototype - CRASHES on load" },
    { "psx_l1_planet_escape_hires_broken_sd", "Planet escape (high detail, \"broken\" build)" },
}

local TOY_BOX_PROTOTYPES = {
    { "sugarrushtest",               "Sugar Rush test" },
    { "RumpusRoom_cavesWorld",       "Caves world" },
    { "RumpusRoom_ledgeland",        "Ledge land" },
    { "TBX_Launch",                  "Launch world" },
    { "TBX_Transition",              "Transition world" },
    { "rumpusroom-marketing_pocket", "Marketing pocket room" },
    { "onehundred_geo",              "One hundred (geometry)" },
    { "missionshub",                 "Missions hub" },
    { "hubf",                        "Hub F" },
    { "hubd",                        "Hub D" },
    { "lab",                         "Lab" },
    { "sidescrolling2",              "Side-scrolling 2" },
    { "sidescrolling3",              "Side-scrolling 3" },
    { "tbx_toy_proving",             "Toy proving ground" },
}

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

    -- Unlocked Figures & Costumes
    { "TBX_Baloo",                  "Baloo" },
    { "TBX_Mickey_KingdomHearts",   "King Mickey (Kingdom Hearts)" },
    { "TBX_JudyHopps_MeterMaid",    "Judy Hopps (Meter Maid)" },
}

-- Defined further down (it needs the catalog helpers); declared here so launchLevel can call it.
local swapCharacter

-- Verbose tracing to loader.log ("[DI Complete][debug] ..."): world changes, warps, character swaps.
-- Set to false once the 1.06 import is stable.
local DEBUG = true
local bootClock = os and os.clock and os.clock() or 0

local function dbg(message)
    if DEBUG then
        local elapsed = (os and os.clock) and string.format("%.1f s", os.clock() - bootClock) or "?"
        Crabe.write("[DI Complete][debug] (" .. elapsed .. ") " .. message)
    end
end

-- Loads a world through the same path as the game's own level select.
local function launchLevel(levelName, label)
    dbg("warp requested: " .. levelName .. " (" .. label .. "), current world: " .. tostring(Game.CurrentWorld()))
    Game.LoadLevel(levelName, true)
    return "Loading: " .. label .. "..."
end

-- The Aladdin prototypes ship no sky and no lighting. They load as Toy Box
-- worlds, so the Agrabah sky (realms/tbx_ala_skydome) can be placed from the
-- Toy Box sky list -- once its lock is available, which nothing in the
-- shipped game does. The lock is not saved, so it is set on every warp.
local function launchAladdin(levelName, label)
    Game.SetLockAvailable("TBX_ALA_SKYDOME")
    return launchLevel(levelName, label) .. " (Agrabah sky unlocked in the Toy Box skies)"
end

-- Unreleased objects whose model ships in the Steam archives (a .dnax in
-- characters.zip plus the model archive). Most unreleased characters ship as
-- a .dnax alone, and the in4 source holds definitions without art, so these
-- are what can be shown. Created in front of the player, never saved.
local SPAWNABLES = {
    { "psz_pufferpig",             "Puffer pig (Rogue One, 140 animations)" },
    { "psz_remotedrone",           "Remote spy drone (Rogue One)" },
    { "moa_fishhook",              "Maui's fish hook (Moana)" },
    { "moa_lantern",               "Lantern (Moana)" },
    { "moa_maui",                  "Maui as a statue (no textures, no animations)" },
    { "sr_cart_vanellope",         "Vanellope's kart (Sugar Rush)" },
    { "sr_cart_vanellope_monster", "Vanellope's kart, monster version" },
    { "sr_cart_king",              "King Candy's kart (Sugar Rush)" },
    { "sr_cart_king_monster",      "King Candy's kart, monster version" },
}

local function spawnObject(name, label)
    local built = Game.SpawnActorNearPlayer("DNAFile=characters/" .. name .. ".dnax", 1, 4)
    dbg("spawn " .. name .. ": engine built " .. tostring(built))
    if built > 0 then return "Spawned: " .. label end
    return "The engine built nothing for " .. name
end

-- Resolves the sku_id from the name: the catalog row for shipped characters,
-- the loader's allocation for exposed ones. A hardcoded id would drift out of
-- sync as soon as the loader moves one to a free slot.
swapCharacter = function(name, label)
    local row = Crabe.VirtualReader.findCharacter(name)
    local sku = (row and row.sku_id) or Crabe.VirtualReader.skuForName(name)
    dbg("swap " .. name .. ": catalog row " .. (row and "found" or "missing") .. ", sku " .. tostring(sku))
    if not sku then
        return "No sku_id for " .. name
    end
    Game.SetCharacter(sku, "loadout")
    dbg("Game.SetCharacter(" .. tostring(sku) .. ", loadout) done")
    return "Now playing: " .. label
end

-- One menu entry per { key, label } row, each calling `run(key, label)`.
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
            { label = "Marvel Battlegrounds (1.05) >",
              submenu = { title = "MARVEL BATTLEGROUNDS", items = entries(MARVEL_BATTLEGROUNDS, launchLevel) } },
            { label = "Moana (unreleased) >",
              submenu = { title = "MOANA", items = entries(MOANA, launchLevel) } },
            { label = "Cut content >",
              submenu = {
                  title = "CUT CONTENT",
                  items = {
                      { label = "Rogue One - Scarif (unreleased) >",
                        submenu = { title = "ROGUE ONE", items = entries(ROGUE_ONE, launchLevel) } },
                      { label = "Aladdin (cancelled) >",
                        submenu = { title = "ALADDIN", items = entries(ALADDIN, launchAladdin) } },
                      { label = "Star Wars cut content >",
                        submenu = { title = "STAR WARS CUT CONTENT", items = entries(STAR_WARS_CUT, launchLevel) } },
                      { label = "Inside Out prototypes >",
                        submenu = { title = "INSIDE OUT PROTOTYPES", items = entries(INSIDE_OUT_PROTOTYPES, launchLevel) } },
                      { label = "Toy Box & Sugar Rush prototypes >",
                        submenu = { title = "TOY BOX PROTOTYPES", items = entries(TOY_BOX_PROTOTYPES, launchLevel) } },
                      { label = "Spawn unreleased objects >",
                        submenu = { title = "SPAWN UNRELEASED OBJECTS", items = entries(SPAWNABLES, spawnObject) } },
                      { label = "Dev rooms >",
                        submenu = { title = "DEV ROOMS", items = entries(DEV_ROOMS, launchLevel) } },
                      { label = "Unsafe (may crash) >",
                        submenu = { title = "UNSAFE - MAY CRASH", items = entries(UNSAFE, launchLevel) } },
                  },
              } },
            { label = "Play as a hero (instant swap) >",
              submenu = { title = "CHOOSE A HERO", items = heroItems } },
        },
    },
})

-- Prototype worlds that ship without a sky, and the realm that gives them one
-- (sky and lighting). Applied once per world, a few seconds after it is up.
local WORLD_SKIES = {
    aladdin_palette = "tbx_ala_skydome",
    aladdin_ribbon_whitebox = "tbx_ala_skydome",
    aladdin_ribbon_whitebox_2_4_2 = "tbx_ala_skydome",
    aladdinribbonedit = "tbx_ala_skydome",
    -- Speedway race hub prototypes: the Toy Box vehicle hub sky.
    hubf = "tbx_vhub_skydome",
    hubd = "tbx_vhub_skydome",
}
local SKY_DELAY = 3
local skyWait = 0

-- Each world load builds a new Lua state and reruns this file, so the wait
-- starts over for every world. Game.LoadSkyDome needs CrabeLoader > 1.0.0.
if type(Game.LoadSkyDome) == "function" then
    Game.onTick(function(dt)
        if skyWait < 0 then return end
        skyWait = skyWait + (dt or 0.016)
        if skyWait < SKY_DELAY then return end
        skyWait = -1

        local world = Game.CurrentWorld()
        local sky = type(world) == "string" and WORLD_SKIES[world:lower()]
        dbg("sky check for world " .. tostring(world) .. ": " .. (sky and ("sky " .. sky) or "no sky override"))
        if sky then
            local loaded = Game.LoadSkyDome(sky)
            Crabe.write("[DI Complete] " .. world .. ": sky " .. sky
                .. (loaded and " loaded." or " could not be loaded (see loader.log)."))
        end
    end)
end

-- Debug: logs every world change seen by the script thread, and a heartbeat every 10 s while it stays the same,
-- so a stalled boot or load shows where it stopped.
if DEBUG then
    local lastWorld, sinceChange, sinceBeat = nil, 0, 0
    Game.onTick(function(dt)
        local step = dt or 0.016
        sinceChange, sinceBeat = sinceChange + step, sinceBeat + step
        local world = tostring(Game.CurrentWorld())
        if world ~= lastWorld then
            dbg("world changed: " .. tostring(lastWorld) .. " -> " .. world .. " (after " .. string.format("%.1f", sinceChange) .. " s)")
            lastWorld, sinceChange, sinceBeat = world, 0, 0
        elseif sinceBeat >= 10 then
            dbg("still in world " .. world .. " (" .. string.format("%.0f", sinceChange) .. " s)")
            sinceBeat = 0
        end
    end)
end

Crabe.Events.on("init", function()
    Crabe.write("[DI Complete] Disney Infinity Complete v1.0.0 active.")
    dbg("init: world " .. tostring(Game.CurrentWorld()) .. ", update_106 native plugin "
        .. tostring(Crabe.Plugins and Crabe.Plugins.get and Crabe.Plugins.get("update_106.native")))
end)
