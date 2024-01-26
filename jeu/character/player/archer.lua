-- Archer.lua

-- Importe la classe parente Personnage
local Personnage = require("character.player.Personnage")

-- Crée une table vide nommée "Archer" qui servira de classe enfant de Personnage
local Archer = {}
setmetatable(Archer, {__index = Personnage})

-- Méthode constructeur pour créer une nouvelle instance de la classe Archer
function Archer:new()
    local instance = Personnage:new() -- Crée une nouvelle instance vide avec la métatable Archer
    setmetatable(instance, {__index = Archer}) -- Hérite de la classe Personnage
    instance:setHp(90) -- Points de vie
    instance:setAttack(8) -- Attaque
    instance:setDef(0) -- Défense
    instance:setLuck(1) -- Chance
    instance:setImage(love.graphics.newImage("character/player/assets/Archer/Idle/Idle-Sheet.png")) -- Image de l'Archer
    instance:setQuad(nil)
    instance:setInventory({}) -- Inventaire vide
    instance:setCooldown(0) --Cooldown de la compétence
    instance:setX(0) -- Position x de l'Archer
    instance:setY(0) -- Position y de l'Archer
    instance:setQuad(instance:AssoImage("character/player/assets/Archer/Idle/Idle-Sheet.png")[1])
    instance:setMaxHp(90)
    return instance -- Renvoie l'instance nouvellement créée
end

function Archer:getName()
    return "Archer"
end

function Archer:Competence()
    self:setCooldown(3)
    return self:getAttack() * 2
end

function Archer:getDescComp()
    return "Tire une flèche infligeant 2 fois plus de dégats"
end

-- Renvoie la classe Archer avec ses méthodes et propriétés
return Archer