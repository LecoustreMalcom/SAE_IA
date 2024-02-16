-- Centaure.lua
local Entite = require("character.ennemies.entite_malefique")
local bouclier = require("objet.obj_supreme.bouclier_lancelot")

-- Crée une table vide nommée "Centaure" qui servira de classe enfant
local Centaure = {}
setmetatable(Centaure, {__index = Entite})

-- Méthode constructeur pour créer une nouvelle instance de la classe Centaure
function Centaure:new()
    local instance = Entite:new() -- Crée une nouvelle instance vide avec la métatable Centaure 
    setmetatable(instance, {__index = Centaure}) -- Définit la métatable de la nouvelle instance pour permettre l'héritage
    instance.Hp = 90 -- Points de vie
    instance.attack = 8 -- Attaque
    instance.defense = 5 -- Défense
    instance.image = love.graphics.newImage("character/ennemies/assets/Centaur/Centaur.png") -- Image de l'Centaure
    instance.x = 0 -- Position x de l'Centaure
    instance.y = 0 -- Position y de l'Centaure
    instance.name = "Centaure"
    instance.id = 8 --Id
    return instance -- Renvoie l'instance nouvellement créée
end

function Centaure:getId()
    return self.id
end

function Centaure:getName()
    return self.name
end

function Centaure:drop()
    local ecu_possible = {6,7,8}
    local liste_drop = {}
    local ecu = ecu_possible[math.random(1,3)]
    table.insert(liste_drop,bouclier:new())
    return ecu,liste_drop
end


function Centaure:afficher()
    love.graphics.draw(self.image, self.x, self.y,_,0.25,0.25)
end
    
-- Renvoie la classe Centaure avec ses méthodes et propriétés
return Centaure