
-- Check Behavior of GetString
local lang = {
	SI_BINDING_NAME_DISPLAY_LONGTXT = "Get long character info",
}

for stringId, stringValue in pairs(lang) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
