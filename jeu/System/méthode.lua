-- Initialisez la graine à l'aide de l'horloge système pour obtenir des nombres aléatoires différents à chaque exécution
math.randomseed(os.time())
local Potion = require "objet.consumable.potion" 

function Lancer() 
    local tableau = {} -- Déclare la variable localement
    local chiffre = math.random(1, 6)
    for i = -chiffre, chiffre do
        table.insert(tableau, i)
    end
    return tableau
end

function Afficher_lancer(tableau)
    local resultat = ""
    for i = 1, #tableau do
        resultat = resultat .. tableau[i] -- Ajoute les éléments du tableau à la chaîne resultat
        if i < #tableau then
            resultat = resultat .. ","
        end
    end
    resultat = resultat .. "\n" -- Ajoute un retour à la ligne à la fin
    return resultat -- Renvoie la chaîne resultat
end

function table.indexOf(t, value)
    for i = 1, #t do
        if t[i] == value then
            return i
        end
    end
    return nil
end


function Aleatoire(Joueur) 
    local message = ""
    local chiffre = math.random(1,10)
    if table.indexOf({1,2,3},chiffre) ~= nil then
        Joueur:loseHp(10)
        message = "Le joueur a perdu 10 points de vie."
    elseif table.indexOf({4,5},chiffre) ~= nil then
        Joueur:soigner(10)
        message = "Le joueur a été soigné de 10 points de vie."
    elseif chiffre == 6 then
        message = "Rien ne se passe."
    elseif chiffre == 7 then
        local potion = Potion:new()
        Joueur:addInInventory(potion)
        message = "Le joueur a reçu une potion de soin."
    elseif chiffre == 8 then
        Joueur:addEcu(3)
        message = "Le joueur a reçu 3 écus."
    else 
        Joueur:setCooldown(0)
        message = "Le temps de recharge a été réinitialisé."
    end
    return message
end


