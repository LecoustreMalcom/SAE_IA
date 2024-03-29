-- Importer les classes Assassin et Healer
local Plateau = require("System.plateau")
require "System.méthode"
require "System.Deplacement"
require "System.Gestion"
require "System.draw"
require "System.menu"
require  "System.graphics"



local cameraX = 0
local cameraY = 840

local width = love.graphics.getWidth()
local zoom = width / 480
local speed_cam = 1000

local ind_classe = 1
local compte_j = 0
local class_choisi = ""
local class_possible = {"Assassin", "Healer", "Chevalier", "Archer","Custom"}

local resultat = {}

local access = false 

-- Déclarer gridSize comme une variable globale
local gridSize = width / 16

local plat = Plateau.new(16)  -- Crée une instance de la classe Plateau
plat:ajouterIndispo({{1,16},{2,16},{3,16},{4,16},{5,16},{6,16},{7,16},{8,16},{9,16},{10,16},{11,16},{12,16},{13,16},{14,16},{15,16},{16,16},{7,15},{8,15},{9,15},{10,15},{11,15},{12,15},{13,15},{14,15},{15,15},{16,15},{1,14},{2,14},{4,14},{5,14},{1,13},{2,13},{7,13},{8,13},{9,13},{10,13},{11,13},{12,13},{13,13},{14,13},{15,13},{1,12},{2,12},{3,12},{4,12},{5,12},{6,12},{7,12},{8,12},{9,12},{10,12},{11,12},{12,12},{13,12},{14,12},{15,12},{1,11},{3,11},{4,11},{5,11},{6,11},{7,11},{8,11},{9,11},{10,11},{11,11},{12,11},{13,11},{14,11},{15,11},{1,10},{3,10},{4,10},{5,10},{6,10},{7,10},{8,10},{9,10},{10,10},{11,10},{12,10},{13,10},{14,10},{15,10},{1,9},{3,9},{4,9},{5,9},{6,9},{7,9},{8,9},{9,9},{10,9},{11,9},{12,9},{13,9},{14,9},{15,9},{1,8},{7,8},{8,8},{9,8},{10,8},{1,7},{3,7},{5,7},{7,7},{8,7},{9,7},{10,7},{12,7},{13,7},{14,7},{15,7},{1,6},{3,6},{5,6},{7,6},{8,6},{9,6},{10,6},{12,6},{13,6},{14,6},{15,6},{1,5},{3,5},{5,5},{12,5},{13,5},{14,5},{15,5},{1,4},{1,4},{3,4},{4,4},{5,4},{6,4},{7,4},{8,4},{9,4},{10,4},{11,4},{12,4},{13,4},{14,4},{15,4},{16,4},{1,3},{1,3},{3,3},{4,3},{5,3},{6,3},{7,3},{8,3},{9,3},{10,3},{11,3},{12,3},{13,3},{14,3},{15,3},{1,2},{12,2},{13,2},{14,2},{15,2},{1,1},{2,1},{3,1},{4,1},{5,1},{6,1},{7,1},{8,1},{9,1},{10,1}})
plat:ajouterAleatoire()
plat:ajouterCaseSpeciale()

local numPlayers = 1
local font
local gameState = "base"
local playerClasses = {}

local J1 = nil
local J2 = nil
local J3 = nil
local J4 = nil
local j_actuel = 1
local liste_j = {}

local liste_mob
local Gob
local Gob2
local skel1
local skel2
local Phoenix
local Dragon
local challenge 
local Satan

local alance = false

function love.update(dt)
    if gameState == "chargement" then
        LoadingTimer = LoadingTimer + dt
        if LoadingTimer >= LoadingTime then
            gameState = "play"
        end
        J1,J2,J3,J4 = AddJoueur(plat,compte_j,gridSize,playerClasses,width)
        Gob,Gob2,Phoenix,Dragon ,skel1,skel2,Satan,challenge = Add_mob(plat,width,gridSize)
        liste_j = Liste_j(J1,J2,J3,J4)
        liste_mob = Liste_mob(Gob,Gob2,Phoenix,Dragon,skel1,skel2,Satan,challenge)
    end

    if gameState == "play" then
        cameraY = Moove_cam(cameraY,speed_cam,dt)
    end

    -- Appel de la fonction gérant le serveur
    updateServer()
end

function love.load()
    LoadingTime = 3 -- Temps de chargement en secondes
    LoadingTimer = 0
    -- Créer une instance de l'Assassin

    Map = love.graphics.newImage("map/map.png")
    Background = love.graphics.newImage("map/back_menu.png")  
    
    font = love.graphics.newFont(24)
    love.graphics.setFont(font)
end

function love.draw()
    if gameState == "base" then
        Affi_Base(width)

    elseif gameState == "rules" then
        Affi_rules(width)

    elseif gameState == "credits" then
        Affi_credits(width)

    elseif gameState == "start" then
        -- Affichez l'interface demandant le nombre de joueurs
        Affi_start(numPlayers,width)

    elseif gameState == "shop" then
        Affi_shop(width,liste_j[j_actuel])

    elseif gameState == "torture" then
        Affi_torture(width,liste_j[j_actuel])

    elseif gameState == "ecurie" then
        Affi_ecurie(width,liste_j[j_actuel])

    elseif gameState == "choose" then
        Affi_choose(compte_j, class_possible, ind_classe, class_choisi,width)

    elseif gameState == "chargement" then
        Affi_chargement(LoadingTimer, LoadingTime)

    elseif gameState == "play" then
        Affi_play(cameraX,cameraY,gridSize,plat,resultat,compte_j,width,zoom,liste_j,j_actuel,liste_mob)
    end
end

function love.mousepressed(x, y)
    if gameState == "base" then
        gameState = Menu_base(width, gameState,3)
    
    elseif gameState == "play" then
        if resultat ~= nil and #resultat > 0 then
            local joueur = liste_j[j_actuel]
            gameState = Deplacement(plat,width,x,y,cameraY,cameraX,resultat,joueur,gameState)
            LancerCombat(plat,joueur,liste_mob)
            EndGame(joueur,Dragon,liste_j)
            plat:giveGraal(joueur)
            access = plat:getAccess(Dragon,joueur,access)
            resultat = {}
            j_actuel = j_actuel + 1
            if j_actuel > compte_j then
                j_actuel = 1
            end
            alance = false
        end
    elseif gameState == "shop" then
        Menu_shop(liste_j[j_actuel],2)        
    end
end
        

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    if gameState == "start" then
        gameState,numPlayers = Menu_start(key,gameState,numPlayers)

    elseif gameState == "rules" or gameState == "credits" then
        if key == "backspace" then
            gameState = "base"
        end

    elseif gameState == "shop" or gameState == "torture" or gameState == "ecurie" then
        if key == "backspace" then
            gameState = "play"
        end

        if gameState == "torture" then
            Menu_torture(liste_j[j_actuel],key)
        end

        if gameState == "ecurie" then
            Menu_ecurie(liste_j[j_actuel],key)
        end

    elseif gameState == "choose" then
        gameState,ind_classe,playerClasses,compte_j,class_choisi = Menu_choose(key,gameState,ind_classe,playerClasses,compte_j,numPlayers,class_possible)

    elseif gameState == "play" then
        if key == "space" and not alance then 
            resultat = Lancer()
            alance = true
        end
    end
end

------------------------ RESEAUX ------------------------

-- Importer les classes Assassin et Healer
local Plateau = require("System.plateau")
require "System.méthode"
require "System.Deplacement"
require "System.Gestion"
require "System.draw"
require "System.menu"
require  "System.graphics"

-- Créer un socket UDP pour le serveur
local socket = require("socket")
local server = socket.udp()
server:setsockname("*", 12345)  -- Écoute sur toutes les adresses IP sur le port 12345
server:settimeout(0)  -- Définir le timeout sur 0 pour une réception non bloquante

print("Serveur démarré, en attente de connexion...")

-- Attendre que le client se connecte
local clientConnected = false
local clientIP, clientPort

while not clientConnected do
    local data, ip, port = server:receivefrom()
    if data then
        clientIP = ip
        clientPort = port
        clientConnected = true
        print("Client connecté :", clientIP, clientPort)
        server:sendto("Connexion établie!", clientIP, clientPort)
    end
end

-- Maintenant que le client est connecté, le serveur peut envoyer des messages
-- Vous pouvez inclure ici le reste de votre logique de serveur

-- Créez la fonction updateServer pour gérer la logique du serveur
function updateServer()
    -- Ajoutez ici votre logique de mise à jour du serveur
    -- Par exemple, envoyer des messages aux clients, etc.
end

-- Boucle principale du serveur
while true do
    local data, clientIP, clientPort = server:receivefrom()
    if data then
        print("Message reçu du client :", data)
        -- Répondre au client (vous pouvez inclure ici le traitement des données reçues)
        server:sendto("Message reçu avec succès!", clientIP, clientPort)
    end
    -- Mettre un petit délai pour ne pas surcharger le CPU
    socket.sleep(0.01)

    -- Appel de la fonction de mise à jour du serveur
    updateServer()
end

local maxPlayers = 2
local waitingPlayers = 0
local clients = {}  -- Tableau pour stocker les clients connectés avec leur adresse IP et leur port

-- Afficher l'interface de la salle d'attente
-- Fonction pour dessiner l'interface de la salle d'attente
function drawWaitingScreen()
    love.graphics.clear()  -- Effacer l'écran

    -- Afficher le texte "En attente de joueurs..."
    love.graphics.print("En attente de joueurs...", 100, 100)

    -- Afficher le nombre de joueurs connectés et le nombre maximum de joueurs
    love.graphics.print("Joueurs connectés : " .. waitingPlayers, 100, 150)
    love.graphics.print("Nombre maximum de joueurs : " .. maxPlayers, 100, 200)

    -- Dessiner le bouton pour lancer le jeu si le nombre de joueurs atteint maxPlayers
    if waitingPlayers == maxPlayers then
        love.graphics.rectangle("fill", 100, 250, 200, 50)  -- Rectangle du bouton
        love.graphics.print("Lancer le jeu", 150, 260)  -- Texte du bouton
    end
end

-- Fonction pour détecter le clic sur le bouton de lancement du jeu
function love.mousepressed(x, y, button, istouch, presses)
    if waitingPlayers == maxPlayers and x >= 100 and x <= 300 and y >= 250 and y <= 300 then
        -- Lancer le jeu lorsque le bouton est cliqué
        startGame()
    end
end
