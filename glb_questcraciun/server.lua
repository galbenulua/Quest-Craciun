local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "VDScripts_portocale")
local players = {}
RegisterCommand("christmas", function(source)
    local user_id = vRP.getUserId({source})
    TriggerClientEvent("glb:deschide", source, vRP.getInventoryItemAmount({user_id,"oranges",}))
end)
RegisterServerEvent("glb:ocupaLocul", function(c,x,y,z)
    source = source
    local user_id = vRP.getUserId({source})
    if c == "add" then 
        table.insert(players, {id=user_id,x=x,y=y,z=z})
    elseif c == "remove" then
        local p = math.random(5,15)
        vRP.giveInventoryItem({user_id, "oranges", p, false})
        vRPclient.notify(source, { "Colindatului ia placut colinda ta asa ca ti-a oferit "..p.." portocale" })
        for k,v in pairs(players) do
            if v.id == user_id then
                table.remove(players, k)
                TriggerClientEvent("glb:cancel", source, "not")
            end
        end
        TriggerClientEvent("glb:nextCheckpoint", source)
    end
end)
RegisterServerEvent("glb:verificaLocul", function(once)
    source = source
    local user_id = vRP.getUserId({source})
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    if #players > 0 then
        for k,v in pairs(players) do
            if #(GetEntityCoords(ped) - vector3(v.x,v.y,v.z)) <= 5 then            
                if #players > 0 then
                    if v.id ~= user_id then
                        TriggerClientEvent("glb:cancel", source, "yes")
                    else
                        TriggerClientEvent("glb:cancel", source, "not")
                    end
                end
            end
        end
    else
        TriggerClientEvent("glb:cancel", source, "not")
    end
end)
RegisterServerEvent("glb:santaClaus", function(data)
    if data.men then
        source = source
        local user_id = vRP.getUserId{source}
        if vRP.tryGetInventoryItem({user_id,"oranges",data.men,false}) then
            vRP.giveMoney({user_id,data.val})
            vRPclient.notify(source,{"Ai vandut ".. data.men .." portocale si ai primit ".. data.val .."$"})
        else
            vRPclient.notify(source,{"Nu ai bordogale."})
        end
    end
end)