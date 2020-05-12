ESX = nil

local plates = {}
local realPlate
local on 

Citizen.CreateThread(function ()
	while ESX == nil do
    	TriggerEvent('yeehaw:getSharedObject', function(obj) ESX = obj end)
    	Citizen.Wait(0)
  	end
end)

RegisterNetEvent('fakeplates:offFake')
AddEventHandler('fakeplates:offFake', function()
    local insideVeh = IsPedInAnyVehicle(PlayerPedId(), true)
    if (insideVeh ~= 1) then
        ESX.ShowNotification('~r~You are not in a vehicle.')
        return
    end
    if (not on) then
        ESX.ShowNotification('~r~You do not have a fake plate on.')
        return
    end
    SetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)), realPlate)
    ESX.ShowNotification('~r~You put your real plate back on!')
    on = false
end)

RegisterNetEvent('fakeplates:setFake')
AddEventHandler('fakeplates:setFake', function()
    local plate = GeneratePlate()
    realPlate = GetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    SetVehicleNumberPlateText(GetVehiclePedIsUsing(GetPlayerPed(-1)), plate)
    ESX.ShowNotification('~r~Your fake plate is ' .. plate)
    on = true
end)

RegisterNetEvent('fakeplates:applyFake')
AddEventHandler('fakeplates:applyFake', function()
    if (on) then
        ESX.ShowNotification('~r~You can only have one fake plate on one car of yours!')
        return
    end
    local insideVeh = IsPedInAnyVehicle(PlayerPedId(), true)
    if (insideVeh == 1) then
        TriggerEvent('fakeplates:setFake')
        TriggerServerEvent('fakeplates:success')
    else
        ESX.ShowNotification('~r~You are not in a vehicle!')
    end
end)

-- ESX VEHICLE SHOP

function GeneratePlate()
	local generatedPlate
	local doBreak = false
	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())
		if Config.PlateUseSpace then
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
		else
			generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
		end
		ESX.TriggerServerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)
		if doBreak then
			break
		end
	end
	return generatedPlate
end