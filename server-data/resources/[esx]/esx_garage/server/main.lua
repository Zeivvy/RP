ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_garage:setParking')
AddEventHandler('esx_garage:setParking', function(garage, zone, vehicleProps, silent)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if vehicleProps == false then

		MySQL.Async.execute('DELETE FROM `user_parkings` WHERE `identifier` = @identifier AND `garage` = @garage AND zone = @zone',
		{
			['@identifier'] = xPlayer.identifier,
			['@garage']     = garage;
			['@zone']       = zone
		}, function(rowsChanged)
			if not silent then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_released'))
			end
		end)
	else
		MySQL.Async.execute('REPLACE INTO `user_parkings` (`identifier`, `garage`, `zone`, `vehicle`) VALUES (@identifier, @garage, @zone, @vehicle)',
		{
			['@identifier'] = xPlayer.identifier,
			['@garage']     = garage;
			['@zone']       = zone,
			['vehicle']     = json.encode(vehicleProps)
		}, function(rowsChanged)
			if not silent then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('veh_stored'))
			end
		end)
	end
end)

RegisterServerEvent('esx_garage:updateOwnedVehicle')
AddEventHandler('esx_garage:updateOwnedVehicle', function(vehicleProps)
	MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps)
	})
end)

ESX.RegisterServerCallback('esx_vehicleshop:getVehiclesInGarage', function(source, cb, garage)
	local xPlayer  = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM `user_parkings` WHERE `identifier` = @identifier AND garage = @garage',
	{
		['@identifier'] = xPlayer.identifier,
		['@garage']     = garage
	}, function(result)

		local vehicles = {}
		for i=1, #result, 1 do
			table.insert(vehicles, {
				zone    = result[i].zone,
				vehicle = json.decode(result[i].vehicle)
			})
		end

		cb(vehicles)

	end)

end)
