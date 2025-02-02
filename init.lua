-- This file contains the Initialize and OnDisable function

-- Global table where the config is is stored.
g_Config = {}

function Initialize(a_Plugin)
	a_Plugin:SetName("TRANSPORTERS")
	a_Plugin:SetVersion(0.1)

	-- Load the config.
	-- LoadConfig(a_Plugin:GetLocalFolder() .. "/Config.cfg")

	cPluginManager:AddHook(cPluginManager.HOOK_WORLD_STARTED, OnWorldStarted);
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_SPAWNED, OnPlayerSpawned)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_BREAKING_BLOCK, OnPlayerBreakingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_COLLECTING_PICKUP, OnCollectingPickup)

	LOG("Initialized TRANSPORTERS v." .. a_Plugin:GetVersion())
	return true
end

function OnDisable()
	LOG("TRANPORTERS is disabled")
end
