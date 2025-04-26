local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('KJ_OHGarages:registerVehicle')
AddEventHandler('KJ_OHGarages:registerVehicle', function(vehicleProps, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    
end)

RegisterServerEvent('KJ_OHGarages:removeVehicle')
AddEventHandler('KJ_OHGarages:removeVehicle', function(plate, garage)
    local xPlayer = ESX.GetPlayerFromId(source)
    
end)

ESX.RegisterServerCallback('KJ_OHGarages:checkJob', function(source, cb, requiredJobs)
    local xPlayer = ESX.GetPlayerFromId(source)
    local hasJob = false
    
    for _, job in pairs(requiredJobs) do
        if xPlayer.job.name == job then
            hasJob = true
            break
        end
    end
    
    cb(hasJob)
end)

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
end)
