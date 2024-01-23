local Assassin = require("character.player.assassin")
local Healer = require("character.player.healer")
local Chevalier = require("character.player.chevalier")
local Archer = require("character.player.archer")

function GetClasseJoueur(classe)
    if classe == "Chevalier" then
        return Chevalier:new()

    elseif classe == "Healer" then
        return Healer:new()

    elseif classe == "Assassin" then
        return Assassin:new()
    else 
        return Archer:new()
    end

end