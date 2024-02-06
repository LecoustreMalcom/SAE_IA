local Personnage = require "character.player.Personnage"

local Custom = {}

setmetatable(Custom, {__index = Personnage})

function Custom:new()
    local instance = Personnage:new()
    setmetatable(instance, {__index = Custom})
    instance:setHp(100)
    instance:setAttack(0)
    instance:setDef(0)
    instance:setLuck(0)
    instance:setImage(love.graphics.newImage("character/player/assets/Custom/Idle/Custom.png"))
    instance:setInventory({})
    instance:setCooldown(0)
    instance:setX(0)
    instance:setY(0)
    instance:setQuad(instance:AssoImage("character/player/assets/Custom/Idle/Custom.png")[1])
    instance:setMaxHp(100)
    return instance
end

function Custom:getName()
    return "Custom"
end

function Custom:Competence()
    self:setCooldown(3)
    return self:getAttack() * 2
end

function Custom:AssoImage(spriteSheetPath)
    -- Chargez votre image de sprite sheet
    local spriteSheet = love.graphics.newImage(spriteSheetPath)
 
    -- Définissez les dimensions de chaque sprite dans la feuille
    local spriteWidth = 30 -- Largeur de chaque sprite
    local spriteHeight = 30 -- Hauteur de chaque sprite
 
    -- Créez un quad pour chaque sprite dans la feuille
    local quads = {} -- Tableau pour stocker les quads
    for y = 0, spriteSheet:getHeight() - spriteHeight, spriteHeight do
        for x = 0, spriteSheet:getWidth() - spriteWidth, spriteWidth do
            table.insert(quads, love.graphics.newQuad(x, y, spriteWidth, spriteHeight, spriteSheet:getDimensions()))
        end
    end
 
    -- Renvoyez le tableau quads
    return quads
end

function Custom:getDescComp()
    return "Tire une flèche infligeant 2 fois plus de dégats"
end

return Custom