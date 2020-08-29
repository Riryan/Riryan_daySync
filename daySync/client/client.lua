Citizen.CreateThread(function()
  --  TriggerServerEvent('day:GetCurrentWeather')
end)

RegisterNetEvent('day:SyncPlayers')
AddEventHandler('day:SyncPlayers', function(SyncedTimer)
    print("Client response to Sync", SyncedTimer)
    --1440 mins in a day /  then /60mins per hour
    SyncMin = SyncedTimer
    SyncHour = SyncedTimer / 60
    hour = math.floor(SyncHour or 0)
    minute = 0 --SyncMin * 1440 / 60
    print(hour,  minute)
	SetClockTime(hour, minute, 0)
	AdvanceClockTimeTo(hour, minute, 0)
	NetworkClockTimeOverride(hour, minute, 0, 0, true)
	NetworkClockTimeOverride_2(hour, minute, 0, 0, true, true)
end)

RegisterNetEvent('day:SyncWeathers')
AddEventHandler('day:SyncPlayers', function(SyncedWeather)
    print("Client response to Sync", SyncedWeather)
    for i, row in pairs(WeatherPattern) do
        if SyncedWeather == WeatherPattern[i]["number"]then
            Citizen.InvokeNative(0x59174F1AFE095B5A, GetHashKey(WeatherPattern[i]["type"]), true, false, true, true, false)
        end
    end	
end)

