-- Chevalier.lua

-- Importe la classe parente Personnage
local Personnage = require("character.player.Personnage")

-- Crée une table vide nommée "Chevalier" qui servira de classe enfant de Personnage
local Chevalier = {}

-- Définit la métatable de la table "Chevalier" pour permettre l'héritage
setmetatable(Chevalier, {__index = Personnage})

-- Méthode constructeur pour créer une nouvelle instance de la classe Chevalier
function Chevalier:new()
    local instance = Personnage:new()-- Crée une nouvelle instance vide avec la métatable Chevalier
    setmetatable(instance, {__index = Chevalier}) -- Hérite de la classe Personnage
    instance:setHp(100) -- Points de vie
    instance:setAttack(8) -- Attaque
    instance:setDef(1) -- Défense
    instance:setLuck(2) -- Chance
    instance:setImage(love.graphics.newImage("character/player/assets/Knight/Idle/Idle-Sheet.png")) -- Image du Chevalier
    instance:setQuad(instance:AssoImage("character/player/assets/Knight/Idle/Idle-Sheet.png")[1])
    instance:setInventory({}) -- Inventaire vide
    instance:setCooldown(0) --Cooldown de la compétence
    instance:setX(0)
    instance:setY(0)
    instance:setMaxHp(100)
    return instance -- Renvoie l'instance nouvellement créée
end

function Chevalier:getName()
    return "Chevalier"
end

function Chevalier:Competence()
    self:setCooldown(3)
    return self:getDef() + 2
end

-- Renvoie la classe Chevalier avec ses méthodes et propriétés
return Chevalier