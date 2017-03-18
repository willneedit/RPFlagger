
-- Check Behavior of GetString
local lang = {
	

}

for stringId, stringValue in pairs(lang) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
