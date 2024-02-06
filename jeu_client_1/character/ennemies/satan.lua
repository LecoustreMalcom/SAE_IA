-- Satan.lua
local Entite = require("character.ennemies.entite_malefique")

-- Crée une table vide nommée "Satan" qui servira de classe enfant
local Satan = {}
setmetatable(Satan, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Satan
function Satan:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Satan 
    setmetatable(instance, {__index = Satan}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 300 -- Points de vie
    instance.attack = 23 -- Attaque
    instance.defense = 10 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Satan/Satan.png") -- Image de l'Satan
    instance.x = 0 -- Position x de l'Satan
    instance.y = 0 -- Position y de l'Satan
    instance.name = "Satan"
    return instance -- Renvoie l'instance nouvellement créée
end

function Satan:afficher()
    love.graphics.draw(self.image, self.x, self.y,_,3,3)
end

function Satan:drop()
    local ecu_possible = {0,0,0}
    local ecu = ecu_possible[math.random(1,3)]
    local liste_drop = {}
    return ecu,liste_drop
end

    
-- Renvoie la classe Satan avec ses méthodes et propriétés
return Satan