    local StartMin = 0 
    local StartWeather = 0
    local TimeAdjustment = 3 -- how much to update the time per update
    
Citizen.CreateThread(function()
    print("Start Day/Night Cycle")
    Citizen.Wait(60000) -- any longer and the server hangs up.
    while true do
        Citizen.Wait(60000) -- any longer and the server hangs up.        
        exports.ghmattimysql:scalar("SELECT `currenttime` FROM daySync WHERE  oldmin = @oldmin",  {['@oldmin'] = StartMin},
        function (results) 
            if results == nil then
             exports.ghmattimysql:execute("INSERT INTO daySync ( oldmin, currenttime, newmin, weather ) VALUES ( @oldmin, @currenttime,@newmin ,@weather)",
                { ['@oldmin'] = StartMin, ['@currenttime'] = StartMin, ['@newmin'] = StartMin, ['@weather']= StartWeather})
            end
            if results < 1440 then -- how many mins in a day
               newresults = results + TimeAdjustment
               exports.ghmattimysql:execute("UPDATE daySync SET `currenttime` = @currenttime WHERE oldmin = @oldmin",
               {['@oldmin'] = 0, ['@currenttime'] = newresults})
               TriggerClientEvent('day:SyncPlayers',-1, newresults)
               Citizen.Wait(60000) -- added more time here for longer times between updates
            else
                exports.ghmattimysql:execute("UPDATE daySync SET `currenttime` = @currenttime WHERE oldmin = @oldmin",
                {['@oldmin'] = 0, ['@currenttime'] = StartMin})
                TriggerClientEvent('day:SyncPlayers',-1, StartMin)
                Citizen.Wait(60000)-- added more time here for longer times between updates
            end
        end)   
    end
end)

RegisterServerEvent('day:TestClock')
    AddEventHandler('day:TestClock', function(src)
        exports.ghmattimysql:scalar("SELECT `currenttime` FROM daySync WHERE  oldmin = @oldmin",  {['@oldmin'] = StartMin},
        function (results) 
            if results == nil then
             exports.ghmattimysql:execute("INSERT INTO daySync ( oldmin, currenttime, newmin, weather ) VALUES ( @oldmin, @currenttime,@newmin ,@weather)",
                { ['@oldmin'] = StartMin, ['@currenttime'] = StartMin, ['@newmin'] = StartMin, ['@weather']= StartWeather})
                print("Adding Database Info")
            end
            if results < 1440 then -- how many mins in a day
               newresults = results +1 --how much time to add per min/ higher the sleep the higher this should be
               print(results, newresults)
               exports.ghmattimysql:execute("UPDATE daySync SET `currenttime` = @currenttime WHERE oldmin = @oldmin",
               {['@oldmin'] = 0, ['@currenttime'] = newresults})
               TriggerClientEvent('day:SyncPlayers',-1, newresults)
            end
        end)
end)

RegisterCommand("updatetime", function(source, args)
        local argString = table.concat(args, " ")
        exports.ghmattimysql:execute("UPDATE daySync SET `currenttime` = @currenttime WHERE oldmin = @oldmin",
        {['@oldmin'] = 0, ['@currenttime'] = argString})
        TriggerClientEvent('day:SyncPlayers',-1, argString)
end)

