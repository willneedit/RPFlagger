local DEBUG =
-- function() end
d

local function _tr(str)
	return str
end

local RPF = RPFlagger

local GetUnitTitle_original = GetUnitTitle
local GetTitle_original = GetTitle

local function GetUnitInfo(unitTag)
	local unitTitleOriginal = GetUnitTitle_original(unitTag)
	local unitDisplayName = GetUnitDisplayName(unitTag)
	local unitCharacterName = GetUnitName(unitTag)

	return unitTitleOriginal, unitDisplayName, unitCharacterName
end

local function GetPlayerInfo(index)
	local unitTitleOriginal = GetTitle_original(index)
	local unitDisplayName = GetDisplayName()
	local unitCharacterName = GetUnitName("player")

	return unitTitleOriginal, unitDisplayName, unitCharacterName
end

local function GetUnitTitle_patched(unitTag)
	local to, dn, cn = GetUnitInfo(unitTag)
	local tr = RPF:GetReplacementTitle(dn)
	return tr or to
end

local function GetTitle_patched(index)
	local to, dn, cn = GetPlayerInfo(index)
	local tr = RPF:GetReplacementTitle(dn)
	return tr or to
end

function RPF:GetReplacementTitle(displayName)
	local rn = ""
	for i = 1, #self.guildList, 1 do
		local guildId = self.guildList[i]
		local memberIndex = GetGuildMemberIndexFromDisplayName(guildId, displayName)
		if memberIndex then
			local _, note = GetGuildMemberInfo(guildId, memberIndex)
			local start, stop = string.find(note, "##RP: .* ##")
			if start and stop then
				return string.sub(note, start+6, stop-3)
			end
		end
	end
	return nil
end

GetTitle = GetTitle_patched
GetUnitTitle = GetUnitTitle_patched
