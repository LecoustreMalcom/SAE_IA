-- Personnage.lua

-- Crée une table vide nommée "Personnage" qui servira de classe parente
local Personnage = {}

-- Définit la métatable de la table "Personnage" pour permettre l'héritage
Personnage.__index = Personnage

-- Méthode constructeur pour créer une nouvelle instance de la classe Personnage
function Personnage:new()
    local self = setmetatable({}, Personnage) -- Crée une nouvelle instance vide avec la métatable Personnage
    self.Hp = 0 -- Points de vie
    self.maxHp = 0 -- Points de vie maximum
    self.attack = 0 -- Attaque
    self.defense = 0 -- Défense
    self.luck = 0 -- Chance
    self.image = nil -- Image du personnage
    self.inventaire = {} -- Inventaire vide
    self.cooldown = 0 --Cooldown de la compétence
    self.weapon = nil
    self.graal = nil
    self.x = 0 -- Position x du personnage
    self.y = 0 -- Position y du personnage
    self.quad = nil
    self.ancienne_case = nil
    self.ecu = 0
    self.cheval = nil
    self.armure = nil
    return self -- Renvoie l'instance nouvellement créée
end

-- Méthodes pour obtenir les attributs du personnage
function Personnage:getHp()
    return self.Hp
end

function Personnage:getAttack()
    return self.attack
end

function Personnage:getDef()
    return self.defense
end

function Personnage:getLuck()
    return self.luck
end

function Personnage:returnStats()
    return {"HP = " .. self:getHp(), "Attack = " .. self:getAttack(), "Defense = " .. self:getDef(), "Luck = " .. self:getLuck()} 
end

function Personnage:getCooldown()
    return self.cooldown
end

function Personnage:getArmure()
    return self.armure
end

function Personnage:getWeapon()
    return self.weapon
end

function Personnage:getInventory()
    return self.inventaire 
end

function Personnage:getImage()
    return self.image    
end

function Personnage:getX()
    return self.x
end

function Personnage:getY()
    return self.y
end

function Personnage:getQuad()
    return self.quad
end

function Personnage:getAncienneCase()
    return self.ancienne_case
end

function Personnage:getEcu()
    return self.ecu
end

function Personnage:getCheval()
    return self.cheval
end

function Personnage:getMaxHp()
    return self.maxHp
end

function Personnage:getGraal()
    return self.graal
end

-- Méthodes pour définir les attributs du personnage
function Personnage:setHp(Hp)
    self.Hp = Hp
end

function Personnage:setAttack(Attack)
    self.attack = Attack
end

function Personnage:setDef(Def)
    self.defense = Def
end 

function Personnage:setLuck(Luck)
    self.luck = Luck
end

function Personnage:setCooldown(cooldown)
    self.cooldown = cooldown
end

function Personnage:decreaseCooldown()
    if self.cooldown > 0 then
        self.cooldown = self.cooldown - 1
    end
end

function Personnage:setWeapon(weapon)
    self.weapon = weapon
end

function Personnage:setArmure(armure)
    self.armure = armure
end

function Personnage:setInventory(inventaire)
    self.inventaire = inventaire
end

function Personnage:addInInventory(objet)
    if(#self.inventaire < 9) then
        table.insert(self.inventaire, objet)
    end
end

function Personnage:removeInInventory(ind)
    table.remove(self.inventaire, ind)
end
    

function Personnage:setImage(img)
    self.image = img
end

function Personnage:setQuad(quad)
    self.quad = quad
end

function Personnage:setX(x)
    self.x = x
end

function Personnage:setY(y)
    self.y = y
end

function Personnage:setAncienneCase(ancienne_case)
    self.ancienne_case = ancienne_case
end

function Personnage:setEcu(ecu)
    self.ecu = ecu
end

function Personnage:setCheval(cheval)
    self.cheval = cheval
end 

function Personnage:setMaxHp(maxHp)
    self.maxHp = maxHp
end

function Personnage:setGraal(graal)
    self.graal = graal
end

function Personnage:addEcu(chiffre)
    self.ecu = self.ecu + chiffre
end

function Personnage:removeEcu(chiffre)
    self.ecu = self.ecu - chiffre
end

function Personnage:returnType()
    return "Player"
end

-- Méthode pour rajouter des hp
function Personnage:gainHp(hp)
    local ajout = hp + self:getHp()
    self:setHp(ajout)
end

-- Méthode de perte d'hp
function Personnage:loseHp(hp)
    local perte = self:getHp() - hp
    self:setHp(perte)
end

function Personnage:soigner(hp)
    local gain = self:getHp() + hp
    if  gain > self:getMaxHp() then
        self:setHp(self:getMaxHp())
    else
        self:setHp(gain)
    end
end

function Personnage:FullHp()
    self:setHp(self:getMaxHp())
end

function Personnage:AssoImage(spriteSheetPath)
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

-- Méthode pour afficher le personnage à une position donnée
function Personnage:afficher()
    love.graphics.draw(self.image, self.quad, self.x, self.y,_,2,2)
end

-- Renvoie la classe Personnage avec ses méthodes et propriétés
return Personnage