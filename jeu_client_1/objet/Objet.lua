-- Définition de la classe mère Objet
local Objet = {}
Objet.__index = Objet

function Objet:new()
    local self = setmetatable({}, Objet)
    self.puissance = 0
    self.type = ""
    self.name = ""
    return self
end

function Objet:getPuissance()
    return self.puissance
end

function Objet:getType()
    return self.type
end

function Objet:getName()
    return self.name
end

function Objet:setPuissance(puissance)
    self.puissance = puissance
end

function Objet:setType(type)
    self.type = type
end

function Objet:setName(name)
    self.name = name
end

function Objet:LaMeme(objet)
    if self:getName() == objet:getName() then
        return true
    else
        return false
    end
end

return Objet