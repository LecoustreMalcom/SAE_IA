require "System.Fight"

function Accessible_cases(max_dist, plateau, pos_x, pos_y)
    local graph = plateau:plateau_to_graph()
    local cases_possibles = {}
    local visited = {}
    local queue = {{tostring(pos_x) .. "," .. tostring(pos_y), 0}}

    -- Parcourir le graphe pour trouver les cases accessibles
    while #queue > 0 do
        local current = queue[1]
        table.remove(queue, 1)

        if not visited[current[1]] then
            visited[current[1]] = true

            for _, neighbor in ipairs(graph[current[1]]) do
                local neighbor_x, neighbor_y = neighbor:match("(%d+),(%d+)")
                neighbor_x, neighbor_y = tonumber(neighbor_x), tonumber(neighbor_y)
                local distance = current[2] + 1

                if distance <= max_dist and not visited[neighbor] then
                    table.insert(queue, {neighbor, distance})
                    table.insert(cases_possibles, neighbor)
                end
            end
        end
    end
    return cases_possibles
end

function Deplacement(plat,width,x,y,cameraY,cameraX,resultat,joueur,gamestate)
    -- Calculer la position de la case cliquée
    local gridSize = width / 16
    local row = math.floor((y + cameraY) / gridSize) + 1
    local col = math.floor((x + cameraX) / gridSize) + 1
    local message = ""
    local state = gamestate

    -- Vérifier si la case cliquée est vide et si elle ne contient pas le personnage
    local oldX, oldY = plat:trouverObjet(joueur)
    if (plat:getCase(col, row) ~= "vide" and plat:getCase(col, row) ~= "aléatoire" and plat:getCase(col,row) ~= "shop" and plat:getCase(col,row) ~= "torture" and plat:getCase(col,row) ~= "ecurie") or (oldX == col and oldY == row) then
        return state
    end

    local dist = resultat[#resultat]

    if joueur:getCheval() ~= nil then
        dist = dist + 1
    end 

    -- Trouver les cases accessibles à partir de la position actuelle du joueur
    local cases_possible = Accessible_cases(dist, plat, oldX, oldY)

    -- Vérifier si la case cliquée est accessible
    local case = col .. "," .. row
    local accessible = false
    for _, c in ipairs(cases_possible) do
        if c == case then
            accessible = true
            break
        end
    end

    -- Déplacer le joueur dans la case cliquée si elle est accessible
    if accessible then

        plat:deplacerObjet(joueur, col, row,joueur:getAncienneCase())
        joueur:setX((col - 1) * gridSize)
        joueur:setY((row - 1) * gridSize)

        if(joueur:getAncienneCase() == "aléatoire") then
            message = Aleatoire(joueur)
            if message ~= nil then
                love.graphics.print(message, 10, 10)
                love.graphics.present()
                love.timer.sleep(1)
            end
        end

        if(joueur:getAncienneCase() == "shop") then
            state = "shop"
        end

        if(joueur:getAncienneCase() == "torture") then
            state = "torture"
        end

        if (joueur:getAncienneCase() == "ecurie") then
            state = "ecurie"
        end
    end
    return state
end

function LancerCombat(plat,joueur,liste_mob)
    local ennemie = TrouverEnnemi(plat,joueur)
    if ennemie ~= nil then
        Combats(joueur,ennemie)
        if ennemie:getNom() ~= "Centaure" and ennemie:getNom() ~= "Chimere"  and ennemie:getNom() ~= "Dragon" and ennemie:getNom() ~= "Satan" then
            ennemie:FullVie()
            ennemie:setEtat(nil)
        else
            if ennemie:getHp() == 0 then
                plat:supEnnemie(ennemie)
            else
                ennemie:setEtat(nil)
                ennemie:FullVie()
            end
            for i, v in ipairs(liste_mob) do
                if v == ennemie then
                    table.remove(liste_mob, i)
                    break
                end
            end
        end
        if joueur:getHp() == 0 then
            joueur:FullHp()
        end
    end
end

function TrouverEnnemi(plateau,joueur)
    local oldX, oldY = plateau:trouverObjet(joueur)
    local cases_possible = Accessible_cases(1, plateau, oldX, oldY)
    local case = ""
    local accessible = false
    for _, c in ipairs(cases_possible) do
        case = c
        X,Y = case:match("(%d+),(%d+)")
        X,Y = tonumber(X), tonumber(Y)
        if plateau:getCase(X,Y) ~= "vide" and plateau:getCase(X,Y) ~= "aléatoire" and plateau:getCase(X,Y) ~= "shop" and plateau:getCase(X,Y) ~= "torture" and plateau:getCase(X,Y) ~= "ecurie" then
            if plateau:getCase(X,Y):returnType() == "Entite" then
                accessible = true
                break
            end
        end
    end
    if accessible then
        local ennemi = plateau:getCase(X,Y)
        return ennemi
    end
    return nil
end