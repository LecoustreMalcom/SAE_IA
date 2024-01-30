-- Assassin.lua

-- Importe la classe parente Personnage
local Personnage = require("character.player.Personnage")

-- Crée une table vide nommée "Assassin" qui servira de classe enfant de Personnage
local Assassin = {}
setmetatable(Assassin, {__index = Personnage}) 

-- Méthode constructeur pour créer une nouvelle instance de la classe Assassin
function Assassin:new()
    local instance = Personnage:new()-- Crée une nouvelle instance vide avec la métatable Assassi
    setmetatable(instance, {__index = Assassin})
    instance:setHp(85) -- Points de vie
    instance:setAttack(10) -- Attaque
    instance:setDef(0) -- Défense
    instance:setLuck(5) -- Chance
    instance:setVitesse(4) --Vitesse
    instance:setImage(love.graphics.newImage("character/player/assets/assassin/Sheet_Assassin.png")) -- Image de l'Assassin
    instance:setInventory({}) -- Inventaire vide
    instance:setCooldown(0) --Cooldown de la compétence
    instance:setX(0) -- Position x de l'Assassin
    instance:setY(0) -- Position y de l'Assassin
    instance:setQuad(instance:AssoImage("character/player/assets/assassin/Sheet_Assassin.png")[1])
    instance:setMaxHp(85)
    return instance -- Renvoie l'instance nouvellement créée
end

function Assassin:getName()
    return "Assassin"
end


function Assassin:Competence()
    self:setCooldown(3)
    return "saignement"
end

function Assassin:getDescComp()
    return "Met un état de saignement ,affligeant 3 dégats supplémentaire à chaque tour"
end

-- Renvoie la classe Assassin avec ses méthodes et propriétés
return Assassin