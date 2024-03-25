create table games(
    id_games SERIAL PRIMARY KEY
);



create table classe (
    id_classe INT PRIMARY KEY,
    nom_classe VARCHAR(30)
);


CREATE TABLE joueur(
    id_joueur SERIAL PRIMARY KEY,
    id_classe INT references classe (id_classe),
    id_games INT references games (id_games)
);


create table monstre(
    id_monstre INT PRIMARY KEY,
    id_games INT references games(id_games),
    nom_monstre VARCHAR(30),
    nb_morts INT
);

create table objet(
    id_objet INT PRIMARY KEY,
    id_games INT references games(id_games), 
    nom_objet VARCHAR(30),
    nb_acheter int
);


create table torture(
    id_torture INT PRIMARY KEY,
    id_games INT references games(id_games),
    nb_acheter INT
);

create table ecurie (
    id_ecurie INT PRIMARY KEY,
    id_games INT references games(id_games),
    nb_acheter INT
);



