ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('fakeplates:success')
AddEventHandler('fakeplates:success', function()
    xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('fakeplate', 1)
end)

ESX.RegisterUsableItem('fakeplate', function(source)
    TriggerClientEvent('fakeplates:applyFake', source)
end)

ESX.RegisterUsableItem('screwdriver', function(source)
    TriggerClientEvent('fakeplates:offFake', source)
end)