-- Définition de la classe Potion
local obj = require("objet.Objet")

local Potion = {}

setmetatable(Potion, {__index = obj})
-- Constructeur de la classe Potion
function Potion:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Potion})
    instance:setPuissance(20)
    instance:setType("Soin")
    instance:setName("Potion")
    instance.id = 3 --Id 
    return instance
end

function Potion:getId()
    return self.id
end 

function Potion:getDescription()
    return "Potion , Permet de soigner 20hp"
end

function Potion:heal(Joueur)
    Joueur:soigner(self:getPuissance())
    
end

return Potion