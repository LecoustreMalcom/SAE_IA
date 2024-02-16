-- Gobelin.lua
local Entite = require("character.ennemies.entite_malefique")
local Massue = require("objet.weapon.massue")

-- Crée une table vide nommée "Gobelin" qui servira de classe enfant
local Gobelin = {}
setmetatable(Gobelin, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Gobelin
function Gobelin:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Gobelin 
    setmetatable(instance, {__index = Gobelin}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 30 -- Points de vie
    instance.attack = 2 -- Attaque
    instance.defense = 0 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/gobelin/Goblin_Sheet.png") -- Image de l'Gobelin
    instance.quad = (instance:AssoImage("character/ennemies/assets/gobelin/Goblin_Sheet.png")[1]) -- Quad de l'Gobelin
    instance.x = 0 -- Position x de l'Gobelin
    instance.y = 0 -- Position y de l'Gobelin
    instance.name = "Gobelin"
    instance.id = 2 --Id
    return instance -- Renvoie l'instance nouvellement créée
end

function Gobelin:getId()
    return self.id
end


function Gobelin:getName()
    return self.name
end

function Gobelin:drop()
    local ecu_possible = {2,3,4}
    local liste_drop = {}
    local ecu = ecu_possible[math.random(1,3)]
    table.insert(liste_drop,Massue:new())
    return ecu,liste_drop
end

function Gobelin:FullVie()
    self:setHp(30)
end


function Gobelin:AssoImage(spriteSheetPath)
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

function Gobelin:afficher()
    love.graphics.draw(self.image, self.quad, self.x, self.y - 20,_,1.5,1.5)
end

    
-- Renvoie la classe Gobelin avec ses méthodes et propriétés
return Gobelin