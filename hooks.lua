
spawnX = 484
spawnY = 32
spawnZ = 174

teamRedHomeX = 428
teamRedHomeZ = 127

zombiesSpawned = false

function OnPlayerMoving(a_Player, a_OldPosition, a_NewPosition)
  local PlayerName  = a_Player:GetName()
  local World       = a_Player:GetWorld()

  local             x = 0.5
  local             y = 66

  -- TempMessage = PlayerName .. "is moving x=" .. a_NewPosition.x
  -- World:BroadcastChat(TempMessage)

    if (not zombiesSpawned) then
        if (a_NewPosition.x >= x and
            a_NewPosition.x <= x+2 and
            a_NewPosition.y >= y and
            a_NewPosition.y <= y+2) then

        World:BroadcastChat(PlayerName .. " attacked by our zombie army")

        World:SpawnMob(a_NewPosition.x + 2, a_NewPosition.y, a_NewPosition.z, mtZombie)
        World:SpawnMob(a_NewPosition.x - 2, a_NewPosition.y, a_NewPosition.z, mtZombie)
        World:SpawnMob(a_NewPosition.x, a_NewPosition.y + 2, a_NewPosition.z, mtZombie)
        World:SpawnMob(a_NewPosition.x, a_NewPosition.y - 2, a_NewPosition.z, mtZombie)
        zombiesSpawned = true

      end
    end


  -- add gold to inventory of player
      if (a_NewPosition.x >= teamRedHomeX and
          a_NewPosition.x <= teamRedHomeX+1 and
          a_NewPosition.z >= teamRedHomeZ and
          a_NewPosition.z <= teamRedHomeZ+2) then

      World:BroadcastChat(PlayerName .. " picked up a gold nugget, good luck for the transport!")

      local inventory = a_Player:GetInventory();
      local item = cItem(E_ITEM_GOLD_NUGGET);
      inventory:AddItem(item);
    end

  return false
end

function MyOnPlayerSpawned(a_Player)
  local PlayerName  = a_Player:GetName()
  local World       = a_Player:GetWorld()

  a_Player:TeleportToCoords(spawnX, spawnY, spawnZ);

  World:BroadcastChat(PlayerName .. " welcome to TRANSPORTERS!")

  return false
end
