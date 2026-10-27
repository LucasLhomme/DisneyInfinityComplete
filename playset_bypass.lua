-- Disney Infinity Complete -- "Any Character in Any Playset"
--
-- Port of AaBysT's "Anyone Can Cook II" executable patch to CrabeLoader,
-- extended to the Finding Dory and Marvel Battlegrounds playsets.
--
-- Native patches:
--   S1    ValidateCurrentCharacter no longer resets the character (jnz -> jmp)
--   S2-S5 no forced playset character (Empire / InsideOut / TheCloneWars / PlaysetX)
--   S6    VirtualReaderPC_GetBrandFromCurrentPlaySet returns nothing (Lua sees nil)
--   S7    IGPGameFlow::IsAvatarValid returns true (no brand/playset validity check)
--   S8    IGPGameFlow::IsMatchingPlaysets returns true (any character in any playset)
--   S9    IGPGameFlow::MissingAvatarCheck skips the DialogType_MissingAvatarQuit popup
--   S10   VirtualReaderPC_GetItemByPage: zone filter off (every character listed)
--   S11   VirtualReaderPC_GetItemByPage: lock filter off (every character selectable)

local Bypass = {}

local SIGNATURES = {
    { name = "S1 ValidateCurrentCharacter", offset = 16,
      pattern = "8B 87 B0 00 00 00 50 8B CF E8 ?? ?? ?? ?? 84 C0 75 0A C7 87 B0 00 00 00 FF FF FF FF 5E 5F 5B C3",
      patched = "8B 87 B0 00 00 00 50 8B CF E8 ?? ?? ?? ?? 84 C0 EB 0A C7 87 B0 00 00 00 FF FF FF FF 5E 5F 5B C3",
      original = "75", bytes = "EB" },
    { name = "S2 Playset Empire", offset = 21,
      pattern = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0B 8B 87 20 01 00 00 E9 ?? ?? ?? ??",
      patched = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0B 83 C8 FF 90 90 90 E9 ?? ?? ?? ??",
      original = "8B 87 20 01 00 00", bytes = "83 C8 FF 90 90 90" },
    { name = "S3 Playset InsideOut", offset = 21,
      pattern = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0E 8B 8F 24 01 00 00 89 8F B4 00 00 00",
      patched = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0E 83 C9 FF 90 90 90 89 8F B4 00 00 00",
      original = "8B 8F 24 01 00 00", bytes = "83 C9 FF 90 90 90" },
    { name = "S4 Playset TheCloneWars", offset = 21,
      pattern = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0E 8B 97 28 01 00 00 89 97 B4 00 00 00",
      patched = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0E 83 CA FF 90 90 90 89 97 B4 00 00 00",
      original = "8B 97 28 01 00 00", bytes = "83 CA FF 90 90 90" },
    { name = "S5 Playset PlaysetX", offset = 21,
      pattern = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0C 8B 87 2C 01 00 00 89 87 B4 00 00 00",
      patched = "68 ?? ?? ?? ?? E8 ?? ?? ?? ?? 8B CE E8 ?? ?? ?? ?? 84 C0 74 0C 83 C8 FF 90 90 90 89 87 B4 00 00 00",
      original = "8B 87 2C 01 00 00", bytes = "83 C8 FF 90 90 90" },
    { name = "S6 GetBrandFromCurrentPlaySet", offset = 0,
      pattern = "64 A1 00 00 00 00 6A FF 68 ?? ?? ?? ?? 50 64 89 25 00 00 00 00 83 EC 0C 56 8D 71 20 57 85 F6 0F 84 ?? ?? ?? ?? 8B 81 E4 00 00 00",
      patched = "33 C0 C2 04 00 00 6A FF 68 ?? ?? ?? ?? 50 64 89 25 00 00 00 00 83 EC 0C 56 8D 71 20 57 85 F6 0F 84 ?? ?? ?? ?? 8B 81 E4 00 00 00",
      original = "64 A1 00 00", bytes = "33 C0 C2 04" },
    { name = "S7 IsAvatarValid", offset = 0,
      pattern = "64 A1 00 00 00 00 6A FF 68 ?? ?? ?? ?? 50 64 89 25 00 00 00 00 53 55 56 57 8B 7C 24 24 8B F1 85",
      patched = "B0 01 C2 14 00 00 6A FF 68 ?? ?? ?? ?? 50 64 89 25 00 00 00 00 53 55 56 57 8B 7C 24 24 8B F1 85",
      original = "64 A1 00 00 00", bytes = "B0 01 C2 14 00" },
    { name = "S8 IsMatchingPlaysets", offset = 0,
      pattern = "6A FF 64 A1 00 00 00 00 68 ?? ?? ?? ?? 50 8B 44 24 18 64 89 25 00 00 00 00 83 EC 28 53 55 56 33",
      patched = "B0 01 C2 0C 00 00 00 00 68 ?? ?? ?? ?? 50 8B 44 24 18 64 89 25 00 00 00 00 83 EC 28 53 55 56 33",
      original = "6A FF 64 A1 00", bytes = "B0 01 C2 0C 00" },
    { name = "S9 MissingAvatarQuitBypass", offset = 8,
      pattern = "8B 4E 08 83 7C B9 0C 00 74 3A 8B 56 0C 8B 44 BA 0C 85 C0 75 18",
      patched = "8B 4E 08 83 7C B9 0C 00 EB 23 8B 56 0C 8B 44 BA 0C 85 C0 75 18",
      original = "74 3A", bytes = "EB 23" },
    { name = "S10 GridZoneFilterBypass", offset = 10,
      pattern = "56 8B CF E8 ?? ?? ?? ?? 84 C0 74 28 8D 44 24 64 50 8D 4C 24 58",
      patched = "56 8B CF E8 ?? ?? ?? ?? 84 C0 90 90 8D 44 24 64 50 8D 4C 24 58",
      original = "74 28", bytes = "90 90" },
    { name = "S11 GridLockFilterBypass", offset = 10,
      pattern = "56 8B CF E8 ?? ?? ?? ?? 84 C0 74 12 8D 54 24 10 52",
      patched = "56 8B CF E8 ?? ?? ?? ?? 84 C0 90 90 8D 54 24 10 52",
      original = "74 12", bytes = "90 90" },
}

local GRID_METHODS = {
    "PressedBaseFilterButton",
    "GetCurrentFilterString",
    "SetFilterButtonData",
    "PopulateFilterRow",
    "SelectFilterItem",
}

-- Keys identifying Playset ActorList chunks so that all playsets receive Dory,
-- Nemo, and Toy Box avatars in their Data.Records table:
--   Universal: "ActorList"
--   Finding Dory: "DOR_EnemyFish.dnax"
--   Star Wars: Twilight of the Republic: "tcw_anakin_ps"
--   Star Wars: Rise Against the Empire: "emp_luke_ps"
--   Inside Out: "out_joy_ps"
--   Star Wars: The Force Awakens (PlaysetX): "psx_emmitt_ps"
--   Marvel Battlegrounds: "avg_captainamericamba"
local PLAYSET_ACTORLIST_KEYS = {
    "ActorList",
    "DOR_EnemyFish.dnax",
    "tcw_anakin_ps",
    "emp_luke_ps",
    "out_joy_ps",
    "psx_emmitt_ps",
    "avg_captainamericamba",
}

local STORE_FILE = "playset_bypass.json"
local storage = Crabe.Storage.forMod("disney_infinity_complete")

-- The game's own globals. Inside the mod sandbox `_G` is a read-only proxy:
-- rawget on it finds nothing and rawset only writes the proxy, so the Lua layer
-- below silently never applied while it read _G. The thread's environment is
-- the real table.
local Globals = getfenv(0)

local enabled = false
local sites = {}
local luaState = { brandOriginal = nil, gridClass = nil }

local function log(msg)
    Crabe.write("[PlaysetBypass] " .. msg)
end

-- Native layer ---------------------------------------------------------------

-- Address of a patch site, found clean or already patched, cached once known.
local function locate(sig)
    if sites[sig.name] then return sites[sig.name] end
    local addr = Crabe.Memory.patternScan(sig.pattern) or Crabe.Memory.patternScan(sig.patched)
    if addr then sites[sig.name] = addr + sig.offset end
    return sites[sig.name]
end

-- Writes every site to its patched or original bytes; returns done, total.
local function writeAll(wantPatched)
    local done = 0
    for _, sig in ipairs(SIGNATURES) do
        local addr = locate(sig)
        if not addr then
            log(sig.name .. ": signature not found (other game build?), skipped")
        elseif Crabe.Memory.patchBytes(addr, wantPatched and sig.bytes or sig.original) then
            done = done + 1
        else
            log(string.format("%s: patchBytes failed at 0x%08X", sig.name, addr))
        end
    end
    log(string.format("%s %d/%d native sites", wantPatched and "patched" or "restored", done, #SIGNATURES))
    return done, #SIGNATURES
end

-- Lua layer ------------------------------------------------------------------

local function noBrand() return nil end

-- The character grid reads these two tables unguarded; with the filters off
-- they can be missing, which used to crash the grid.
local function ensureGridInvariants(self)
    if type(self.filterButtonTextArray) ~= "table" then self.filterButtonTextArray = {} end
    if type(self.staticFilterData) ~= "table" then self.staticFilterData = {} end
end

local function hardenGrid(cls)
    local originalEnter = cls.onEnter
    cls.onEnter = function(self, ...)
        self.filterButtonTextArray = {}
        self.staticFilterData = self.staticFilterData or {}
        return originalEnter(self, ...)
    end
    for _, name in ipairs(GRID_METHODS) do
        local original = cls[name]
        if type(original) == "function" then
            cls[name] = function(self, ...)
                ensureGridInvariants(self)
                return original(self, ...)
            end
        end
    end
end

-- Tags every catalog row as Dory-compatible once, so the Finding Dory filter
-- lists every character.
local function tagAllCharactersForDory()
    local vrData = rawget(Globals, "VirtualReaderPC_Data")
    if type(vrData) ~= "table" or type(vrData.AvatarData) ~= "table" or vrData._doryTagged then return end
    vrData._doryTagged = true
    for _, row in ipairs(vrData.AvatarData) do
        if type(row) == "table" and row.MetaData and not string.find(row.MetaData, "Dory") then
            row.MetaData = row.MetaData .. ",Dory,DOR"
        end
    end
end

-- Re-applied every tick: the game reloads these globals when screens reload.
local function applyLuaLayer()
    -- 1. Neutralize Disney's Onboard Tutorial (which intentionally disables Back/Escape in Win32 menus)
    if rawget(Globals, "UI_IsOnboardTutorialActive") ~= nil then
        rawset(Globals, "UI_IsOnboardTutorialActive", function() return false end)
    end
    if rawget(Globals, "UI_ShouldOnboardTutorialRestrictInput") ~= nil then
        rawset(Globals, "UI_ShouldOnboardTutorialRestrictInput", function() return false end)
    end

    local current = rawget(Globals, "VirtualReaderPC_GetBrandFromCurrentPlaySet")
    if type(current) == "function" and current ~= noBrand then
        luaState.brandOriginal = current
        rawset(Globals, "VirtualReaderPC_GetBrandFromCurrentPlaySet", noBrand)
    end
    local grid = rawget(Globals, "VirtualReaderPC_GridBase")
    if type(grid) == "table" and grid ~= luaState.gridClass and type(grid.onEnter) == "function" then
        hardenGrid(grid)
        luaState.gridClass = grid
    end

    local vrpc = rawget(Globals, "VirtualReaderPC")
    if type(vrpc) == "table" and type(vrpc.IsOnboardTutorialActive) == "function" then
        vrpc.IsOnboardTutorialActive = function() return false end
    end

    local loadout = rawget(Globals, "VirtualReaderPC_Loadout")
    if type(loadout) == "table" then
        if loadout.IsOnboardTutorialActive ~= nil then
            loadout.IsOnboardTutorialActive = function() return false end
        end
        if type(loadout.ScreenDefinition) == "table" then
            loadout.ScreenDefinition.doLuaInput = true
        end
        if type(loadout.HandleCloseButton) == "function" and not loadout._crabeNavPatched then
            loadout._crabeNavPatched = true
            local origClose = loadout.HandleCloseButton
            loadout.HandleCloseButton = function(self)
                if not self.hitContinue then
                    if self.loadUGCHandle ~= nil then
                        local h = UI.GetHandleFromName(self.loadUGCHandle, self.InstanceData.playerNum)
                        if h ~= UI.INVALID_UI_HANDLE then
                            self:CallScreenFunctionByScreenName(self.loadUGCHandle, self.InstanceData.playerNum, "SetScreenActive", true)
                            self:CallScreenFunctionByScreenName(self.loadUGCHandle, self.InstanceData.playerNum, "SetFocus", true)
                        end
                    else
                        local psHandle = UI.GetHandleFromName("PlaysetSelectMenu", 0)
                        if psHandle ~= UI.INVALID_UI_HANDLE then
                            self:CallScreenFunctionByScreenName("PlaysetSelectMenu", self.InstanceData.playerNum, "SetScreenActive", true)
                            self:CallScreenFunctionByScreenName("PlaysetSelectMenu", self.InstanceData.playerNum, "SetFocus", true)
                        else
                            local plHandle = UI.GetHandleFromName("PlaysetListWin32", 0)
                            if plHandle ~= UI.INVALID_UI_HANDLE then
                                self:CallScreenFunctionByScreenName("PlaysetListWin32", self.InstanceData.playerNum, "SetScreenActive", true)
                                self:CallScreenFunctionByScreenName("PlaysetListWin32", self.InstanceData.playerNum, "SetFocus", true)
                            end
                        end
                    end
                end
                origClose(self)
            end
        end
    end

    local tabs = rawget(Globals, "VirtualReaderPC_Tabs")
    if type(tabs) == "table" and tabs.IsOnboardTutorialActive ~= nil then
        tabs.IsOnboardTutorialActive = function() return false end
    end

    local plw = rawget(Globals, "PlaysetListWin32")
    if type(plw) == "table" and type(plw.GoBack) == "function" and not plw._crabeNavPatched then
        plw._crabeNavPatched = true
        plw.GoBack = function(self)
            if self.cloudLoadStarted then return end
            self:RequestExit()
        end
    end

    local mb = rawget(Globals, "MenuBase")
    if type(mb) == "table" and type(mb.GoBack) == "function" and not mb._crabeNavPatched then
        mb._crabeNavPatched = true
        mb.GoBack = function(self)
            self:RequestExit()
        end
    end

    local charGrid = rawget(Globals, "VirtualReaderPC_GridCharacter")
    if type(charGrid) == "table" and charGrid.IsOnboardTutorialActive ~= nil then
        charGrid.IsOnboardTutorialActive = function() return false end
    end

    tagAllCharactersForDory()
end

local function removeLuaLayer()
    if luaState.brandOriginal and rawget(Globals, "VirtualReaderPC_GetBrandFromCurrentPlaySet") == noBrand then
        rawset(Globals, "VirtualReaderPC_GetBrandFromCurrentPlaySet", luaState.brandOriginal)
    end
    luaState.brandOriginal = nil
end

-- Lets every avatar spawn in all playsets (see dory_avatars_patch.lua).
local function installPlaysetActorPatches()
    local doryPatch = require("mods.disney_infinity_complete.dory_avatars_patch")
    local swim = Crabe.Plugins and Crabe.Plugins.get and Crabe.Plugins.get("update_106.swim_mode") == "1"
    local source = doryPatch.getSource(swim)
    for _, key in ipairs(PLAYSET_ACTORLIST_KEYS) do
        Crabe.Hooks.patchChunk(key, source)
    end
    log("registered playset actorlist chunk patches for all playsets (Dory swim rigs: " .. tostring(swim) .. ")")
end
local installDoryActorPatch = installPlaysetActorPatches

-- Only the actor lists, for when CrabeMenu owns the bypass itself.
function Bypass.installActorPatches()
    installDoryActorPatch()
end

-- Public API -----------------------------------------------------------------

function Bypass.isEnabled() return enabled end

function Bypass.setEnabled(on)
    on = on and true or false
    local done, total = writeAll(on)
    if on then applyLuaLayer() else removeLuaLayer() end
    enabled = on
    storage.save(STORE_FILE, { enabled = on })
    if on then
        return string.format("Any Character: ON (%d/%d patches)", done, total)
    end
    return "Any Character: OFF (original game)"
end

local tickInstalled = false

function Bypass.init()
    local saved = storage.load(STORE_FILE)
    if not (type(saved) == "table" and saved.enabled == false) then
        Bypass.setEnabled(true)
    end
    installDoryActorPatch()
    if not tickInstalled then
        tickInstalled = true
        Game.onTick(function()
            if enabled then applyLuaLayer() end
        end)
    end
end

return Bypass
