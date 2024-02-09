-- Définition de la classe Plateau
Plateau = {}
Plateau.__index = Plateau

local Graal = require("objet.obj_supreme.graal")   

-- Constructeur de la classe Plateau
function Plateau.new(taille)
    local self = setmetatable({}, Plateau)
    self.taille = taille
    self.plateau = {}
    for i = 1, taille do
        self.plateau[i] = {}
        for j = 1, taille do
            self.plateau[i][j] = "vide"
        end
    end
    return self
end

-- Méthode pour ajouter un objet au plateau
function Plateau:ajouterObjet(x, y, objet)
    if x >= 1 and x <= self.taille and y >= 1 and y <= self.taille then
        self.plateau[y][x] = objet
    else
        print("Coordonnées hors du plateau.")
    end
end

function Plateau:supprimerObjet(objet)  
    local x, y = self:trouverObjet(objet)
    if x and y then
        self:setCase(x, y, objet:getAncienneCase())
    else
        print("Objet non trouvé.")
    end
end

function Plateau:supEnnemie(ennemie)
    local x, y = self:trouverObjet(ennemie)
    if x and y then
        self:setCase(x, y, "vide")
    else
        print("Objet non trouvé.")
    end
end

function Plateau:getCase(x,y)
    return self.plateau[y][x]
end

function Plateau:setCase(x,y,objet)
    self.plateau[y][x] = objet
end
-- Méthode pour ajouter des cases indisponibles au plateau
function Plateau:ajouterIndispo(indispo)
    for _, coord in ipairs(indispo) do
        local x, y = coord[1], coord[2]
        if x ~= nil and y ~= nil and x >= 1 and x <= self.taille and y >= 1 and y <= self.taille then
            if self.plateau[y][x] == "vide" then
                self.plateau[y][x] = "indispo"
            end
        else
            print("Coordonnées hors du plateau.")
        end
    end
end

function Plateau:ajouterVide(vide)
    for _, coord in ipairs(vide) do
        local x, y = coord[1], coord[2]
        if x ~= nil and y ~= nil and x >= 1 and x <= self.taille and y >= 1 and y <= self.taille then
            if self.plateau[y][x] == "indispo" then
                self.plateau[y][x] = "vide"
            end
        else
            print("Coordonnées hors du plateau.")
        end
    end
end

-- Méthode pour trouver la position d'un objet sur le plateau
function Plateau:trouverObjet(objet)
    for i = 1, self.taille do
        for j = 1, self.taille do
            if self.plateau[i][j] == objet then
                return j, i
            end
        end
    end
    return "vide"
end

-- Méthode pour ajouter des cases aléatoires au plateau
function Plateau:ajouterAleatoire()
    local casesVides = {}
    for i = 1, self.taille do
        for j = 1, self.taille do
            if self:getCase(i, j) == "vide" then
                table.insert(casesVides, {i, j})
            end
        end
    end

    if #casesVides >= 9 then
        for i = 1, 9 do
            local index = love.math.random(1, #casesVides)
            local x, y = casesVides[index][1], casesVides[index][2]
            self:setCase(x, y, "aléatoire")
            table.remove(casesVides, index)
        end
    else
        print("Pas assez de cases vides.")
    end
end

function Plateau:ajouterCaseSpeciale()
    self:setCase(10,14,"shop")
    self:setCase(16,5,"torture")
    self:setCase(1,15,"ecurie")
end

-- Méthode pour déplacer un objet d'une position à une autre
function Plateau:deplacerObjet(objet, x, y,ancienne_case)
    local oldX, oldY = self:trouverObjet(objet)
    local case_avant = self:getCase(x,y)
    if oldX and oldY then
        if ancienne_case == nil then 
            self:setCase(oldX, oldY, "vide")
            self:setCase(x, y, objet)
        else
            self:setCase(oldX, oldY, ancienne_case)
            self:setCase(x, y, objet)
        end
        objet:setAncienneCase(case_avant)
    else
        print("Objet non trouvé.")
    end
end

function Plateau:plateau_to_graph()
    local graph = {}

    -- Parcourir toutes les cases du plateau
    for i = 1, self.taille do
        for j = 1, self.taille do
            -- Vérifier si la case est vide ou non indisponible
            local case = self:getCase(i, j)
            if case ~= "indispo" then
                -- Ajouter la case comme un noeud dans le graphe
                local node = i .. "," .. j
                graph[node] = {}

                -- Ajouter les cases adjacentes comme des voisins dans le graphe
                if i > 1 then
                    local neighbor = self:getCase(i-1, j)
                    if neighbor ~= "indispo" then
                        table.insert(graph[node], (i-1) .. "," .. j)
                    end
                end

                if i < self.taille then
                    local neighbor = self:getCase(i+1, j)
                    if neighbor ~= "indispo" then
                        table.insert(graph[node], (i+1) .. "," .. j)
                    end
                end

                if j > 1 then
                    local neighbor = self:getCase(i, j-1)
                    if neighbor ~= "indispo" then
                        table.insert(graph[node], i .. "," .. (j-1))
                    end
                end

                if j < self.taille then
                    local neighbor = self:getCase(i, j+1)
                    if neighbor ~= "indispo" then
                        table.insert(graph[node], i .. "," .. (j+1))
                    end
                end
            end
        end
    end

    return graph
end


function Plateau:estVide(caseX,caseY)
    if self.plateau[caseY][caseX] == "vide" then
        return true
    else
        return false
    end
end

function Plateau:getAccess(Dragon,joueur,access)
    if joueur:getGraal() ~= nil and Dragon:getHp() == 0  and access == false then
        self:ajouterVide({{3,10},{4,10},{5,10},{6,10},{7,10},{8,10},{8,9},{8,8}})
        access = true
        return access
    else
        return access
    end
    
end

local count_graal = 0

function Plateau:giveGraal(joueur)
    if joueur:getGraal() == nil  and count_graal == 0 and joueur:getX() == 120 and joueur:getY() == 120 then
        count_graal = 1
        local graal = Graal:new()
        joueur:setGraal(graal)
        love.window.showMessageBox("Graal","Vous avez trouvé le Graal, vos hp sont renforcé de 50hp.", {"OK"})
        joueur:setMaxHp(joueur:getMaxHp() + 50)
        joueur:soigner(joueur:getMaxHp())
    end
end
    

return Plateau