local Framework, frameworkType


CreateThread(function()
    if GetResourceState("es_extended") == "started" then
        Framework = exports["es_extended"]:getSharedObject()
        frameworkType = "esx"
        print("[HUD] Framework detected: ESX")
        MySQL.query('ALTER TABLE users ADD COLUMN IF NOT EXISTS armor INT DEFAULT 0', {}, function()
            print("[HUD] Armor column check completed for ESX")
        end)
    elseif GetResourceState("qb-core") == "started" then
        Framework = exports["qb-core"]:GetCoreObject()
        frameworkType = "qbcore"
        print("[HUD] Framework detected: QBCore")
    else
        print("[HUD] Error: No supported framework (ESX or QBCore) detected.")
    end
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
