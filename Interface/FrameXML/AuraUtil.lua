AuraUtil = {};

-- For backwards compatibility with old APIs, this helper function returns aura data values unpacked in the same order as before.
function AuraUtil.UnpackAuraData(auraData)
	if not auraData then
		return nil;
	end

	return auraData.name,
		auraData.icon,
		auraData.applications,
		auraData.dispelName,
		auraData.duration,
		auraData.expirationTime,
		auraData.sourceUnit,
		auraData.isStealable,
		auraData.nameplateShowPersonal,
		auraData.spellId,
		auraData.canApplyAura,
		auraData.isBossAura,
		auraData.isFromPlayerOrPlayerPet,
		auraData.nameplateShowAll,
		auraData.timeMod,
		unpack(auraData.points);
		-- TODO: Add data for SPELL_ATTRIBUTE_EX_G_UI_AURA_PRIORITY here when Classic updates Aura data.
end

local function FindAuraRecurse(predicate, unit, filter, auraIndex, predicateArg1, predicateArg2, predicateArg3, ...)
	if ... == nil then
		return nil; -- Not found
	end
	if predicate(predicateArg1, predicateArg2, predicateArg3, ...) then
		return ...;
	end
	auraIndex = auraIndex + 1;
	return FindAuraRecurse(predicate, unit, filter, auraIndex, predicateArg1, predicateArg2, predicateArg3, UnitAura(unit, auraIndex, filter));
end

-- Find an aura by any predicate, you can pass in up to 3 predicate specific parameters
-- The predicate will also receive all aura params, if the aura data matches return true
function AuraUtil.FindAura(predicate, unit, filter, predicateArg1, predicateArg2, predicateArg3)
	local auraIndex = 1;
	return FindAuraRecurse(predicate, unit, filter, auraIndex, predicateArg1, predicateArg2, predicateArg3, UnitAura(unit, auraIndex, filter));
end

do
	local function NamePredicate(auraNameToFind, _, _, auraName)
		return auraNameToFind == auraName;
	end

	-- Finds the first aura that matches the name
	-- Notes:
	--		aura names are not unique!
	--		aura names are localized, what works in one locale might not work in another
	--			consider that in English two auras might have different names, but once localized they have the same name, so even using the localized aura name in a search it could result in different behavior
	--		the unit could have multiple auras with the same name, this will only find the first
	function AuraUtil.FindAuraByName(auraName, unit, filter)
		return AuraUtil.FindAura(NamePredicate, unit, filter, auraName);
	end
end