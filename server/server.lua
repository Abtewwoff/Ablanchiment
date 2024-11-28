local framework = Config.Framework
local ESX = nil

if framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif framework == 'frw' then
    ESX = exports['Framework']:getSharedObject()
else
    print("Votre Framework est spécial ou trop ancian, get le code pour changer l'export")
end

RegisterServerEvent('Ablanchiment')
AddEventHandler('Ablanchiment', function(thune)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local taxe = Config.Taxe

    thune = ESX.Math.Round(tonumber(thune))
    local pourcentage = thune * taxe
    local taxAmount = ESX.Math.Round(tonumber(pourcentage))
    local totalAfterTax = thune - taxAmount

    if xPlayer.getAccount(Config.Argent).money >= Config.minimum then
        if thune > 0 and xPlayer.getAccount(Config.Argent).money >= thune then 
            xPlayer.removeAccountMoney(Config.Argent, thune)
            xPlayer.addAccountMoney("cash",totalAfterTax)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Blanchiment', 'Information', "Blanchissement cours", 'CHAR_ARTHUR', 8)
            Wait(10000)
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Blanchiment', 'Information', "Tiens mon gars, voilà ton argent après la taxe : "..totalAfterTax.."$ !", 'CHAR_ARTHUR', 8)
        else
            TriggerClientEvent('esx:showAdvancedNotification', _src, 'Blanchiment', 'Information', "Tu te moques de moi ? Tu penses pouvoir m'arnaquer ?", 'CHAR_ARTHUR', 8)
        end
    else
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Blanchiment', 'Information', "Tu n'as pas assez d'argent sale à blanchir, un minimum de "..Config.minimum.. "$ est requis.", 'CHAR_ARTHUR', 8)
    end
end)
