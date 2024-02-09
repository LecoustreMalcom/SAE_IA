local Sword = require("objet.weapon.Sword")
local Armor = require("objet.armure.amure_en_fer")
local Potion = require("objet.consumable.potion")

local conn = require "bdd.connexion_bdd"


function Menu_start(key,gameState,numPlayers)
    if key == "up" and numPlayers < 4 then
        numPlayers = numPlayers + 1
    elseif key == "down" and numPlayers > 1 then
        numPlayers = numPlayers - 1
    elseif key == "return" then
        gameState = "choose"
    end
    return gameState,numPlayers
    
end

function Menu_choose(key, gameState, ind_classe, playerClasses, compte_j, numPlayers, class_possible)
    if key == "right" and ind_classe < #class_possible then
        ind_classe = ind_classe + 1
    elseif key == "left" and ind_classe > 1 then
        ind_classe = ind_classe - 1
    elseif key == "return" then
        local selectedClass = class_possible[ind_classe]
        playerClasses[compte_j + 1] = selectedClass
        Class_choisi = selectedClass

        -- Insérer la classe choisie dans la table joueur
        local insertQuery = string.format("INSERT INTO joueur (id_classe) VALUES (%d)", ind_classe)
        
        local success, errorMessage = pcall(function()
            conn:exec(insertQuery)
        end)

        if success then
            print("Insertion avec succès")
        else
            print("Insertion a échoué:", errorMessage)
        end

        compte_j = compte_j + 1
        if compte_j == numPlayers then
            gameState = "chargement"
        else
            ind_classe = 1
        end
    end
    return gameState, ind_classe, playerClasses, compte_j, Class_choisi, class_possible
end

function Menu_base(width, gamestate, scale)
    local start_button = love.graphics.newImage("Assets/play.png")
    local buttonX, buttonY = width / 2 - 100, 400
    local buttonWidth, buttonHeight = start_button:getDimensions()
    buttonWidth = buttonWidth * scale
    buttonHeight = buttonHeight * scale
    buttonX = buttonX - (buttonWidth - start_button:getWidth()) / 2
    buttonY = buttonY - (buttonHeight - start_button:getHeight()) / 2

    -- Check if the left mouse button is pressed
    if love.mouse.isDown(1) then
        local mouseX, mouseY = love.mouse.getPosition()

        -- Check if the mouse is within the bounds of the "play" button
        if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY and mouseY <= buttonY + buttonHeight then
           gamestate = "start"
        end

        -- Check if the mouse is within the bounds of the "rules" button
        if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY + 200 and mouseY <= buttonY + buttonHeight + 200 then
           gamestate = "rules"
        end

        -- Check if the mouse is within the bounds of the "credits" button
        if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY + 300 and mouseY <= buttonY + buttonHeight + 300  then
           gamestate = "credits"
        end
    end

    return gamestate
end

function Menu_shop(joueur,scale)
    
    --METTRE STATS POUR LES ACHATS OBJET DANS LA BOUTIQUE



    local start_button = love.graphics.newImage("Assets/play.png")
    local buttonX, buttonY = 900, 75
    local buttonWidth, buttonHeight = start_button:getDimensions()
    buttonWidth = buttonWidth * scale
    buttonHeight = buttonHeight * scale
    buttonX = buttonX - (buttonWidth - start_button:getWidth()) / 2
    buttonY = buttonY - (buttonHeight - start_button:getHeight()) / 2

    if love.mouse.isDown(1) then
        local mouseX, mouseY = love.mouse.getPosition()

        -- Check if the mouse is within the bounds of the "play" button
        if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY and mouseY <= buttonY + buttonHeight then
            if joueur:getEcu() >= 10 then
                joueur:removeEcu(10)
                -- Ajouter l'objet à l'inventaire du joueur
                joueur:setWeapon(Sword:new())
                love.window.showMessageBox("Achat", "Vous avez acheté une épée en fer" , {"OK"})
            end
        end

        -- Check if the mouse is within the bounds of the "rules" button
        if mouseX >= buttonX and mouseX <= buttonX + buttonWidth and mouseY >= buttonY + 100 and mouseY <= buttonY + buttonHeight + 100 then
            if joueur:getEcu() >= 7 then
                joueur:removeEcu(7)
                -- Ajouter l'objet à l'inventaire du joueur
                joueur:setArmure(Armor:new())
                love.window.showMessageBox("Achat", "Vous avez acheté une armure en fer" , {"OK"})
            end
        end

        -- Check if the mouse is within the bounds of the "credits" button
        if mouseX >= buttonX + 800  and mouseX <= buttonX + buttonWidth + 800 and mouseY >= buttonY  and mouseY <= buttonY + buttonHeight   then
            if joueur:getEcu() >= 5 then
                joueur:removeEcu(5)
                -- Ajouter l'objet à l'inventaire du joueur
                joueur:addInInventory(Potion:new())
                love.window.showMessageBox("Achat", "Vous avez acheté une potion de soin" , {"OK"})
            end
        end
    end
end

function Menu_torture(joueur,key)
    if key == "t" then
        joueur:setMaxHp(joueur:getMaxHp() - 15)
        if joueur:getHp() > joueur:getMaxHp() then
            joueur:setHp(joueur:getMaxHp())
        end
        joueur:setDef(joueur:getDef() + 3)
        love.window.showMessageBox("Torture", "Vous avez perdu 15 points de vie et gagné 3 points de défense" , {"OK"})
    end
end

function Menu_ecurie(key,joueur)
    if key == "a" then
        if joueur:getEcu() >= 20 then
            joueur:removeEcu(20)
            joueur:setCheval(true)
            love.window.showMessageBox("Ecurie", "Vous avez payé 20 écu et obtenu votre cheval" , {"OK"})
        end
    end
end
