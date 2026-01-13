
# E-Learning App Flutter

Application mobile e-learning développée avec Flutter.

## Palette de Couleurs

- **#49225B** - Violet foncé (Primary Dark)
- **#6E3482** - Violet (Primary)
- **#A56ABD** - Violet moyen (Primary Medium)
- **#E7DBEF** - Violet clair (Primary Light)
- **#F5EBFA** - Violet très clair (Background)

## Fonctionnalités

### Module Authentification
- ✅ Splash Screen
- ✅ Onboarding (3 pages)
- ✅ Connexion / Inscription
- ✅ Mot de passe oublié
- ✅ Vérification OTP
- ✅ Mode Invité

### Module Navigation
- ✅ Dashboard / Accueil
- ✅ Bottom Navigation
- ✅ Profil utilisateur
- ✅ Paramètres
- ✅ Notifications

### Module Cours
- ✅ Liste des catégories (Dev, Data, Design, Marketing, Langues)
- ✅ Liste des cours avec filtrage
- ✅ Détails du cours
- ✅ Lecteur vidéo fonctionnel (Chewie)
- ✅ Recherche par domaine

### Module Progression
- ✅ Suivi de progression
- ✅ Quiz interactif
- ✅ Résultats du quiz
- ✅ Certificat de réussite

### Autres
- ✅ Changement de thème (Clair/Sombre)
- ✅ Changement de langue (FR/EN/AR)
- ✅ Changement d'avatar
- ✅ Notifications pour certificats

## Cours Disponibles

### Développement
- Python pour Débutants
- Flutter & Dart Masterclass

### Data Science
- Deep Learning Fondamentaux
- Data Mining & Analytics
- Machine Learning A-Z

### Design
- UI/UX Design Complet
- Graphic Design Essentials

### Marketing
- Marketing Digital 360°
- Social Media Marketing

### Langues
- Français Langue Étrangère
- Business English

## Installation
flutter pub get
flutter run


## Structure du Projet


lib/
├── main.dart
├── core/
│   ├── theme/
│   ├── router/
│   ├── providers/
│   ├── models/
│   ├── services/
│   └── l10n/
└── features/
    ├── splash/
    ├── onboarding/
    ├── auth/
    ├── home/
    ├── courses/
    ├── profile/
    ├── progress/
    ├── quiz/
    ├── certificate/
    ├── notifications/
    └── search/

