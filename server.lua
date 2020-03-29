local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_tracking")


vRP.defInventoryItem({"gpstracker","GPS-Tracker","Bruges til at sætte på køretøjer!",
		function(args)
				local choices = {}
				choices["> Brug"] = {function(source,choice)
						local xPlayer = vRP.getUserId({source})
						if xPlayer ~= nil then
							TriggerClientEvent("hjalte:tracker", xPlayer)
					vRP.closeMenu({xPlayer})
				end
		end,"Brug den med omhu, du kan ende i spjældet!!"}

		return choices
end, 1.50
})


RegisterServerEvent('hjalte:takeTheItem')
AddEventHandler('hjalte:takeTheItem', function()
	local xPlayer = vRP.getUserId({source})

	vRP.tryGetInventoryItem({xPlayer, "gpstracker", 1, true}) 
end)