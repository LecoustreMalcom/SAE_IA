local Assassin = require("character.player.assassin")
local Healer = require("character.player.healer")
local Chevalier = require("character.player.chevalier")
local Archer = require("character.player.archer")
local Custom = require("character.player.custom_character")

function GetClasseJoueur(classe,stats,j)

    if classe == "Chevalier" then
        return Chevalier:new()

    elseif classe == "Custom" then
        if stats ~= nil then
            local custom =  Custom:new()
            local list = stats[j]

            while Sum(list) == 0 do
                j = j + 1
                list = stats[j]

                if j > 4 then
                    return Custom:new()
                end
            end

            custom:setAllStats(list.Force, list.Defense, list.Luck, list.Speed)
            return custom
        else 
            return Custom:new()
        end

    elseif classe == "Healer" then
        return Healer:new()

    elseif classe == "Assassin" then
        return Assassin:new()
    else 
        return Archer:new()
    end
end

function Sum(t)
    local sum = 0
    for k, v in pairs(t) do
        sum = sum + v
    end
    return sum
end