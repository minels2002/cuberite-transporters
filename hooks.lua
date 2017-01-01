
spawnX = 484
spawnY = 32
spawnZ = 174

-- TEAM READ
teamRedHomeX = 428
teamRedHomeZ = 127

teamRedDropPointX = 519
teamRedDropPointY = 39
teamRedDropPointZ = 213

-- TEAM BLUE
teamBlueHomeX = 427
teamBlueHomeZ = 214

teamBlueDropPointX = 518
teamBlueDropPointY = 38
teamBlueDropPointZ = 133


zombiesSpawned = false

function OnWorldStarted(World)
    World:SetDaylightCycleEnabled(false)
    World:SetTimeOfDay(12000)

    local scoreboard = World:GetScoreBoard()

    scoreboard:RegisterTeam('red', 'Team Red', 'test', 'test');
    scoreboard:RegisterTeam('blue', 'Team Blue', '', '');

    teamRed = scoreboard:GetTeam('red');
    teamBlue = scoreboard:GetTeam('blue');

    numTeams = scoreboard:GetNumTeams()

    scoreboard:RegisterObjective('items_transport', 'Items transported', 6);

    scoreboard:SetDisplay('items_transport', 1)

    LOG("Scoreboard initialized with " .. numTeams .. " teams...");
end

function OnPlayerMoving(Player, OldPosition, NewPosition)
  local PlayerName  = Player:GetName()
  local World       = Player:GetWorld()

  local             x = 0.5
  local             y = 66

  -- TempMessage = PlayerName .. "is moving x=" .. NewPosition.x
  -- World:BroadcastChat(TempMessage)

    if (not zombiesSpawned) then
        if (NewPosition.x >= x and
            NewPosition.x <= x+2 and
            NewPosition.y >= y and
            NewPosition.y <= y+2) then

        World:BroadcastChat(PlayerName .. " attacked by our zombie army")

        World:SpawnMob(NewPosition.x + 2, NewPosition.y, NewPosition.z, mtZombie)
        World:SpawnMob(NewPosition.x - 2, NewPosition.y, NewPosition.z, mtZombie)
        World:SpawnMob(NewPosition.x, NewPosition.y + 2, NewPosition.z, mtZombie)
        World:SpawnMob(NewPosition.x, NewPosition.y - 2, NewPosition.z, mtZombie)
        zombiesSpawned = true

      end
    end

  -- TEAM RED: add gold to inventory of player
    if (NewPosition.x >= teamRedHomeX and
        NewPosition.x <= teamRedHomeX+1 and
        NewPosition.z >= teamRedHomeZ and
        NewPosition.z <= teamRedHomeZ+2) then

      local inventory = Player:GetInventory();
      local item = cItem(E_ITEM_GOLD_NUGGET);

      if (not inventory:HasItems(item)) then
        World:BroadcastChat(PlayerName .. " picked up a gold nugget, good luck for the transport!")
        inventory:AddItem(item);
      end
    end

  -- TEAM RED: check if drop point has been reaeched and remove gold nugget from inventory
  if (NewPosition.x >= teamRedDropPointX and
      NewPosition.x <= teamRedDropPointX+1 and
      NewPosition.y >= teamRedDropPointY and
      NewPosition.z >= teamRedDropPointZ and
      NewPosition.z <= teamRedDropPointZ+2) then

    local inventory = Player:GetInventory();
    local item = cItem(E_ITEM_GOLD_NUGGET);

    if (inventory:HasItems(item)) then
      World:BroadcastChat(PlayerName .. " completed transport! Congratulation!")
      inventory:RemoveItem(item);
    end
  end

  -- TEAM BLUE: add gold to inventory of player
    if (NewPosition.x >= teamBlueHomeX and
        NewPosition.x <= teamBlueHomeX+1 and
        NewPosition.z >= teamBlueHomeZ and
        NewPosition.z <= teamBlueHomeZ+2) then

      local inventory = Player:GetInventory();
      local item = cItem(E_ITEM_GOLD_NUGGET);

      if (not inventory:HasItems(item)) then
        World:BroadcastChat(PlayerName .. " picked up a gold nugget, good luck for the transport!")
        inventory:AddItem(item);

        local scoreboard = World:GetScoreBoard()
        local objective = scoreboard:GetObjective("items_transport")
        objective:AddScore(PlayerName, 1)
      end
    end

  -- TEAM BLUE: check if drop point has been reaeched and remove gold nugget from inventory
  if (NewPosition.x >= teamBlueDropPointX and
      NewPosition.x <= teamBlueDropPointX+1 and
      NewPosition.y >= teamBlueDropPointY and
      NewPosition.z >= teamBlueDropPointZ and
      NewPosition.z <= teamBlueDropPointZ+2) then

    local inventory = Player:GetInventory();
    local item = cItem(E_ITEM_GOLD_NUGGET);

    if (inventory:HasItems(item)) then
      World:BroadcastChat(PlayerName .. " completed transport! Congratulation!")
      inventory:RemoveItem(item);

      local scoreboard = World:GetScoreBoard()
      local objective = scoreboard:GetObjective("items_transport")
      objective:AddScore(PlayerName, 1)
    end
  end

  return false
end

function OnPlayerSpawned(Player)
  local PlayerName  = Player:GetName()
  local World       = Player:GetWorld()

  Player:TeleportToCoords(spawnX, spawnY, spawnZ);

  World:BroadcastChat(PlayerName .. " welcome to TRANSPORTERS!")

  teamBlue:AddPlayer(PlayerName)

  return false
end

function OnPlayerBreakingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, BlockType, BlockMeta)
  -- do not allow player to break blocks
  return true
end

function OnCollectingPickup(Player, Pickup)
  local PlayerName  = Player:GetName()
  local World       = Player:GetWorld()

  local inventory = Player:GetInventory();
  local item = Pickup:GetItem();
  local goldNuggetItem = cItem(E_ITEM_GOLD_NUGGET);

  if (not inventory:HasItems(item) and goldNuggetItem:IsSameType(item)) then
    World:BroadcastChat(PlayerName .. " picked up a gold nugget, good luck for the transport!")
    return false
  end

  Player:SendMessage("Sorry, you can only carry one gold nugget at a time!")
  return true
end
