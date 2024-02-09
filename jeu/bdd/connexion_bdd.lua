-- db_connection.lua
-- Installer luarocks library
-- luarocks install luapgsql



local pgsql = require 'pgsql'



local conn = pgsql.connectdb('dbname=sae_jeu user=matheo password=230604')

if conn:status() == pgsql.CONNECTION_OK then
    print('Connexion à la base de données')
else
    print('La connexion à la base de données a échoué : ' .. conn:errorMessage())
end

-- Exporter l'objet de connexion
return conn

