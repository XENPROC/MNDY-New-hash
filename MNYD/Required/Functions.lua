require("Required/API")

function ShootAt()
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    local weapHash = 177293209
    local pedcoords = ENTITY.GET_ENTITY_COORDS(player_id, false)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z + 5.5, pedcoords.x, pedcoords.y, pedcoords.z+0.1, 1000, true, weapHash, YourselfPED, true, true, -1, player_id, true)
end

function DropVehicleOnPlayer(name)
    script.run_in_fiber(function(script)
    local player_id = PLAYER.GET_PLAYER_PED(network.get_selected_player());
    local pedcoords = ENTITY.GET_ENTITY_COORDS(player_id, false)
    local hash = joaat(name)
    STREAMING.REQUEST_MODEL(hash);
    while not STREAMING.HAS_MODEL_LOADED(hash) do script:yield(); end
    local vehicleCreate = VEHICLE.CREATE_VEHICLE(hash, pedcoords.x, pedcoords.y, pedcoords.z + 4, 0, true, true, false)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleCreate)
    script:sleep(1700);
    DeleteVehicle(vehicleCreate)
    end)
end