-- Définition de la classe ArmureMaille
local obj = require("objet.Objet")

local ArmureMaille = {}

setmetatable(ArmureMaille, {__index = obj})
-- Constructeur de la classe ArmureMaille
function ArmureMaille:new()
    local instance = obj:new()
    setmetatable(instance, {__index = ArmureMaille})
    instance:setPuissance(3)
    instance:setType("Armure")
    instance:setName("Armure en Maille")
    instance.id = 5 --Id 
    return instance
end

function ArmureMaille:getId()
    return self.id
end 

function ArmureMaille:getDescription()
    return "Armure en cuir , rajoute 3 points de defense "
end

return ArmureMaille