-- This file contains the Initialize and OnDisable function

-- Global table where the config is is stored.
g_Config = {}

function Initialize(a_Plugin)
	a_Plugin:SetName("TRANSPORTERS")
	a_Plugin:SetVersion(0.1)

	-- Load the config.
	-- LoadConfig(a_Plugin:GetLocalFolder() .. "/Config.cfg")

	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_MOVING, OnPlayerMoving)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_SPAWNED, MyOnPlayerSpawned)

	LOG("Initialized TRANSPORTERS v." .. a_Plugin:GetVersion())
	return true
end

function OnDisable()
	LOG("TRANPORTERS is disabled")
end
