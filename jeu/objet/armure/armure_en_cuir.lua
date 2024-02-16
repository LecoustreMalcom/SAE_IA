-- Définition de la classe ArmureCuir
local obj = require("objet.Objet")

local ArmureCuir = {}

setmetatable(ArmureCuir, {__index = obj})
-- Constructeur de la classe ArmureCuir
function ArmureCuir:new()
    local instance = obj:new()
    setmetatable(instance, {__index = ArmureCuir})
    instance:setPuissance(2)
    instance:setType("Armure")
    instance:setName("Armure en Cuir")
    instance.id = 4 --Id
    return instance
end

function ArmureCuir:getId()
    return self.id
end


function ArmureCuir:getDescription()
    return "Armure en cuir , rajoute 2 points de defense "
end

return ArmureCuir