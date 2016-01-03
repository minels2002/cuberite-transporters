
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

  return false
end
