-- Squelette.lua
local Entite = require("character.ennemies.entite_malefique")
local Armure = require("objet.armure.armure_en_cuir")

-- Crée une table vide nommée "Squelette" qui servira de classe enfant
local Squelette = {}
setmetatable(Squelette, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Squelette
function Squelette:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Squelette 
    setmetatable(instance, {__index = Squelette}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 30 -- Points de vie
    instance.attack = 2 -- Attaque
    instance.defense = 0 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Skeleton/Skeleton_Sheet.png") -- Image de l'Squelette
    instance.quad = (instance:AssoImage("character/ennemies/assets/Skeleton/Skeleton_Sheet.png")[1]) -- Quad de l'Squelette
    instance.x = 0 -- Position x de l'Squelette
    instance.y = 0 -- Position y de l'Squelette
    instance.name = "Squelette"
    return instance -- Renvoie l'instance nouvellement créée
end


function Squelette:drop()
    local ecu_possible = {3,4,5}
    local liste_drop = {}
    local ecu = ecu_possible[math.random(1,3)]
    table.insert(liste_drop,Armure:new())
    return ecu,liste_drop
end

function Squelette:AssoImage(spriteSheetPath)
    -- Chargez votre image de sprite sheet
    local spriteSheet = love.graphics.newImage(spriteSheetPath)
 
    -- Définissez les dimensions de chaque sprite dans la feuille
    local spriteWidth = 64 -- Largeur de chaque sprite
    local spriteHeight = 64 -- Hauteur de chaque sprite
 
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

function Squelette:FullVie()
    self:setHp(30)
end

    
-- Renvoie la classe Squelette avec ses méthodes et propriétés
return Squelette