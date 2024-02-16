-- Définition de la classe ArmureFer
local obj = require("objet.Objet")

local ArmureFer = {}

setmetatable(ArmureFer, {__index = obj})
-- Constructeur de la classe ArmureFer
function ArmureFer:new()
    local instance = obj:new()
    setmetatable(instance, {__index = ArmureFer})
    instance:setPuissance(15)
    instance:setType("Armure")
    instance:setName("Armure en Fer")
    instance.id = 2 --Id
    return instance
end

function ArmureFer:getId()
    return self.id
end 


function ArmureFer:getDescription()
    return "Armure en Fer , rajoute 5 points de defense"
end

return ArmureFer