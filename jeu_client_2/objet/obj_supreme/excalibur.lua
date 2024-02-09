-- Définition de la classe Excalibur
local obj = require("objet.Objet")

local Excalibur = {}

setmetatable(Excalibur, {__index = obj})
-- Constructeur de la classe Excalibur
function Excalibur:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Excalibur})
    instance:setPuissance(40)
    instance:setType("Arme")
    instance:setName("Excalibur")
    return instance
end


function Excalibur:getDescription()
    return "Excalibur , rajoute 40 points d'attaque "
end

return Excalibur