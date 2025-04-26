local ESX = exports['es_extended']:getSharedObject()
local PlayerData = {}
local currentGarage = nil
local spawnedVehicles = {}

local openVehicleCategoryMenu, openVehicleListMenu, spawnVehicle, deleteVehicle
local hasAccess, isSpawnPointClear, drawMarker, createBlips

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

hasAccess = function(jobs)
    if PlayerData.job and jobs then
        for _, job in pairs(jobs) do
            if job == PlayerData.job.name then
                return true
            end
        end
    end
    return false
end

openVehicleCategoryMenu = function(garage)
    local categories = {}
    
    for categoryName, _ in pairs(garage.categories) do
        table.insert(categories, {
            title = categoryName,
            description = Locales['select_vehicle'],
            onSelect = function()
                openVehicleListMenu(garage, categoryName)
            end
        })
    end
    
    lib.registerContext({
        id = 'job_garage_categories',
        title = garage.name,
        options = categories
    })
    
    lib.showContext('job_garage_categories')
end

isSpawnPointClear = function(coords, radius)
    radius = radius or 3.0
    local vehicles = ESX.Game.GetVehiclesInArea(coords, radius)
    return #vehicles == 0
end

drawMarker = function(type, coords, size, color, rotate)
    DrawMarker(
        type,
        coords.x, coords.y, coords.z - 0.95,
        0.0, 0.0, 0.0,
        0.0, 0.0, 0.0,
        size.x, size.y, size.z,
        color.r, color.g, color.b, color.a,
        false, rotate, false, false, false, false, false
    )
end

openVehicleListMenu = function(garage, categoryName)
    local vehicles = {}
    
    for _, vehicle in pairs(garage.categories[categoryName]) do
        table.insert(vehicles, {
            title = vehicle.label,
            description = '',
            onSelect = function()
                spawnVehicle(garage, vehicle)
            end
        })
    end
    
    table.insert(vehicles, {
        title = Locales['back'],
        description = '',
        onSelect = function()
            openVehicleCategoryMenu(garage)
        end
    })
    
    lib.registerContext({
        id = 'job_garage_vehicles',
        title = categoryName,
        options = vehicles
    })
    
    lib.showContext('job_garage_vehicles')
end

spawnVehicle = function(garage, vehicleData)
    if not isSpawnPointClear(garage.spawnPoint.coords) then
        lib.notify({
            title = garage.name,
            description = Locales['spawn_blocked'],
            type = 'error'
        })
        return
    end
    
    ESX.Game.SpawnVehicle(vehicleData.model, garage.spawnPoint.coords, garage.spawnPoint.heading, function(vehicle)
        if DoesEntityExist(vehicle) then
            table.insert(spawnedVehicles, {
                vehicle = vehicle,
                garage = garage.name
            })
            
            TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
            
            if vehicleData.livery and vehicleData.livery ~= 0 then
                SetVehicleLivery(vehicle, vehicleData.livery)
            end
            
            if vehicleData.extras then
                for extraId, enabled in pairs(vehicleData.extras) do
                    SetVehicleExtra(vehicle, extraId, not enabled)
                end
            end
            
            lib.notify({
                title = garage.name,
                description = Locales['vehicle_spawned'],
                type = 'success'
            })
        else
            lib.notify({
                title = garage.name,
                description = Locales['vehicle_model_not_found'],
                type = 'error'
            })
        end
    end)
end

deleteVehicle = function()
    local playerPed = PlayerPedId()
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        local isWorkVehicle = false
        
        for _, spawnedVeh in ipairs(spawnedVehicles) do
            if spawnedVeh.vehicle == vehicle then
                isWorkVehicle = true
                break
            end
        end
        
        if isWorkVehicle then
            for i = #spawnedVehicles, 1, -1 do
                if spawnedVehicles[i].vehicle == vehicle then
                    table.remove(spawnedVehicles, i)
                    break
                end
            end
            
            ESX.Game.DeleteVehicle(vehicle)
            
            lib.notify({
                title = currentGarage.name,
                description = Locales['vehicle_deleted'],
                type = 'success'
            })
        else
            lib.notify({
                title = currentGarage.name,
                description = Locales['not_work_vehicle'],
                type = 'error'
            })
        end
    else
        lib.notify({
            title = currentGarage.name,
            description = Locales['must_in_vehicle'],
            type = 'error'
        })
    end
end

createBlips = function()
end

Citizen.CreateThread(function()
    createBlips()
    
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isInMarkerRange = false
        local isInDeleteMarkerRange = false
        local nearbyGarage = nil
        
        for _, garage in pairs(Config.Garages) do
            local distToGarage = #(playerCoords - garage.marker)
            if distToGarage < Config.DrawDistance then
                drawMarker(
                    Config.MarkerType,
                    garage.marker,
                    Config.MarkerSize,
                    Config.MarkerColor,
                    Config.MarkerRotation
                )
                
                if distToGarage < Config.InteractDistance then
                    isInMarkerRange = true
                    nearbyGarage = garage
                    currentGarage = garage
                    
                    if IsControlJustReleased(0, 38) and hasAccess(garage.jobs) then
                        openVehicleCategoryMenu(garage)
                    elseif not hasAccess(garage.jobs) and IsControlJustReleased(0, 38) then
                        lib.notify({
                            title = garage.name,
                            description = Locales['not_authorized'],
                            type = 'error'
                        })
                    end
                end
            end
            
            local distToDelete = #(playerCoords - garage.deleteMarker)
            if distToDelete < Config.DrawDistance then
                drawMarker(
                    Config.DeleteMarkerType,
                    garage.deleteMarker,
                    Config.DeleteMarkerSize,
                    Config.DeleteMarkerColor,
                    false
                )
                
                if distToDelete < Config.InteractDistance then
                    isInDeleteMarkerRange = true
                    currentGarage = garage
                    
                    if IsControlJustReleased(0, 38) then
                        deleteVehicle()
                    end
                end
            end
        end
        
        if isInMarkerRange and hasAccess(nearbyGarage.jobs) then
            ESX.ShowHelpNotification(Locales['press_to_open'])
        end
        
        if isInDeleteMarkerRange then
            ESX.ShowHelpNotification(Locales['press_to_delete'])
        end
    end
end)
