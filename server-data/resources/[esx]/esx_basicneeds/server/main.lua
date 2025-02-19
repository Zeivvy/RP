ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k,v in pairs(Config.Food) do
	ESX.RegisterUsableItem(k, function(source)
		local message = string.format(_U('used_item'), k)
		local xPlayer = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem(k, 1)

		TriggerClientEvent('esx_status:add', source, 'hunger', v*4)
		TriggerClientEvent('esx_basicneeds:onEat', source)
		TriggerClientEvent('esx:showNotification', source, message)
	end)
end

for k,v in pairs(Config.Drinks) do
	ESX.RegisterUsableItem(k, function(source)
		local xPlayer = ESX.GetPlayerFromId(source)

		xPlayer.removeInventoryItem(k, 1)

		TriggerClientEvent('esx_status:add', source, 'thirst', v*10000)
		TriggerClientEvent('esx_basicneeds:onDrink', source)
		TriggerClientEvent('esx:showNotification', source, string.format(_U('used_item'), k))
	end)
end

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local playerId = tonumber(args[1])

		-- is the argument a number?
		if playerId then
			-- is the number a valid player?
			if GetPlayerName(playerId) then
				print(('esx_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
				TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
				TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
		end
	else
		print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', params = {{name = 'playerId', help = '(optional) player id'}}})
