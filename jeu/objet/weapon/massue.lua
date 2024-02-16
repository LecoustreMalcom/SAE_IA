-- Définition de la classe Massue
local obj = require("objet.Objet")

local Massue = {}

setmetatable(Massue, {__index = obj})
-- Constructeur de la classe Massue
function Massue:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Massue})
    instance:setPuissance(5)
    instance:setType("Arme")
    instance:setName("Massue")
    instance.id = 6 --Id
    return instance
end

function Massue:getId()
    return self.id
end

function Massue:getDescription()
    return "Massue , rajoute 5 de degats"
end

return Massue