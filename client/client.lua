local framework = Config.Framework
local ESX = nil

if framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
elseif framework == 'frw' then
    ESX = exports['Framework']:getSharedObject()
else
    print("Votre Framework est spécial ou trop ancian, get le code pour changer l'export")
end

---- Market pour tp le joueur dans l'entrepos ---

local position = {
    {x = Config.Join.x, y = Config.Join.y, z = Config.Join.z}
}

CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(position) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 10.0 then
                wait = 0

                DrawMarker(20, position[k].x, position[k].y, position[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 118, 226, 255, true, true, p19, true)  
                if dist <= 5.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour Rentré dans l'entrepot")
                    if IsControlJustPressed(1, 51) then
                    local targetCoords = vector3(1138.021, -3198.499, -39.66573)
                    SetEntityCoords(PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                    end
                end
            end
        end
        Wait(wait)
    end
end)

--- Script qui permet de blanchir ---
function Ablanchiment()
    local open = false
    local thune = 0  -- Initialize 'thune' here
    local Mainblanchiment = RageUI.CreateMenu("", "Blanchis ton argent...")
    Mainblanchiment.Closed = function() open = false end

    if not open then
        open = true
        RageUI.Visible(Mainblanchiment, true)
        Citizen.CreateThread(function()
            while open do
                RageUI.IsVisible(Mainblanchiment, function()

                    RageUI.Button("Argent à blanchir", nil, { RightLabel = tostring(thune) }, true, {
                        onSelected = function()
                            local input = KeyboardInput('Veuillez indiquer la somme à blanchir', '', 20)
                            if input and tonumber(input) then
                                thune = tonumber(input)
                            end
                        end
                    })

                    RageUI.Button("Blanchir son argent", nil, { RightLabel = "→→", Color = { BackgroundColor = { 0, 140, 0, 160 } } }, true, {
                        onSelected = function()
                            if thune > 0 then
                                TriggerServerEvent('Ablanchiment', thune)
                                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
                                Wait(12000)
                                ClearPedTasksImmediately(PlayerPedId())
                                RageUI.CloseAll()
                            else
                                ESX.ShowHelpNotification("La somme à blanchir n'est pas valide.")
                            end
                        end
                    })

                end)
                Wait(0)
            end
        end)
    end
end

-- le marker de blanchiment -- 

local posmachine = {
    {x = Config.posmachine.x, y = Config.posmachine.y, z = Config.posmachine.z}
}

CreateThread(function()
    while true do
        local wait = 1000
        for k in pairs(posmachine) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, posmachine[k].x, posmachine[k].y, posmachine[k].z)
            if dist <= 10.0 then
                wait = 0
                DrawMarker(20, posmachine[k].x, posmachine[k].y, posmachine[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 118, 226, 255, true, true, p19, true)  
                if dist <= 5.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour blanchir votre argent")
                    if IsControlJustPressed(1, 51) then
                        Ablanchiment()
                    end
                end
            end
        end
        Wait(wait)
    end
end)

--- Marker pour leave l'entrepot --- 

local leave = {
    {x = Config.leave.x, y = Config.leave.y, z = Config.leave.z}
}

CreateThread(function()
    while true do
        local wait = 1000

        for k in pairs(leave) do
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, leave[k].x, leave[k].y, leave[k].z)

            if dist <= 10.0 then
                wait = 0

                DrawMarker(20, leave[k].x, leave[k].y, leave[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 118, 226, 255, true, true, p19, true)  
                if dist <= 5.0 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour sortir de l'entrepot")
                    if IsControlJustPressed(1, 51) then
                    local targetCoords = vector3(1240.27, -3179.385, 7.104861)
                    SetEntityCoords(PlayerPedId(), targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
                    end
                end
            end
        end
        Wait(wait)
    end
end)