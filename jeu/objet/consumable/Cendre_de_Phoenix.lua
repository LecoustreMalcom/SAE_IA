-- Définition de la classe Cendre
local obj = require("objet.Objet")

local Cendre = {}

setmetatable(Cendre, {__index = obj})
-- Constructeur de la classe Cendre
function Cendre:new()
    local instance = obj:new()
    setmetatable(instance, {__index = Cendre})
    instance:setPuissance(40)
    instance:setType("Soin")
    instance:setName("Cendre de Phoenix")
    return instance
end


function Cendre:getDescription()
    return "Cendre de Phoenix , Permet de soigner de 40hp"
end

function Cendre:heal(Joueur)
    Joueur:soigner(self:getPuissance())
    
end

return Cendre