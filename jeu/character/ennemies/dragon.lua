-- Dragon.lua
local Entite = require("character.ennemies.entite_malefique")

-- Crée une table vide nommée "Dragon" qui servira de classe enfant
local Dragon = {}
setmetatable(Dragon, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Dragon
function Dragon:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Dragon 
    setmetatable(instance, {__index = Dragon}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 200 -- Points de vie
    instance.attack = 20 -- Attaque
    instance.defense = 10 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Dragon/Animations/Adult_Red_Dragon/Red_Dragon_Sheet.png") -- Image de l'Dragon
    instance.quad = (instance:AssoImage("character/ennemies/assets/Dragon/Animations/Adult_Red_Dragon/Red_Dragon_Sheet.png")[1]) -- Quad de l'Dragon
    instance.x = 0 -- Position x de l'Dragon
    instance.y = 0 -- Position y de l'Dragon
    instance.name = "Dragon"
    instance.id = 6 -- Id
    return instance -- Renvoie l'instance nouvellement créée
end

function Dragon:getId()
    return self.id
end

function Dragon:getName()
    return self.name
end

function Dragon:drop()
    local ecu_possible = {25,30,35}
    local ecu = ecu_possible[math.random(1,3)]
    local liste_drop = {}
    return ecu,liste_drop
end


function Dragon:AssoImage(spriteSheetPath)
    -- Chargez votre image de sprite sheet
    local spriteSheet = love.graphics.newImage(spriteSheetPath)
 
    -- Définissez les dimensions de chaque sprite dans la feuille
    local spriteWidth = 16 -- Largeur de chaque sprite
    local spriteHeight = 16 -- Hauteur de chaque sprite
 
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

function Dragon:afficher()
    love.graphics.draw(self.image, self.quad, self.x, self.y,_,6,6)
end

function Dragon:FullVie()
    self:setHp(200)
end
    
-- Renvoie la classe Dragon avec ses méthodes et propriétés
return Dragon