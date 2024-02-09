-- Définition de la classe Graal
local obj = require("objet.Objet")

local Graal = {}

setmetatable(Graal, {__index = obj})
-- Constructeur de la classe Graal
function Graal:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Graal})
    instance:setPuissance(50)
    return instance
end


function Graal:getDescription()
    return "Bouclier de lancelot , rajoute 50 points de vie "
end

return Graal