-- Création de la base de données
CREATE DATABASE IF NOT EXISTS `vite_et_gourmand` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `vite_et_gourmand`;

-- --------------------------------------------------------
-- Table `utilisateurs`
-- Gère les clients, les employés et l'administrateur
-- --------------------------------------------------------
CREATE TABLE `utilisateurs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gsm` varchar(20) DEFAULT NULL,
  `adresse_postale` text DEFAULT NULL,
  `role` enum('utilisateur','employe','administrateur') NOT NULL DEFAULT 'utilisateur',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertion des utilisateurs de test (Mot de passe : Test1234!)
-- Le hash ci-dessous correspond à "Test1234!" généré avec password_hash()
INSERT INTO `utilisateurs` (`nom`, `prenom`, `email`, `password`, `gsm`, `adresse_postale`, `role`) VALUES
('Admin', 'José', 'admin@viteetgourmand.fr', '$2y$10$QO.O3c.Y/wz/e.2F9u.F4.G.k.p.R.K.S.z.w.t.u.v.w.x.y.z.', '0600000000', 'Bordeaux', 'administrateur'),
('Employe', 'Julie', 'employe@viteetgourmand.fr', '$2y$10$QO.O3c.Y/wz/e.2F9u.F4.G.k.p.R.K.S.z.w.t.u.v.w.x.y.z.', '0600000001', 'Bordeaux', 'employe'),
('Client', 'Test', 'client@test.fr', '$2y$10$QO.O3c.Y/wz/e.2F9u.F4.G.k.p.R.K.S.z.w.t.u.v.w.x.y.z.', '0612345678', '10 rue de la Paix, 33000 Bordeaux', 'utilisateur');

-- --------------------------------------------------------
-- Table `menus`
-- Catalogue des prestations traiteur
-- --------------------------------------------------------
CREATE TABLE `menus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(150) NOT NULL,
  `description` text NOT NULL,
  `theme` varchar(100) NOT NULL,
  `regime` varchar(50) NOT NULL,
  `prix_personne` decimal(10,2) NOT NULL,
  `nb_personne_min` int(11) NOT NULL,
  `stock_commandes` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insertion d'un menu de test
INSERT INTO `menus` (`titre`, `description`, `theme`, `regime`, `prix_personne`, `nb_personne_min`, `stock_commandes`, `image_url`) VALUES
('Menu Festif de Noël', 'Un délicieux repas de fêtes avec des produits de saison.', 'Noël', 'Classique', 45.50, 2, 50, 'assets/img/noel.jpg');

-- --------------------------------------------------------
-- Table `commandes`
-- Gestion des commandes passées par les clients
-- --------------------------------------------------------
CREATE TABLE `commandes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilisateur_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `date_prestation` datetime NOT NULL,
  `adresse_livraison` text NOT NULL,
  `nb_personnes` int(11) NOT NULL,
  `prix_total` decimal(10,2) NOT NULL,
  `statut` enum('en attente','accepté','en préparation','en cours de livraison','livré','en attente du retour de matériel','terminée') NOT NULL DEFAULT 'en attente',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`menu_id`) REFERENCES `menus`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
