/* création de la base de donnée */
CREATE DATABASE IF NOT EXISTS ComplexeCinema
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;


USE ComplexeCinema;

/* création des tables */
CREATE TABLE IF NOT EXISTS film(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    titre VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    genre VARCHAR(30) NOT NULL
)Engine=innodb;

CREATE TABLE IF NOT EXISTS Prix (
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    forfait VARCHAR(60) NOT NULL,
    prix FLOAT NOT NULL
)Engine=innodb;

CREATE TABLE IF NOT EXISTS cinema(
    id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    adresse VARCHAR(100) NOT NULL,
    ville VARCHAR(50) NOT NULL,
    code_postal VARCHAR(5) NOT NULL,
    telephone VARCHAR(10) NOT NULL,
    email VARCHAR(180) NOT NULL,
    horaire_ouverture TIME NOT NULL,
    horaire_fermeture TIME NOT NULL,
    jour_ouverture DATE NOT NULL
) Engine=innodb;


CREATE TABLE IF NOT EXISTS Utilisateur(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    role VARCHAR(20) NOT NULL,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    date_de_naissance DATE NOT NULL,
    email VARCHAR(180) NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
) Engine=innodb;

/* table relationnelle entre Cinema et Utilisateur */
CREATE TABLE IF NOT EXISTS Cinema_Utilisateur(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cinema_id INT NOT NULL,
    utilisateur_id INT NOT NULL,
    FOREIGN KEY (cinema_id) REFERENCES Cinema(id),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id)
)Engine=innodb;

CREATE TABLE IF NOT EXISTS salle(
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(60) NOT NULL,
    nbPlaces VARCHAR(150) NOT NULL,
    cinema_id_fk INT,
    CONSTRAINT cinema_id_fk
    FOREIGN KEY (cinema_id_fk)
    REFERENCES Cinema(id)
) Engine=innodb;

CREATE TABLE IF NOT EXISTS seance(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    horaire_debut TIME NOT NULL,
    horaire_fin TIME NOT NULL,
    salle_id_fk INT,
    CONSTRAINT salle_id_fk
    FOREIGN KEY (salle_id_fk)
    REFERENCES Salle(id),
    film_id_fk INT,
    CONSTRAINT film_id_fk
    FOREIGN KEY (film_id_fk)
    REFERENCES Film(id)
) Engine=innodb;

CREATE TABLE IF NOT EXISTS ticket(
    id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    seance_id_fk INT,
    CONSTRAINT seance_id_fk
    FOREIGN KEY (seance_id_fk)
    REFERENCES Seance(id),
    prix_id_fk INT,
    CONSTRAINT prix_id_fk
    FOREIGN KEY (prix_id_fk)
    REFERENCES Prix(id),
    utilisateur_id_fk INT,
    CONSTRAINT utilisateur_id_fk
    FOREIGN KEY (utilisateur_id_fk)
    REFERENCES Utilisateur(id)
) Engine=innodb;

/* Insertion des fixtures */
INSERT INTO Film (id, titre, description, genre)
VALUES
    (1, 'Le Parrain', 'Le patriarche de la famille Corleone tente de transmettre son pouvoir à son fils.', 'Drame'),
    (2, 'Star Wars: Episode IV - Un nouvel espoir', 'Les forces rebelles tentent de détruire l\'étoile de la mort de l\'Empire.', 'Science-Fiction'),
    (3, 'Forrest Gump', 'Forrest Gump raconte sa vie de l\'enfance à l\'âge adulte.', 'Comédie dramatique'),
    (4, 'La liste de Schindler', 'Oskar Schindler sauve des Juifs pendant l\'Holocauste.', 'Drame historique'),
    (5, 'Titanic', 'Le naufrage du Titanic en 1912.', 'Drame romantique'),
    (6, 'Retour vers le futur', 'Un adolescent voyage dans le temps et doit empêcher ses parents de ne jamais se rencontrer.', 'Science-Fiction'),
    (7, 'Le silence des agneaux', 'Un agent du FBI recherche un tueur en série qui cible des femmes.', 'Thriller psychologique'),
    (8, 'Le Roi Lion', 'Un jeune lion doit prendre sa place en tant que roi de la savane.', 'Animation'),
    (9, 'Indiana Jones et les aventuriers de l\'arche perdue', 'Indiana Jones cherche l\'arche de l\'alliance.', 'Aventure'),
    (10, 'Harry Potter à l\'école des sorciers', 'Un jeune garçon apprend qu\'il est un sorcier et commence son éducation à Poudlard.', 'Fantasy');

INSERT INTO Prix (id, forfait, prix)
VALUES
    (1, 'plein tarif', '9.20'),
    (2, 'etudiants', '7.60'),
    (3, 'moins 14 ans', '5.90');

INSERT INTO Cinema (id, nom, adresse, ville, code_postal, telephone, email,  jour_ouverture, horaire_ouverture, horaire_fermeture) 
VALUES 
    (1, 'Cinema Paradis', '12 Rue des Arts', 'Paris', '75001', '0123456789', 'contact@cinemaparadis.com', '2023-05-13', '08:00:00', '22:00:00'),
    (2, 'Cinéma Paradiso', 'Rue de la Paix', 'Lyon', '69000', '0606060606', 'contact@cinema-paradiso.fr', '2023-05-13', '10:00:00', '22:00:00'),
    (3, 'Le Rex', 'Rue des Plantes', 'Paris', '75014', '0145423632', 'contact@cinema-rex.fr', '2023-05-13', '11:00:00', '22:00:00');

INSERT INTO Utilisateur (id, role, nom, prenom, date_de_naissance, email, mot_de_passe)
VALUES
    (1, 'respcomplexe', 'Dupont', 'Jean', '1990-05-25', 'jean.dupont@example.com', '$2y$10$AvkQy1Zk7IdjkPTE8iwrQ..uSFH02Uw2tOyrAPwJkIb0cwSUeaukG' ),
    (2, 'respcomplexe', 'Lefevre', 'Sophie', '1988-12-10', 'sophie.lefevre@example.com', '$2y$10$ErEDnEn0BbHtuOpRlK/ReuiJ.kkmNlJmeQru/Efi/zL0oMbAP5hu2' ),
    (3, 'respcomplexe', 'Dubois', 'Marc', '1995-03-20', 'marc.dubois@example.com', '$2y$10$rdEjahklRIcyAt7pDkD56.YLywylbQM1qN3m7ME2VCgbN6Z7DppAS' ),
    (4, 'admin', 'Martin', 'Lucie', '2000-07-05', 'lucie.martin@example.com', '$2y$10$WCVmwBnP6gZDXcaz72a11uqK8o7gViNfTdmQaycfaNLTVd0dBtiB2' ),
    (5, 'admin', 'Girard', 'Antoine', '1985-11-30', 'antoine.girard@example.com', '$2y$10$soAeww7jre2Ua/iraTFX4es2AOsvF/Wt3iF9QiMWV5exF7dYLUlAS'),
    (6, 'admin', 'Perrin', 'Julie', '1992-02-15', 'julie.perrin@example.com', '$2y$10$Hig4JDLf1i.enaJOtP/Jn.QKbNvFP1XUn8QIt3CJGcPj8IKqvT6FK'),
    (7, 'user', 'Roux', 'Nicolas', '1998-08-20', 'nicolas.roux@example.com', '$2y$10$usm4W3cxprgAMOMKL7bnoOPzWQhm9SFHr4RrZfb1PNBNQ3QoHUo1.'),
    (8, 'user', 'Moreau', 'Marie', '1989-04-01', 'marie.moreau@example.com', '$2y$10$LpGJi3eKcl/mz1vtnlew5.OLs0mFT3oiCM.H/lO5047fsD90g32CS'),
    (9, 'user', 'Fournier', 'David', '1996-09-18', 'david.fournier@example.com', '$2y$10$s6xyN3cfdXigZCcG5bepw.rvq8dFVgrpvjjTp7yv7gWfTorlmMen6'),
    (10, 'user', 'Garcia', 'Pauline', '2001-01-22', 'pauline.garcia@example.com', '$2y$10$0TCL0GCRHz1jC..S5.8I1O0fukBJqnAl54dtr9XC7uCsQ1OOfavRS');

INSERT INTO  Cinema_Utilisateur (id, cinema_id, utilisateur_id)
VALUES
    (1, 2, 3),
    (2, 1, 1);


INSERT INTO Salle (id, nom, nbPlaces, cinema_id_fk)
VALUES
    (1, 'Salle Juan', '50', 1),
    (2, 'Salle Buones', '80', 2),
    (3, 'Salle Cueres', '100', 3),
    (4, 'Salle Douide', '70', 1),
    (5, 'Salle Elote', '120', 2);

INSERT INTO Seance (id, horaire_debut, horaire_fin, salle_id_fk, film_id_fk)
VALUES
    (1, '9:00:00', '22:00:00', 1, 1),
    (2, '10:30:00', '22:30:00',1, 2),
    (3, '9:00:00', '22:00:00', 1, 3),
    (4, '10:30:00', '22:30:00', 2, 1),
    (5, '9:00:00', '22:00:00', 2, 2),
    (6, '10:30:00', '22:30:00', 2, 3),
    (7, '9:00:00', '22:00:00', 3, 1),
    (8, '10:30:00', '22:30:00', 3, 2),
    (9, '9:00:00', '22:00:00', 3 , 3),
    (10,'10:30:00', '22:30:00', 4 , 1);

INSERT INTO Ticket(id,seance_id_fk, prix_id_fk, utilisateur_id_fk)
VALUES
    (1, 2, 3, 4),
    (2, 1, 1, 4);

/* Modification ajouter dans la base de donnée*/

ALTER TABLE Utilisateur ADD COLUMN telephone VARCHAR;

/* Modification de la base de donnée*/

ALTER TABLE cinema MODIFY telephone VARCHAR(15);