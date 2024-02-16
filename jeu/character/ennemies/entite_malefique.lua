-- Entite.lua
math.randomseed(os.time())

-- Crée une table vide nommée "Entite" qui servira de classe parente
local Entite = {}

-- Définit la métatable de la table "Entite" pour permettre l'héritage
Entite.__index = Entite

-- Méthode constructeur pour créer une nouvelle instance de la classe Entite
function Entite:new()
    local self = setmetatable({}, Entite) -- Crée une nouvelle instance vide avec la métatable Entite
    self.Hp = 0 -- Points de vie
    self.attack = 0 -- Attaque
    self.defense = 0 -- Défense
    self.image = "" -- Image du Entite
    self.quad = "" -- Quad du Entite
    self.x = 0 -- Position x du Entite
    self.y = 0 -- Position y du Entite
    self.etat = nil
    self.name = "Entite_malefique"
    self.id = 5 -- Id
    return self -- Renvoie l'instance nouvellement créée
end

function Entite:getId()
    return self.id
end

function Entite:getName()
    return self.name
end
-- Méthodes pour obtenir les attributs du Entite
function Entite:getHp()
    return self.Hp
end

function Entite:getAttack()
    return self.attack
end

function Entite:getDef()
    return self.defense
end

function Entite:getImage()
    return self.image
end

function Entite:getQuad()
    return self.quad
end

function Entite:getX()
    return self.x
end

function Entite:getY()
    return self.y
end

function Entite:getEtat()
    return self.etat
end

function Entite:getNom()
    return self.name
end

-- Méthodes pour définir les attributs du Entite
function Entite:setHp(Hp)
    self.Hp = Hp
end

function Entite:loseHp(hp)
    self.Hp = self.Hp - hp
end

function Entite:setAttack(Attack)
    self.attack = Attack
end

function Entite:setDef(Def)
    self.defense = Def
end

function Entite:setImage(Image)
    self.image = Image
end

function Entite:setQuad(Quad)
    self.quad = Quad
end

function Entite:setX(X)
    self.x = X
end

function Entite:setY(Y)
    self.y = Y
end

function Entite:setEtat(Etat)
    self.etat = Etat
end

function Entite:returnType()
    return "Entite"
end

function Entite:AssoImage(spriteSheetPath)
    -- Chargez votre image de sprite sheet
    local spriteSheet = love.graphics.newImage(spriteSheetPath)
 
    -- Définissez les dimensions de chaque sprite dans la feuille
    local spriteWidth = 32 -- Largeur de chaque sprite
    local spriteHeight = 32 -- Hauteur de chaque sprite
 
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

-- Méthode pour afficher le Entite à une position donnée
-- Méthode pour afficher le personnage à une position donnée
function Entite:afficher()
    love.graphics.draw(self.image, self.quad, self.x, self.y,_,2,2)
end

-- Renvoie la classe Entite avec ses méthodes et propriétés
return Entite