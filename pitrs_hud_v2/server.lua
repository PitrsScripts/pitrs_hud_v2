local Framework, frameworkType


CreateThread(function()
    -- Detect framework first
    if GetResourceState("es_extended") == "started" then
        Framework = exports["es_extended"]:getSharedObject()
        frameworkType = "esx"
    elseif GetResourceState("qb-core") == "started" then
        Framework = exports["qb-core"]:GetCoreObject()
        frameworkType = "qbcore"
    else
        frameworkType = nil
    end

    print("^3============================================================")
    print("^3 Custom HUD V2 - Pitrs")
    print("^3============================================================")

    if frameworkType == "esx" then
        if GetResourceState('ox_lib') == 'started' then
            print("^2 [SUCCESS] ox_lib loaded successfully!")
        else
            print("^1 [ERROR] ox_lib not loaded!")
        end

        if GetResourceState('esx_status') == 'started' then
            print("^2 [SUCCESS] esx_status loaded successfully!")
        else
            print("^1 [ERROR] esx_status not loaded!")
        end

        if GetResourceState('esx_basicneeds') == 'started' then
            print("^2 [SUCCESS] esx_basicneeds loaded successfully!")
        else
            print("^1 [ERROR] esx_basicneeds not loaded!")
        end

        if GetResourceState('es_extended') == 'started' then
            print("^2 [SUCCESS] es_extended loaded successfully!")
        else
            print("^1 [ERROR] es_extended not loaded!")
        end

        if GetResourceState('mysql-async') == 'started' then
            print("^2 [SUCCESS] mysql-async Database loaded successfully!")
        else
            print("^1 [ERROR] mysql-async Database not loaded!")
        end

        MySQL.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS armor INT DEFAULT 0', {}, function()
            -- Removed print
        end)
    elseif frameworkType == "qbcore" then
        print("^2 [SUCCESS] QB-Core Framework loaded successfully!")
    else
        print("^1 [ERROR] No supported framework (ESX or QBCore) detected.")
    end

    print("^2 Script successfully started!")
    print("^4 Support Discord: https://discord.gg/vhJkJbGpMy")
    print("^3============================================================")

end)

RegisterNetEvent('pitrs_hud_v2:server:UpdateArmor', function(newArmor)
    local src = source
    if frameworkType == "esx" then
        local xPlayer = Framework.GetPlayerFromId(src)
        if xPlayer then
            local identifier = xPlayer.identifier
            MySQL.update('UPDATE users SET armor = ? WHERE identifier = ?', {
                newArmor,
                identifier
            })
        end
    elseif frameworkType == "qbcore" then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("armor", newArmor)
        end
    end
end)


RegisterNetEvent('pitrs_hud_v2:server:UpdateHealth', function(newHealth)
    local src = source
    if frameworkType == "esx" then
        local xPlayer = Framework.GetPlayerFromId(src)
        if xPlayer then
        end
    elseif frameworkType == "qbcore" then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("health", newHealth)
        end
    end
end)

RegisterNetEvent('pitrs_hud_v2:server:LoadArmorAndHealth', function()
    local src = source
    if frameworkType == "esx" then
        local xPlayer = Framework.GetPlayerFromId(src)
        if xPlayer then
            local identifier = xPlayer.identifier
            MySQL.single('SELECT armor FROM users WHERE identifier = ?', {identifier}, function(result)
                if result then
                    TriggerClientEvent('pitrs_hud_v2:client:UpdateArmorAndHealth', src, result.armor or 0, 100)
                else
                    TriggerClientEvent('pitrs_hud_v2:client:UpdateArmorAndHealth', src, 0, 100)
                end
            end)
        end
    elseif frameworkType == "qbcore" then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            local armor = Player.PlayerData.metadata["armor"] or 0
            local health = Player.PlayerData.metadata["health"] or 100
            TriggerClientEvent('pitrs_hud_v2:client:UpdateArmorAndHealth', src, armor, health)
        end
    end
end)

AddEventHandler('playerDropped', function()
    local src = source
    local ped = GetPlayerPed(src)
    local armor = GetPedArmour(ped)
    local health = GetEntityHealth(ped) - 100

    if frameworkType == "esx" then
        local xPlayer = Framework.GetPlayerFromId(src)
        if xPlayer then
            local identifier = xPlayer.identifier
            MySQL.update('UPDATE users SET armor = ? WHERE identifier = ?', {
                armor,
                identifier
            })
        end
    elseif frameworkType == "qbcore" then
        local Player = Framework.Functions.GetPlayer(src)
        if Player then
            Player.Functions.SetMetaData("armor", armor)
            Player.Functions.SetMetaData("health", health)
        end
    end
end)
