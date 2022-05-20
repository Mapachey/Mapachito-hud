Citizen.CreateThread(function()
    while true do
        Citizen.Wait(900)
        local s = 1000;
        local ESX = exports["es_extended"]:getSharedObject()
        local o2
        
        TriggerEvent('esx_status:getStatus', 'hunger', function(status) 
            hunger = status.val / 10000 
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status) 
            thirst = status.val / 10000 
        end)

        local swim = IsPedSwimmingUnderWater(ped)
        o2 = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
        SendNUIMessage({

            action  = ("updateStatusHUD");
            whenUse = (Config.WhenUse);
            useLogo = (Config.UseLogo);
            logo    = (Config.LogoURL);
            health = GetEntityHealth(PlayerPedId())-100;
            shield = GetPedArmour(PlayerPedId());
            stamine = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
            hunger  = (hunger);
            thirst  = (thirst);
            o2 = o2;
            swim = swim; 

        })

        if IsPedInAnyVehicle(PlayerPedId()) then
            SendNUIMessage({inVeh = true})
            DisplayRadar(true)
        else
            SendNUIMessage({inVeh = false})
            DisplayRadar(false)
        end

    end
end)

-- Cinematic Mode

local cinMa = nil

RegisterCommand("cinematicMode", function()
    cinMa = not cinMa

    if (cinMa) then
        radar = false
        cinMa = true;
    elseif not (cinMa) then 
        radar = false
        cinMa = false;
    elseif IsPedInAnyVehicle(PlayerPedId()) then 
        radar = true
    elseif not IsPedInAnyVehicle(PlayerPedId()) then
        radar = false
    end

    DisplayRadar(radar)
    SendNUIMessage({cinemaMode = cinMa})
end)


if Config.whenKey then
    RegisterKeyMapping("cinematicMode", "Cinematic Mode", "keyboard", "INSERT") -- Dale al insert y ves el modo cine
end