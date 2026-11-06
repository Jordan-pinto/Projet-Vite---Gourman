# Projet ECF : Vite & Gourmand

## Présentation du projet
Ce dépôt contient le code source de l'application web "Vite & Gourmand". Ce projet a été réalisé par Jordan Pinto dans le cadre de l'Évaluation en Cours de Formation (ECF) pour l'obtention du Titre Professionnel de Développeur Web et Web Mobile (Studi).

L'objectif de cette application est de numériser le processus de commande d'un traiteur événementiel. Elle propose un catalogue interactif pour les clients, ainsi qu'un back-office permettant aux employés de gérer les commandes et à l'administrateur de consulter les statistiques de vente.

## Environnement technique
* **Front-end :** HTML5, CSS3 (Bootstrap), JavaScript (API Fetch pour les requêtes asynchrones)
* **Back-end :** PHP 8 avec utilisation de l'extension PDO
* **Bases de données :** MySQL (relationnelle) et MongoDB (non relationnelle)

## Prérequis pour l'évaluation
Pour tester ce projet en local, un environnement de serveur web standard est requis :
* Un serveur local tel que **XAMPP** ou WAMP.
* **PHP** (version 8.x recommandée).
* **MySQL** (accessible via phpMyAdmin).

## Démarche de déploiement en local

Voici les étapes à suivre pour installer et faire fonctionner l'application sur votre poste :

### 1. Récupération des fichiers
Placez-vous dans le répertoire racine de votre serveur web (le dossier `htdocs` si vous utilisez XAMPP, ou `www` pour WAMP) et clonez ce dépôt :
\`\`\`bash
git clone [VOTRE_LIEN_GITHUB]
\`\`\`
*(Il est également possible de télécharger le projet au format .zip depuis GitHub et de l'extraire dans ce même répertoire).*

### 2. Importation de la base de données
1. Démarrez les modules Apache et MySQL depuis le panneau de contrôle de votre serveur local (ex: XAMPP Control Panel).
2. Ouvrez phpMyAdmin dans votre navigateur (généralement `http://localhost/phpmyadmin`).
3. Créez une nouvelle base de données nommée `vite_et_gourmand`.
4. Cliquez sur l'onglet **Importer**, sélectionnez le fichier `database.sql` situé à la racine du projet, puis exécutez l'importation. Ce fichier générera la structure des tables ainsi qu'un jeu de données de test (fixtures).

### 3. Lancement de l'application
Une fois la base de données configurée, ouvrez un nouvel onglet dans votre navigateur web et accédez à l'URL suivante :
\`\`\`text
