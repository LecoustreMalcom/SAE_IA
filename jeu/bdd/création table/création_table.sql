
create table classe (
    id_classe INT PRIMARY KEY,
    nom_classe VARCHAR(30)
);


CREATE TABLE joueur(
    id_joueur SERIAL PRIMARY KEY,
    id_classe INT references classe (id_classe)
);


create table monstre(
    id_monstre INT PRIMARY KEY,
    nom_monstre VARCHAR(30)
);

create table objet(
    id_objet INT PRIMARY KEY,
    nom_objet VARCHAR(30),
);



create table stat_joueur(
    id_stat_joueur SERIAL PRIMARY KEY,
    id_joueur INT FOREIGN KEY(id_joueur),
    id_monstre1 INT FOREIGN KEY(id_monstre),
    nb_monstre1_kill INT,
    id_monstre2 INT FOREIGN KEY(id_monstre),
    nb_monstre2_kill INT,
    id_monstre3 INT FOREIGN KEY(id_monstre),
    nb_monstre3_kill INT,
    id_monstre4 INT FOREIGN KEY(id_monstre),
    nb_monstre4_kill INT,
    id_monstre5 INT FOREIGN KEY(id_monstre),
    nb_monstre5_kill INT,
    id_monstre6 INT FOREIGN KEY(id_monstre),
    nb_monstre6_kill INT,
    id_monstre7 INT FOREIGN KEY(id_monstre),
    nb_monstre7_kill INT,
    id_monstre8 INT FOREIGN KEY(id_monstre),
    nb_monstre8_kill INT,
    nb_piece_shop INT,
    nb_objet_buy_shop INT,
    nb_cheval_buy INT,
    nb_torture INT,
    nb_boss_chacher_kill INT
);