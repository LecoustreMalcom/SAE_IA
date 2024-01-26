--Le joueur commence obligatoirement le combat en premier
function Calcul_dmg_j(joueur,monstre)
    local dmg_joueur = joueur:getAttack()

    if joueur:getWeapon() ~= nil then
        dmg_joueur = dmg_joueur + joueur:getWeapon():getPuissance()
    end

    if monstre:getEtat() == "saignement" then
        dmg_joueur = dmg_joueur + 3
    end

    local critique = joueur:getCritique()
    if critique == true then
        dmg_joueur = dmg_joueur * 2
        love.window.showMessageBox("Critique", "Vous avez infligé un coup critique !", {"OK"})
    end

    dmg_joueur = dmg_joueur - monstre:getDef()

    if dmg_joueur  < 0 then
        dmg_joueur = 0
    end
    
    return dmg_joueur
end

function Calcul_dmg_m(monstre,joueur)
    local dmg_monstre = monstre:getAttack() - joueur:getDef()

    if joueur:getArmure() ~= nil then
        dmg_monstre = dmg_monstre - joueur:getArmure():getPuissance()
    end

    if dmg_monstre  < 0 then
        dmg_monstre = 0
    end

    return dmg_monstre
end

function WinOrLose(joueur,monstre)
    if monstre:getHp() == 0 then
        love.window.showMessageBox("Gain", "Vous avez tué le monstre ", {"OK"})
        return true

    elseif joueur:getHp() == 0 then
        love.window.showMessageBox("Mort", "Le monstre vous a tué,vous perdez donc votre joueur ", {"OK"})
        return false

    else 
        return nil
    end
end

function Drop(joueur,monstre)
    local ecu,liste_drop = monstre:drop()
    joueur:addEcu(ecu)
    local drop_message = "Vous avez gagné " .. ecu .. " ecu(s) et ces objets :\n"

    if liste_drop ~= nil then
        for i,loot in ipairs(liste_drop) do
            drop_message = drop_message .. loot:getDescription() .. "\n"
        end
    end

    love.window.showMessageBox("Drop", drop_message, {"OK"})

    if liste_drop ~= nil then
        for i,loot in ipairs(liste_drop) do
            local type_loot = loot:getType()
            if type_loot == "Arme" then
                if joueur:getWeapon() == nil then
                    joueur:setWeapon(loot)
                else
                    local arme = joueur:getWeapon()
                    if arme:LaMeme(loot) == false then
                        local replace = love.window.showMessageBox("Remplacer l'arme ?", "Vous avez déjà une arme équipée. Voulez-vous la remplacer par l'arme obtenue ?", {"Oui", "Non"})
                        if replace == 1 then
                            joueur:setWeapon(loot)
                        end
                    end   
                end
            elseif type_loot == "Armure" then
                if joueur:getArmure() == nil then
                    joueur:setArmure(loot)
                else
                    local armure = joueur:getArmure()
                    if armure:LaMeme(loot) == false then
                        local replace = love.window.showMessageBox("Remplacer l'armure ?", "Vous avez déjà une armure équipée. Voulez-vous la remplacer par l'armure obtenue ?", {"Oui", "Non"})
                        if replace == 1 then
                            joueur:setArmure(loot)
                        end
                    end   
                end
            elseif type_loot == "Soin" then
                joueur:addInInventory(loot)
            end
        end
    end 
end

function Joueur_loose(joueur)
    joueur:setWeapon(nil)
    joueur:setArmure(nil)
    joueur:setEcu(0)
    joueur:setInventory({}) 

    love.window.showMessageBox("Défaite", "Vous avez perdu le combat,le personnage perd ses armes,armure,inventaire et écu", {"OK"})
end

function Apply_damage(attaquant,defenseur,dmg_comp)
    local dmg
    dmg_comp = dmg_comp or 0
    if attaquant:returnType() == "Player" then
        dmg = Calcul_dmg_j(attaquant,defenseur)
        dmg = dmg + dmg_comp
        defenseur:loseHp(dmg)
        love.window.showMessageBox("Attaque", "Vous avez infligé " .. dmg .. " dégâts au monstre.\nIl lui reste " .. defenseur:getHp() .. " HP.", {"OK"})
    else
        dmg = Calcul_dmg_m(attaquant,defenseur)
        defenseur:loseHp(dmg)
        love.window.showMessageBox("Attaque", "Le monstre vous a infligé " .. dmg .. " dégâts.\nIl vous reste " .. defenseur:getHp() .. " HP.", {"OK"})
    end

    if defenseur:getHp() <= 0 then
        defenseur:setHp(0)
    end
end

function Combats(joueur, monstre)
    -- Afficher la boîte de dialogue pour choisir entre attaque et compétence
    local choix = love.window.showMessageBox("Choix d'action", "Voulez-vous faire une attaque ou une compétence ?", {"Attaque", "Compétence","Inventaire"})
    local winorlose

    -- Vérifier le choix du joueur et exécuter l'action correspondante
    if choix == 1 then
        -- Attaque
        if joueur:getName() == "Chevalier" then
            if joueur:getCooldown() == 1 then
                joueur:setDef(joueur:getDef() - 2)
            end
        end

        Apply_damage(joueur,monstre)

        winorlose = WinOrLose(joueur,monstre)
        joueur:decreaseCooldown()

        if winorlose == true then
            Drop(joueur,monstre)
            return
        end

        if winorlose == nil then 
            Apply_damage(monstre,joueur)
            winorlose = WinOrLose(joueur,monstre)
        end
        
        if winorlose == false then
            Joueur_loose(joueur)
            return
        end

        if winorlose == nil then
            Combats(joueur, monstre)
        end

    elseif choix == 2 then
        local cd = joueur:getCooldown()
        if cd > 0 then
            love.window.showMessageBox("Cooldown", "Vous ne pouvez pas utiliser votre compétence, il vous reste " .. cd .. " tours de cooldown.", {"OK"})
            Combats(joueur, monstre)
        else
            local classe = joueur:getName()

            if classe == "Archer" or classe == "Custom" then
                local dmg_joueur = joueur:Competence()
                Apply_damage(joueur,monstre,dmg_joueur)

                winorlose = WinOrLose(joueur,monstre)

                if winorlose == true then
                    Drop(joueur,monstre)
                end 

            elseif classe == "Healer" then
                joueur:Competence()
                love.window.showMessageBox("Compétence", "Vous vous êtes soigné \n Vous avez à présent : "..joueur:getHp().."hp", {"OK"})

            elseif classe == "Assassin" then
                local etat = joueur:Competence()
                monstre:setEtat(etat)
                love.window.showMessageBox("Compétence", "Vous avez infligé un état de saignement à l'ennemi \n Il va à présent perdre 3hp supplémentaire à chaque tour", {"OK"})

            elseif classe == "Chevalier" then
                local def = joueur:Competence()
                joueur:setDef(def)
                love.window.showMessageBox("Compétence", "Vous gagné +2 en défense pendant 3 tours", {"OK"})
            end
        end

        if winorlose == nil then
            Apply_damage(monstre,joueur)

            winorlose = WinOrLose(joueur,monstre)

            if winorlose == false then
                Joueur_loose(joueur)
                return

            elseif winorlose == nil then
                Combats(joueur, monstre)
            end
        end

    elseif choix == 3 then
        local inventory = joueur:getInventory()
        if #inventory == 0 then
            love.window.showMessageBox("Inventaire", "L'inventaire est vide.", {"OK"})
            Combats(joueur, monstre)
        else
            local selectedIndex = 1
            local inv = true
            while inv == true do
                -- Afficher les objets de l'inventaire avec leur indice et leur description
                local message = ""
                for i, item in ipairs(inventory) do
                    if i == selectedIndex then
                        message = message .. "> "
                    else
                        message = message .. "  "
                    end
                    message = message .. i .. ". " .. item:getDescription() .. "\n"
                end
                local objet = love.window.showMessageBox("Inventaire", message, {"Haut", "Bas", "Sélectionner", "Annuler"})
                
                -- Vérifier les touches enfoncées pour ajuster l'indice de l'objet sélectionné
                if objet == 1 then
                    selectedIndex = selectedIndex - 1
                    if selectedIndex < 1 then
                        selectedIndex = #inventory
                    end
                elseif objet == 2 then
                    selectedIndex = selectedIndex + 1
                    if selectedIndex > #inventory then
                        selectedIndex = 1
                    end
                elseif objet == 3 then
                    -- Sélectionner l'objet et afficher sa description
                    local selectedItem = inventory[selectedIndex]
                    joueur:removeInInventory(selectedIndex)
                    selectedItem:heal(joueur)

                    Apply_damage(monstre,joueur)
            
                    winorlose = WinOrLose(joueur,monstre)
            
                    if winorlose == false then
                        Joueur_loose(joueur)
                        return
                    end
                    
                elseif objet == 4 then
                    inv = false
                end
            end
        end
        if winorlose == nil then
            Combats(joueur, monstre)
        end
    end
end