function startAnim(lib, anim)
	Citizen.CreateThread(function()
		RequestAnimDict(lib)
		while not HasAnimDictLoaded( lib) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(GetPlayerPed(-1), lib ,anim ,8.0, -8.0, -1, 0, 0, false, false, false )
	end)
end

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

RegisterNetEvent('hjalte:tracker')
AddEventHandler('hjalte:tracker', function()

	local playerped = GetPlayerPed(-1)

	local coordA = GetEntityCoords(playerped, 1)
	local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
	local targetVehicle = getVehicleInDirection(coordA, coordB)

	if DoesEntityExist(targetVehicle) then
		startAnim("amb@code_human_police_investigate@idle_b","idle_f")
		Citizen.Wait(8000)
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent('hjalte:takeTheItem')
		SetEntityAsMissionEntity(targetVehicle)
		local vehBlip = AddBlipForEntity(targetVehicle)
		SetBlipSprite(vehBlip, 458)
		SetBlipColour(vehBlip, 1)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Sporet GPS')
		EndTextCommandSetBlipName(vehBlip)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
		Citizen.Wait(300000)
			RemoveBlip(vehBlip)
				else
		TriggerEvent("pNotify:SendNotification",{
			text = "<h3>Intet køretøj i nærheden⛔️</h3><br><h5>Prøv at rykke dig hvis du står ved siden af et køretøj!</h5>",
			type = "error",
			timeout = (5000),
			layout = "centerLeft",
			queue = "global",
			animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
		end
end)








