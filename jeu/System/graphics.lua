function Affi_start(numPlayers,width)
    love.graphics.clear(0, 0, 0)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(Background, 0, 0, 0, width / 1024, width / 1024)
    love.graphics.printf("Combien de joueurs ?", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Nombre de joueurs : " .. numPlayers, 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur les touches 'up' and 'down' pour changer le nombre", 0, 300, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur 'Entrée' pour choisir votre classe", 0, 400, love.graphics.getWidth(), "center")
end

function Affi_choose(compte_j, class_possible, ind_classe, class_choisi,stat_classe,competence,width)
    love.graphics.clear(0, 0, 0)

    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(Background, 0, 0, 0, width / 1024, width / 1024)
    love.graphics.printf("Quelle classe souhaitez-vous, joueur " .. compte_j + 1 .. " ?", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Classe : " .. class_possible[ind_classe], 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Stats de la classe : " .. table.concat(stat_classe[ind_classe],","), 0, 300, love.graphics.getWidth(), "center")
    love.graphics.printf("Compétences de la classe : " .. competence[ind_classe], 0, 350, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur les touches 'left' and 'right' pour changer la classe", 0, 400, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur 'Entrée' pour confirmer", 0, 500, love.graphics.getWidth(), "center")

    if compte_j > 0 then
        love.graphics.printf("Joueur " .. compte_j .. " a choisi la classe : " .. class_choisi, 0, 600, love.graphics.getWidth(), "center")
    end
end

function Affi_chargement(LoadingTimer, LoadingTime)
    love.graphics.clear(0, 0, 0)
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Chargement en cours...", 0, 100, love.graphics.getWidth(), "center")

    -- Afficher une barre de progression
    local progressWidth = 300
    local progressHeight = 20
    local progressX = (love.graphics.getWidth() - progressWidth) / 2
    local progressY = 200
    local progress = LoadingTimer / LoadingTime
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", progressX, progressY, progressWidth, progressHeight)
    love.graphics.rectangle("fill", progressX, progressY, progressWidth * progress, progressHeight)
    
end

-- Chargez l'image de curseur
local cursorImage = love.graphics.newImage("Assets/cursor.png")

function Affi_play(cameraX,cameraY,gridSize,plat,resultat,compte_j,width,zoom,liste_j,j_actuel,Liste_mob)
    local resultatX = 10
    local resultatY = love.graphics.getHeight() - 30
    love.graphics.push()
    love.graphics.translate(-cameraX, -cameraY)

    love.graphics.draw(Map, 0, 0, 0, zoom, zoom)
    Affi_joueur(compte_j,width)
    Affi_mob(Liste_mob)

    local gridColor = {255, 255, 255}

    love.graphics.setColor(gridColor)

    -- Calculer les cases accessibles à partir de la position actuelle du joueur
    for i = 1, plat.taille do
        for j = 1, plat.taille do
            local x = (j - 1) * gridSize
            local y = (i - 1) * gridSize
            if plat:getCase(j,i) == "vide"  then
                love.graphics.rectangle("line", x, y, gridSize, gridSize)
            elseif plat:getCase(j,i) == "aléatoire" then
                love.graphics.rectangle("line", x, y, gridSize, gridSize)
                love.graphics.setColor(gridColor)
                love.graphics.printf("?", x, y + gridSize/2 - 10, gridSize, 'center')
            elseif plat:getCase(j,i) == "shop" then
                love.graphics.rectangle("line", x, y, gridSize, gridSize)
                love.graphics.setColor(gridColor)
                love.graphics.printf("$", x, y + gridSize/2 - 10, gridSize, 'center')

            elseif plat:getCase(j,i) == "torture" then
                love.graphics.rectangle("line", x, y, gridSize, gridSize)
                love.graphics.setColor(gridColor)
                love.graphics.printf("Def", x, y + gridSize/2 - 10, gridSize, 'center')

            elseif plat:getCase(j,i) == "ecurie" then
                love.graphics.rectangle("line", x, y, gridSize, gridSize)
                love.graphics.setColor(gridColor)
                love.graphics.printf("Cheval", x, y + gridSize/2 - 10, gridSize, 'center')

            elseif plat:getCase(j,i)  ~= "indispo" then 
                if plat:getCase(j,i):returnType() == "Player" then
                    love.graphics.rectangle("line", x, y, gridSize, gridSize)
                    if plat:getCase(j,i) == liste_j[j_actuel] then
                        love.graphics.setColor(255, 255, 255)
                        love.graphics.draw(cursorImage, x + gridSize/2 - cursorImage:getWidth()/2, y - cursorImage:getHeight()/2)
                    end
                end
            end
        end
    end

    if resultat ~= nil and #resultat > 0 then
        local x,y = plat:trouverObjet(liste_j[j_actuel])
        local cases_possible = Accessible_cases(resultat[#resultat], plat, x,y)
        if cases_possible ~= nil then
            for _, c in ipairs(cases_possible) do
                local x, y = c:match("(%d+),(%d+)")
                x, y = tonumber(x), tonumber(y)
                if plat:getCase(x,y) == "vide" or plat:getCase(x,y) == "aléatoire" or plat:getCase(x,y) == "shop" or plat:getCase(x,y) == "torture" or plat:getCase(x,y) == "ecurie" then
                    love.graphics.setColor(gridColor)
                    love.graphics.line((x - 1) * gridSize, (y - 1) * gridSize, x * gridSize, y * gridSize)
                    love.graphics.line(x * gridSize, (y - 1) * gridSize, (x - 1) * gridSize, y * gridSize)

                end
            end
        end
    end

    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Résultat du lancer : " .. Afficher_lancer(resultat), resultatX + cameraX, resultatY + cameraY, love.graphics.getWidth(), 'left')
    love.graphics.printf("Vous avez ".. liste_j[j_actuel]:getEcu() .. " écu", resultatX + cameraX - 50, resultatY + cameraY , love.graphics.getWidth(), 'right')

    love.graphics.pop()
end

function Affi_Base(width)
    love.graphics.draw(Background, 0, 0, 0, width / 1024, width / 1024) 
    local title = love.graphics.newImage("Assets/Title.png")

    local start_button = love.graphics.newImage("Assets/play.png")
    local continue_button = love.graphics.newImage("Assets/continue.png")
    local rules_button = love.graphics.newImage("Assets/rules.png")
    local credits_button = love.graphics.newImage("Assets/credits.png")

    love.graphics.draw(title, width / 2 - 250, 100, _, 2, 2)
    love.graphics.draw(start_button, width / 2 - 100, 400, _, 3, 3)
    love.graphics.draw(continue_button, width / 2 - 100, 500, _, 3, 3)
    love.graphics.draw(rules_button, width / 2 - 100, 600, _, 3, 3)
    love.graphics.draw(credits_button, width / 2 - 100, 700, _, 3, 3)
end

function Affi_rules(width)
    love.graphics.draw(Background, 0, 0, 0, width / 1024, width / 1024) 
    love.graphics.printf("Règles du jeu", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur la touche retour pour revenir au menu", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Vous pouvez choisir votre classe parmi les 4 proposées", 0, 300, love.graphics.getWidth(), "center")
    love.graphics.printf("Vous pouvez vous déplacer en cliquant sur les cases accessibles", 0, 400, love.graphics.getWidth(), "center")
    love.graphics.printf("Le but du jeu est de vaincre le boss final et d'atteindre la fin", 0, 500, love.graphics.getWidth(), "center")
    love.graphics.printf("Pour cela, vous devez vous déplacer sur la carte et combattre les ennemis (en se placant à côté d'eux)", 0, 600, love.graphics.getWidth(), "center")
    love.graphics.printf("Vous ne pouvez donc pas vous placez sur la même case qu'un joueur ou qu'un ennemi", 0, 700, love.graphics.getWidth(), "center")
    love.graphics.printf("Vous pouvez aussi aller sur une case marqué d'un ? pour qu'un évenement aléatoire se déclenche", 0, 800, love.graphics.getWidth(), "center")
    love.graphics.printf("Sur la carte,un ennemi d'élite y sera présent pouvant vous drop une arme suprême", 0, 900, love.graphics.getWidth(), "center")
    love.graphics.printf("Sous certaines conditions,un boss secret peut se débloquer.. A vous de trouver comment !", 0, 1000, love.graphics.getWidth(), "center")

end

function Affi_credits(width)
    love.graphics.draw(Background, 0, 0, 0, width / 1024, width / 1024) 
    love.graphics.printf("Crédits", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur la touche retour pour revenir au menu", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Récupération d'assets et tuiles : itch.io et Butor Loïc", 0, 300, love.graphics.getWidth(), "center")
    love.graphics.printf("Créateur du jeu : Lecoustre Malcom", 0, 400, love.graphics.getWidth(), "center")
    love.graphics.printf("Image : craiyon (ia génératrice) : Lecoustre Malcom", 0, 500, love.graphics.getWidth(), "center")
end

function Affi_shop(width,joueur)
    love.graphics.draw(love.graphics.newImage("Assets/shop.png"),0,0,0,width/1024,width/1024)
    love.graphics.printf("Bienvenue dans le shop ! Appuyer sur la touche retour pour revenir au jeu", 0, 0, love.graphics.getWidth(), "center")

    love.graphics.draw(love.graphics.newImage("objet/weapon/assets/Sword.png"),200,50,0,3,3)
    love.graphics.printf("Une épée en fer ,infligeant 15 de dégâts. 10 écu", 300, 75, 600, "left")
    love.graphics.draw(love.graphics.newImage("Assets/buy.png"),900,75,0,2,2)

    love.graphics.draw(love.graphics.newImage("objet/armure/assets/Armor.png"),150,150,0,2,2    )
    love.graphics.printf("Une armure en fer ,augmentant de 5 la défense. 7 écu", 300, 175, 600, "left")
    love.graphics.draw(love.graphics.newImage("Assets/buy.png"),900,175,0,2,2)

    love.graphics.draw(love.graphics.newImage("objet/consumable/assets/Potion.png"),1200,50,0,3,3)
    love.graphics.printf("Une potion soignant 20 hp.5 écu",1300,75,600,"left")
    love.graphics.draw(love.graphics.newImage("Assets/buy.png"),1700,75,0,2,2)

    love.graphics.printf("Vous avez actuellement : " .. joueur:getEcu() .. " écu", 0, 1000, love.graphics.getWidth(), "left")
end

function Affi_torture(width,joueur)
    love.graphics.draw(love.graphics.newImage("Assets/torture.png"),0,0,0,width/1024,width/1024)
    love.graphics.printf("Bienvenue dans la salle de torture ! Appuyer sur la touche retour pour revenir au jeu", 0, 0, love.graphics.getWidth(), "center")

    love.graphics.printf("Vous pouvez torturer un joueur pour lui voler de l'argent", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Vous avez actuellement : " .. joueur:getDef() .. "def", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur la touche 't' pour torturer un joueur (sacrifie 15 hp max pour rajouter 3 de défense)", 0, 300, love.graphics.getWidth(), "center")
end

function Affi_ecurie(width,joueur)
    love.graphics.draw(love.graphics.newImage("Assets/stable.png"),0,0,0,width/1024,width/1024)
    love.graphics.printf("Bienvenue dans l'écurie ! Appuyer sur la touche retour pour revenir au jeu", 0, 0, love.graphics.getWidth(), "center")
    love.graphics.printf("Un cheval coute 20 écu,il vous permet d'avoir un de déplacement en plus !", 0, 100, love.graphics.getWidth(), "center")
    love.graphics.printf("Par exemple,si tu fais 6,tu pourras avancer de 7 cases", 0, 200, love.graphics.getWidth(), "center")
    love.graphics.printf("Appuyez sur A pour acheter le cheval si vous avez l'argent nécessaire", 0, 300, love.graphics.getWidth(), "center")

    love.graphics.printf("Vous avez actuellement : " .. joueur:getEcu() .. " écu", 0, 1000, love.graphics.getWidth(), "left")
end

