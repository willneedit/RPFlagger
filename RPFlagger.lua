local DEBUG =
function() end
-- d

local function _tr(str)
	return str
end

RPFlagger = {}

RPFlagger.LAM = LibStub:GetLibrary("LibAddonMenu-2.0")

RPFlagger.name = "RPFlagger"
RPFlagger.loadedAddons = {}

function RPFlagger:help()	
	-- CHAT_SYSTEM:AddMessage("/im listrules - list the rules currently defined")
	-- CHAT_SYSTEM:AddMessage("/im dryrun    - show what the currently defined rules would do to your inventory")
end

function RPFlagger:SlashCommand(argv)
    local options = {}
    local searchResult = { string.match(argv,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = string.lower(v)
        end
    end
	
	if #options == 0 or options[1] == "help" then
		self:help()
	else
		CHAT_SYSTEM:AddMessage("Unknown parameter '" .. argv .. "'")
	end
end

RPFlagger.UI = { }
RPFlagger.UI.Settings = { }

local Settings = RPFlagger.UI.Settings

function RPFlagger:InitializeUI()
	local panelData = {
		type = "panel",
		name = "RPFlagger",
		registerForRefresh = true,	--boolean (optional) (will refresh all options controls when a setting is changed and when the panel is shown)
	}	
		
	local mainPanel = {
		{
			type = "description",
			text = _tr("To have a flag set for others in your guild to be shown, you need to enclose the text in '##RP: ##', for example, '##RP: God amongst mortals ##'. For retrieving purposes, the list in the settings below denote the order of your guilds which are scanned for the other player's flag"),
		},
		{
			type = "submenu",
			name = _tr("Settings"),
			tooltip = _tr("Manage general settings"),	--(optional)
			controls = Settings:GetControls(),
		},
	}
	
	self.UI.panel = self.LAM:RegisterAddonPanel("iwontsayRPFlagger", panelData)
	self.LAM:RegisterOptionControls("iwontsayRPFlagger", mainPanel)
end

function RPFlagger:Init()
	self.charDefaults = {
		["guildList"]		= { 1,2,3,4,5 }
	}
	
	self.charVariables = ZO_SavedVars:New(
		"RPFSavedVars",
		1,
		nil,
		self.charDefaults)

	self.guildList = self.charVariables.guildList

	self:InitializeUI()

	-- CHAT_SYSTEM:AddMessage(self.name .. " Addon Loaded.")
	-- CHAT_SYSTEM:AddMessage("Use /rpf help for an overview")
end

local function OnAddOnLoaded(eventCode, addonName)
	if addonName == RPFlagger.name then
		RPFlagger:Init()
	else
		RPFlagger.loadedAddons[addonName] = true
	end
end

local function OnPCCreated()
	Settings:PopulateUI()
end

EVENT_MANAGER:RegisterForEvent(RPFlagger.name, EVENT_ADD_ON_LOADED, OnAddOnLoaded)

-- SLASH_COMMANDS["/rpf"] = function(argv) RPFlagger:SlashCommand(argv) end

CALLBACK_MANAGER:RegisterCallback("LAM-PanelControlsCreated", OnPCCreated)
