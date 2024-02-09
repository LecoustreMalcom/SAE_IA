-- Définition de la classe Sword
local obj = require("objet.Objet")

local Sword = {}

setmetatable(Sword, {__index = obj})
-- Constructeur de la classe Sword
function Sword:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Sword})
    instance:setPuissance(15)
    instance:setType("Arme")
    instance:setName("Sword")
    return instance
end


function Sword:getDescription()
    return "Sword , rajoute 15 de degats"
end

return Sword