-- Healer.lua

-- Importe la classe parente Personnage
local Personnage = require("character.player.Personnage")

-- Crée une table vide nommée "Healer" qui servira de classe enfant de Personnage
local Healer = {}
setmetatable(Healer, {__index = Personnage})

-- Méthode constructeur pour créer une nouvelle instance de la classe Healer
function Healer:new()
    local instance = Personnage:new() -- Crée une nouvelle instance vide avec la métatable Healer
    setmetatable(instance, {__index = Healer}) -- Hérite de la classe Personnage
    instance:setHp(80) -- Points de vie
    instance:setAttack(5) -- Attaque
    instance:setDef(0) -- Défense
    instance:setLuck(5) -- ChanceS
    instance:setImage(love.graphics.newImage("character/player/assets/Healer/Idle/Idle-Sheet.png")) -- Image de l'Healer
    instance:setInventory({}) -- Inventaire vide
    instance:setCooldown(0) --Cooldown de la compétence
    instance:setX(0) -- Position x de l'Healer
    instance:setY(0) -- Position y de l'Healer
    instance:setQuad(instance:AssoImage("character/player/assets/Healer/Idle/Idle-Sheet.png")[1])
    instance:setMaxHp(80)
    return instance -- Renvoie l'instance nouvellement créée
end

function Healer:getName()
    return "Healer"
end

-- Compétence du healer : soigner de 50hp
function Healer:Competence()
    self:setCooldown(3)
    self:soigner(50)
end

-- Renvoie la classe Healer avec ses méthodes et propriétés
return Healer