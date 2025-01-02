function Start(text,duration)
    SendNUIMessage({action="start",txt=text,s=duration})
    Citizen.Wait(duration)
    SendNUIMessage({action="stop"})
end
