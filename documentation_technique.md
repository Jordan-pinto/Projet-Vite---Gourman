# 📄 Documentation Technique - Vite & Gourmand

## 1. Réflexion technologique initiale
Pour répondre aux besoins de l'entreprise "Vite & Gourmand", la stack technologique suivante a été choisie :

* **Front-end (HTML5, CSS3, JavaScript) :** L'utilisation de **Bootstrap** a permis de concevoir rapidement une interface 100% responsive et accessible (RGAA). **JavaScript** (via l'API Fetch) a été indispensable pour gérer le filtrage dynamique des menus sans rechargement de page, offrant une expérience utilisateur fluide.
* **Back-end (PHP 8 & PDO) :** PHP est une solution robuste et éprouvée pour la gestion des sessions (visiteur, employé, administrateur). L'extension **PDO** a été systématiquement utilisée pour sécuriser les requêtes SQL (prévention des injections).
* **Bases de données hybrides :**
  * **MySQL (Relationnelle) :** Parfait pour structurer les entités liées entre elles (Utilisateurs, Menus, Commandes) et garantir l'intégrité des données.
  * **MongoDB (Non relationnelle) :** Choisi spécifiquement pour le dashboard Administrateur, afin de stocker et d'analyser les logs de commandes de manière flexible et performante, facilitant la génération de graphiques.

## 2. Configuration de l'environnement de travail
Le développement a été réalisé sur un environnement local optimisé :
* **Éditeur :** Visual Studio Code (avec des extensions de formatage comme Prettier et d'analyse PHP).
* **Serveur local :** XAMPP. Le projet est hébergé dans le répertoire `htdocs`, permettant d'exécuter Apache et MySQL.
* **Gestion de version :** Git, avec un workflow strict (`main` pour la production, `develop` pour l'intégration, et des branches de fonctionnalités pour chaque nouvelle tâche).

## 3. Modèle Conceptuel de Données (MCD)
Voici la structure relationnelle de la base MySQL, schématisant les liens entre nos utilisateurs, le catalogue de menus et le système de commandes.

```mermaid
erDiagram
    UTILISATEUR {
        int id PK
        string nom
        string prenom
        string email
        string password
        string gsm
        string adresse_postale
        enum role "utilisateur, employe, admin"
    }
    
    MENU {
        int id PK
        string titre
        string description
        string theme
        string regime
        float prix_personne
        int nb_personne_min
        int stock_commandes
    }
    
    COMMANDE {
        int id PK
        int utilisateur_id FK
        int menu_id FK
        datetime date_prestation
        string adresse_livraison
        int nb_personnes
        float prix_total
        enum statut
    }

    UTILISATEUR ||--o{ COMMANDE : "passe"
    MENU ||--o{ COMMANDE : "est contenu dans"

## 4. Diagramme des cas d'utilisation
Ce schéma représente les interactions possibles entre les différents types d'utilisateurs (les acteurs) et le système.

```mermaid
flowchart LR
    %% Acteurs
    Visiteur([👤 Visiteur])
    Client([👤 Client Authentifié])
    Employe([👤 Employé])
    Admin([👤 Administrateur])

    %% Actions
    UC1(Consulter le catalogue et filtrer)
    UC2(Créer un compte)
    UC3(Commander un menu)
    UC4(Suivre ses commandes)
    UC5(Gérer les menus et les statuts de commande)
    UC6(Gérer les comptes employés et voir les statistiques)

    %% Liens
    Visiteur --> UC1
    Visiteur --> UC2

    Client --> UC1
    Client --> UC3
    Client --> UC4

    Employe --> UC1
    Employe --> UC5

    Admin --> UC1
    Admin --> UC5
    Admin --> UC6

## 5. Diagramme de séquence
Détaille de la chronologie technique lorsqu'un client authentifié passe une commande sur l'application.
sequenceDiagram
    actor Client
    participant Front as Interface Web (JS)
    participant Back as Serveur (PHP)
    participant BDD as Base de données (MySQL)

    Client->>Front: Clique sur "Commander" (Menu sélectionné)
    Front->>Back: Envoi des données (date, adresse, nb personnes)
    Back->>Back: Vérifie la session de l'utilisateur
    Back->>BDD: Récupère les infos du menu (prix, règles)
    BDD-->>Back: Renvoie les données tarifaires
    Back->>Back: Calcule le prix final (+frais livraison, -10% si >5 pers)
    Back->>BDD: Enregistre la commande (statut: en attente)
    BDD-->>Back: Confirmation de l'insertion
    Back-->>Front: Réponse de succès (JSON)
    Front-->>Client: Affiche la confirmation et envoie un email automatique
