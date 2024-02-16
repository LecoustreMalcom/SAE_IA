-- Chimere.lua
local Entite = require("character.ennemies.entite_malefique")
local excalibur = require("objet.obj_supreme.excalibur")

-- Crée une table vide nommée "Chimere" qui servira de classe enfant
local Chimere = {}
setmetatable(Chimere, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Chimere
function Chimere:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Chimere 
    setmetatable(instance, {__index = Chimere}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 120 -- Points de vie
    instance.attack = 15 -- Attaque
    instance.defense = 6 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Chimera/Chimera.png") -- Image de l'Chimere
    instance.x = 0 -- Position x de l'Chimere
    instance.y = 0 -- Position y de l'Chimere
    instance.name = "Chimere"
    instance.id = 7 --Id
    return instance -- Renvoie l'instance nouvellement créée
end

function Chimere:getId()
    return self.id
end

function Chimere:getName()
    return self.name
end

function Chimere:drop()
    local ecu_possible = {10,12,14}
    local list_drop = {}
    local ecu = ecu_possible[math.random(1,3)]
    table.insert(list_drop,excalibur:new())
    return ecu    
end

function Chimere:afficher()
    love.graphics.draw(self.image, self.x, self.y,_,0.5,0.5)
end
    
-- Renvoie la classe Chimere avec ses méthodes et propriétés
return Chimere