#  Guide de Présentation du Projet E-Learning - Projet_F

Ce document est destiné à t'aider à comprendre et à présenter notre application, même si tu n'as pas pu assister à toutes les étapes du développement. Voici tout ce qu'il faut savoir pour briller lors de la présentation !

## Présentation Générale
Notre projet est une plateforme de **Masterclass E-Learning** mobile développée avec **Flutter**. L'objectif est d'offrir une expérience d'apprentissage premium, fluide et interactive.

## Fonctionnalités Clés à Présenter
1.  **Authentification Complète** :
    *   Système de Login/Register avec simulation d'API.
    *   Mode **Invité** pour explorer l'application sans compte.
    *   Gestion de profil personnalisée (Photos réelles pour Nada et Chaimae, Avatars Emoji pour les autres).

2.  **Catalogue de Cours Dynamique** :
    *   Organisation par catégories (Développement, IA, Design, Marketing, Langues).
    *   Barre de recherche performante pour trouver des cours.

3.  **Lecteur Vidéo Hybride (Innovation technique !)** :
    *   Notre lecteur est capable de lire aussi bien des vidéos locales/serveur (**MP4**) que des vidéos **YouTube** directement. 
    *   Il intègre des contrôles avancés (rotation, vitesse, barre de progression personnalisée).

4.  **Système de Quiz et Progression** :
    *   Chaque cours possède des leçons interactives.
    *   À la fin, un **Quiz** permet de valider les acquis.
    *   Si le score est > 70%, un **Certificat** est généré et débloqué dans le profil.

5.  **Design Premium** :
    *   Thème Ultra-Moderne (Palette de violets élégante).
    *   **Mode Sombre (Dark Mode)** intégral.
    *   Animations fluides avec `flutter_animate`.

## Stack Technique
*   **Framework** : Flutter (Dart)
*   **Gestion d'état** : Provider (pour une réactivité maximale)
*   **Navigation** : GoRouter (gestion propre des routes)
*   **Base de données** : SQLite (via `DatabaseService`) pour sauvegarder les progrès et les certificats localement.
*   **Librairies Vidéo** : `youtube_player_flutter` (YouTube) et `chewie` (MP4).

##  Problèmes Résolus (Points Bonus pendant la présentation !)
Pendant le projet, nous avons surmonté plusieurs défis techniques :
*   **Compatibilité Vidéo** : Correction des erreurs de flux HTTP sur Android.
*   **Robustesse UI** : Correction de tous les bugs d'overflow (dépassements de pixels) sur les petits écrans.
*   **Gestion de la nullité** : Correction d'un bug critique de "Null Check" qui faisait planter le lecteur vidéo.

##  Comment lancer l'app ?
1.  Ouvrir le terminal dans le dossier `Projet_F`.
2.  Lancer `flutter pub get` pour installer les dépendances.
3.  Lancer `flutter run` pour démarrer l'application.

---
**Bonne chance pour ton passage ! L'application est stable, belle et prête à être montrée.** 🚀
