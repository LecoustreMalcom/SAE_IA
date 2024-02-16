-- Phoenix.lua
local Entite = require("character.ennemies.entite_malefique")
local Lance = require("objet.weapon.lance")
local Armure_Maille = require("objet.armure.armure_en_maille")
local Cendre = require("objet.consumable.Cendre_de_Phoenix")

-- Crée une table vide nommée "Phoenix" qui servira de classe enfant
local Phoenix = {}
setmetatable(Phoenix, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Phoenix
function Phoenix:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Phoenix 
    setmetatable(instance, {__index = Phoenix}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 70 -- Points de vie
    instance.attack = 12 -- Attaque
    instance.defense = 5 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Phoenix/Phoenix_Sheet.png") -- Image de l'Phoenix
    instance.x = 0 -- Position x de l'Phoenix
    instance.y = 0 -- Position y de l'Phoenix
    instance.name = "Phoenix"
    instance.id = 4 --Id
    return instance -- Renvoie l'instance nouvellement créée
end

function Phoenix:getId()
    return self.id
end

function Phoenix:getName()
    return self.name
end


function Phoenix:drop()
    local ecu_possible = {10,12,14}
    local ecu = ecu_possible[math.random(1,3)]
    local liste_drop = {Cendre:new(),Armure_Maille:new(),Lance:new()}
    return ecu,liste_drop
end

function Phoenix:FullVie()
    self:setHp(70)
end

function Phoenix:afficher()
    love.graphics.draw(self.image, self.x, self.y,_,4,4)
end
    
-- Renvoie la classe Phoenix avec ses méthodes et propriétés
return Phoenix