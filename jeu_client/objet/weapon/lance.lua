-- Définition de la classe Lance
local obj = require("objet.Objet")

local Lance = {}

setmetatable(Lance, {__index = obj})
-- Constructeur de la classe Lance
function Lance:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Lance})
    instance:setPuissance(10)
    instance:setType("Arme")
    instance:setName("Lance")
    return instance
end


function Lance:getDescription()
    return "Lance , rajoute 10 de degats"
end

return Lance