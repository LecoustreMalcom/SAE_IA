function Affi_joueur(compte_j,width) 
    if compte_j > 0 then
        J1:afficher()
        if compte_j > 1 then
            J2:afficher()
            if compte_j > 2 then
                J3:afficher()
                if compte_j > 3 then
                    J4:afficher()
                end
            end
        end
    end
end

function Affi_mob(liste_mob, width)
    for i, mob in ipairs(liste_mob) do
        mob:afficher()
    end
end



