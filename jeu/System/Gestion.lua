math.randomseed(os.time())

require "System.getClasseJoueur"
local Gobelin = require "character.ennemies.gobelin"
local Phoenix = require "character.ennemies.phoenix"
local Dragon = require "character.ennemies.dragon"   
local Squelette = require "character.ennemies.Squelette" 
local Satan = require "character.ennemies.satan"
local Centaure = require "character.ennemies.centaure"
local Chimere = require "character.ennemies.chimère"

function AddItem(joueur,objet)
    local inventaire = joueur:getInventory()
    table.insert(inventaire,objet)
    joueur:setInventory(inventaire)
end

-- Fonction pour afficher l'inventaire d'un joueur
function AfficherInventaire(joueur)
    local inventaire = joueur:getInventory()
    
    print("Inventaire de j1 : ")
    
    if #inventaire == 0 then
        print("L'inventaire est vide.")
    else
        for i, objet in ipairs(inventaire) do
            print(i .. ". " .. objet:getNom())
        end
    end
end

function PrintTable(t)
    for i, v in ipairs(t) do
        if type(v) == "table" then
            for j, k in ipairs(v) do
                print("Tableau "..i..", Element "..j..": "..tostring(k))
            end
        else
            print("Element "..i..": "..tostring(v))
        end
    end
end

function AddJoueur(plat,compte_j,gridSize,playerClasses,width,stats)

    local Place_p1_x = width - (width / 16) * 13
    local Place_p2_x = width - (width / 16) * 13
    local Place_p3_x = width - (width / 16) * 14
    local Place_p4_x = width - (width / 16) * 14
    

    local Place_p1_y = width - (width / 16) * 4
    local Place_p2_y = width - (width / 16) * 2
    local Place_p3_y = width - (width / 16) * 4
    local Place_p4_y = width - (width / 16) * 2

    if compte_j > 0 then
        J1 = GetClasseJoueur(playerClasses[1],stats,1)
        plat:ajouterObjet(math.floor(Place_p1_x / gridSize) + 1, math.floor(Place_p1_y / gridSize) + 1, J1)
        J1:setX(Place_p1_x)
        J1:setY(Place_p1_y)
        if compte_j > 1 then
            J2 = GetClasseJoueur(playerClasses[2],stats,2)
            plat:ajouterObjet(math.floor(Place_p2_x / gridSize) + 1, math.floor(Place_p2_y / gridSize) + 1, J2)
            J2:setX(Place_p2_x)
            J2:setY(Place_p2_y)

            if compte_j > 2 then
                J3 = GetClasseJoueur(playerClasses[3],stats,3)
                plat:ajouterObjet(math.floor(Place_p3_x / gridSize) + 1, math.floor(Place_p3_y / gridSize) + 1, J3)
                J3:setX(Place_p3_x)
                J3:setY(Place_p3_y)

                if compte_j > 3 then
                    J4 = GetClasseJoueur(playerClasses[4],stats,4)
                    plat:ajouterObjet(math.floor(Place_p4_x / gridSize) + 1, math.floor(Place_p4_y / gridSize) + 1, J4)
                    J4:setX(Place_p4_x)
                    J4:setY(Place_p4_y)
                end
            end
        end
    end

    return J1,J2,J3,J4

end

local choice = math.random(1,2)

function Add_mob(plat,width,gridSize)
    local Place_gob_1_X = width - (width / 16) 
    local Place_gob_y = width - (width / 16) * 7

    local Place_gob_2_X = width - (width / 16) * 2
    local Place_gob2_y = width - (width / 16) * 9

    local Place_phoenix_x = width - (width / 16) * 9
    local Place_phoenix_y = width - (width / 16) * 15

    local Place_dragon_x = width - (width / 16) 
    local Place_dragon_y = width - (width / 16) * 16

    local Place_skel_x = width - (width / 16) * 7
    local Place_skel_y = width - (width / 16) * 12

    local Place_skel2_x =  width - (width / 16) * 15
    local Place_skel2_y =   width - (width / 16) * 6

    local Place_satan_x = width - (width / 16) * 9
    local Place_satan_y = width - (width / 16) * 10

    local Plate_ennemi_alea_x = width - (width / 16) * 13
    local Plate_ennemi_alea_y = width - (width / 16) * 13

    local gob = Gobelin:new()
    plat:ajouterObjet(math.floor(Place_gob_1_X / gridSize) + 1, math.floor(Place_gob_y / gridSize) + 1, gob)
    gob:setX(Place_gob_1_X)
    gob:setY(Place_gob_y)

    local gob2 = Gobelin:new()
    plat:ajouterObjet(math.floor(Place_gob_2_X / gridSize) + 1, math.floor(Place_gob2_y / gridSize) + 1, gob2)
    gob2:setX(Place_gob_2_X)
    gob2:setY(Place_gob2_y)

    local skel1 = Squelette:new()
    plat:ajouterObjet(math.floor(Place_skel_x / gridSize) + 1, math.floor(Place_skel_y / gridSize) + 1, skel1)
    skel1:setX(Place_skel_x)
    skel1:setY(Place_skel_y)

    local skel2 = Squelette:new()
    plat:ajouterObjet(math.floor(Place_skel2_x / gridSize) + 1, math.floor(Place_skel2_y / gridSize) + 1, skel2)
    skel2:setX(Place_skel2_x)
    skel2:setY(Place_skel2_y)

    local Phoenix = Phoenix:new()
    plat:ajouterObjet(math.floor(Place_phoenix_x / gridSize) + 1, math.floor(Place_phoenix_y / gridSize) + 1, Phoenix)
    Phoenix:setX(Place_phoenix_x)
    Phoenix:setY(Place_phoenix_y)

    local Dragon = Dragon:new()
    plat:ajouterObjet(math.floor(Place_dragon_x / gridSize) + 1, math.floor(Place_dragon_y / gridSize) + 1, Dragon)
    Dragon:setX(Place_dragon_x)
    Dragon:setY(Place_dragon_y)

    local Satan = Satan:new()
    plat:ajouterObjet(math.floor(Place_satan_x / gridSize) + 1, math.floor(Place_satan_y / gridSize) + 1, Satan)
    Satan:setX(Place_satan_x)
    Satan:setY(Place_satan_y)

    local ennemie_alea

    if choice == 1 then
        ennemie_alea = Centaure:new()
    else
        ennemie_alea = Chimere:new()
    end
    
    plat:ajouterObjet(math.floor(Plate_ennemi_alea_x / gridSize) + 1, math.floor(Plate_ennemi_alea_y / gridSize) + 1, ennemie_alea)
    ennemie_alea:setX(Plate_ennemi_alea_x)
    ennemie_alea:setY(Plate_ennemi_alea_y)

    return gob,gob2,Phoenix,Dragon,skel1,skel2,Satan,ennemie_alea
end

function  Liste_j(J1,J2,J3,J4)
    local list_j = {}

    if J1 ~= nil then
        table.insert(list_j,J1)
    end

    if J2 ~= nil then
        table.insert(list_j,J2)
    end

    if J3 ~= nil then
        table.insert(list_j,J3)
    end

    if J4 ~= nil then
        table.insert(list_j,J4)
    end

    return list_j
    
end

function  Liste_mob(...)
    local liste_mob = {...}
    return liste_mob
end

function Moove_cam(cameraY,speed_cam,dt)
    if love.keyboard.isDown("down") and cameraY < love.graphics.getHeight() - 256 then
        cameraY = cameraY + speed_cam * dt
    elseif love.keyboard.isDown("up") and cameraY > 0 then
        cameraY = cameraY - speed_cam * dt
    end
    return cameraY
end

function EndGame(joueur, monstre, Liste_j)
    if monstre:getHp() == 0 and joueur:getX() == 1800 and joueur:getY() == 240 then
        local joueur_en_cours = nil
        for i, j in ipairs(Liste_j) do
            if j == joueur then
                joueur_en_cours = i
                break
            end
        end
        if joueur_en_cours ~= nil then
            love.window.showMessageBox("Victoire", "Félicitations Joueur " .. joueur_en_cours .. " d'avoir gagné.", {"OK"})
            love.event.quit()
        end
    end
end

function IncreaseStat(stats, statName, amount)
    stats[statName] = stats[statName] + amount
    return stats
end

function DecreaseStat(stats, statName, amount)
    if stats[statName] and stats[statName] > 0 then
        stats[statName] = stats[statName] - amount
    end
    return stats
end

function CountStats(stats)
    local total = 0
    for _, value in pairs(stats) do
        total = total + value
    end
    return total
end

function ResetStats(stats)
    for key, _ in pairs(stats) do
        stats[key] = 0
    end
end

function ShowCustom(Slab,base,compte_j)

    local list = base[compte_j + 1]

    local max = 20
    local total = CountStats(list)

    -- Get screen size
    local screenWidth, screenHeight = love.graphics.getDimensions()

    -- Calculate window position
    local windowX = screenWidth / 4.5
    local windowY = screenHeight * 3 / 4

    if Slab.BeginWindow('AttributeWindow', {Title = 'Attribute Points', X = windowX, Y = windowY}) then
        for stat, value in pairs(list) do
            Slab.Text(stat .. ": " .. value)
            if  total < 20 then
                if Slab.Button("Increase " .. stat) then
                    list = IncreaseStat(list, stat, 1)
                end
            end
            if value ~= nil and tonumber(value) > 0 then
                if Slab.Button("Decrease " .. stat) then
                    list = DecreaseStat(list, stat, 1)
                end
            end
        end
        Slab.Text("Points restant : " .. max - total)
    end
    Slab.EndWindow()
    Slab.Draw()
end