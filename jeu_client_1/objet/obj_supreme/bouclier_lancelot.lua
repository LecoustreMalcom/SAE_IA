-- Définition de la classe BouclierLancelot
local obj = require("objet.Objet")

local BouclierLancelot = {}

setmetatable(BouclierLancelot, {__index = obj})
-- Constructeur de la classe BouclierLancelot
function BouclierLancelot:new()
    local instance = obj:new()
    setmetatable(instance, {__index = BouclierLancelot})
    instance:setPuissance(15)
    instance:setType("Armure")
    instance:setName("Bouclier de Lancelot")
    return instance
end


function BouclierLancelot:getDescription()
    return "Bouclier de lancelot , rajoute 15 points de defense "
end

return BouclierLancelot