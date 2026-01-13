import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Les différents états d'authentification possibles dans l'application.
enum AuthStatus { initial, authenticated, unauthenticated, guest }

/// initial =  État au lancement de l'app.

/// Le fournisseur (Provider) de l'authentification.
/// Utilise 'ChangeNotifier' pour notifier l'UI dès que l'état de l'utilisateur change.
class AuthProvider extends ChangeNotifier {
  // Clés utilisées pour stocker les données de session localement sur le téléphone.
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _isGuestKey = 'is_guest';
  static const String _userNameKey = 'user_name';
  static const String _userEmailKey = 'user_email';
  static const String _userAvatarKey = 'user_avatar';
  static const String _userImageKey = 'user_image';

  // État interne du fournisseur
  /// Elles sont privées et accessibles via les getters publics pour que les widgets puissent lire l'état sans le modifier directement.
  AuthStatus _status = AuthStatus.initial;
  UserModel? _user;
  bool _isLoading = false;

  // Getters pour accéder aux données depuis les widgets
  AuthStatus get status => _status;
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isGuest => _status == AuthStatus.guest;

  AuthProvider() {
    // Vérifie automatiquement si une session est déjà active au lancement de l'app.
    _checkAuthStatus();
  }

  /// Vérifie si l'utilisateur est déjà connecté ou s'il est en mode invité.
  /// Récupère les données depuis les SharedPreferences.
  Future<void> _checkAuthStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    final isGuest = prefs.getBool(_isGuestKey) ?? false;

    if (isLoggedIn) {
      final name = prefs.getString(_userNameKey) ?? 'Utilisateur';
      String? profileImage = prefs.getString(_userImageKey);

      // Gestion spécifique des images pour les démonstrations locales
      if (name.toLowerCase() == 'nada') {
        profileImage = 'assets/images/nada.png';
      } else if (name.toLowerCase() == 'chaimae') {
        profileImage = 'assets/images/chaimae.png';
      }
/////// Définit l'utilisateur et l'état d'authentification en fonction des données récupérées depuis SharedPreferences
      ///SharedPreferences est un package Flutter pour stocker des données simples (clé-valeur) localement sur l'appareil,
      _user = UserModel(
        id: '1',
        name: name,
        email: prefs.getString(_userEmailKey) ?? '',
        avatarIndex: prefs.getInt(_userAvatarKey) ?? 0,
        profileImage: profileImage,
        isGuest: false,
      );
      _status = AuthStatus.authenticated;
    } else if (isGuest) {
      _user = UserModel(
        id: 'guest',
        name: 'Invité',
        email: '',
        avatarIndex: 0,
        isGuest: true,
      );
      _status = AuthStatus.guest;
    } else {
      _status = AuthStatus.unauthenticated;
    }
    // Met à jour l'UI
    notifyListeners();
  }

  /// =======================================================================
  /// FONCTION DE CONNEXION (LOGIN)
  /// =======================================================================
  /// Cette fonction est appelée quand l'utilisateur clique sur "Se connecter".
  ///

  /// Normalement, ici on devrait appeler une API Backend (ex: Node.js, Firebase).
  /// Comme on n'a pas de serveur pour ce projet, on SIMULE tout en local.
  ///
  /// Ce qu'elle fait étape par étape :
  /// 1. Affiche un chargement (`notifyListeners` met à jour l'UI).
  /// 2. Attend 2 secondes pour faire "genre" ça charge depuis internet.
  /// 3. Crée un objet `UserModel` avec les infos (si c'est 'Nada' ou 'Chaimae', on met les images spéciales).
  /// 4. SAUVEGARDE tout dans le téléphone (SharedPreferences) pour que l'utilisateur reste connecté
  ///    même s'il ferme l'application.
  /// =======================================================================
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners(); // Dit à l'écran : "Affiche le rond de chargement !"

    try {
      // Simulation d'un délai réseau de 2 secondes
      await Future.delayed(const Duration(seconds: 2));

      final name = email.split('@').first;
      String? profileImage;
      if (name.toLowerCase() == 'nada') {
        profileImage = 'assets/images/nada.png';
      } else if (name.toLowerCase() == 'chaimae') {
        profileImage = 'assets/images/chaimae.png';
      }

      // On crée l'utilisateur en mémoire
      _user = UserModel(
        id: '1',
        name: name,
        email: email,
        avatarIndex: 0,
        profileImage: profileImage,
        isGuest: false,
      );

      // SAUVEGARDE PERSISTANTE (SharedPreferences)
      // C'est grâce à ça qu'on reste connecté après avoir redémarré l'app.
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setBool(_isGuestKey, false);
      await prefs.setString(_userNameKey, _user!.name);
      await prefs.setString(_userEmailKey, email);

      if (_user!.profileImage != null) {
        await prefs.setString(_userImageKey, _user!.profileImage!);
      }

      _status = AuthStatus.authenticated;
      _isLoading = false;

      notifyListeners(); // Dit à l'écran : "C'est bon, enlève le chargement et change de page !"
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // ===============================
//  GESTION D'AUTHENTIFICATION
// ===============================
// Il utilise SharedPreferences pour mémoriser l'état de connexion
// afin que l'utilisateur reste connecté même après redémarrage de l'application.
//

// -------------------------
// INSCRIPTION UTILISATEUR
// -------------------------
// Simule un enregistrement avec délai de 2s (comme un vrai backend)
// Crée un UserModel, sauvegarde ses infos localement,
// définit l'état comme "authentifié"
// puis notifie l'interface UI.
  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2)); // simulation backend

      // Image de profil personnalisée (exemple pédagogique)
      String? profileImage;
      if (name.toLowerCase() == 'nada') profileImage = 'assets/images/nada.png';
      if (name.toLowerCase() == 'chaimae')
        profileImage = 'assets/images/chaimae.png';

      // Création d'un utilisateur authentifié
      _user = UserModel(
        id: '1',
        name: name,
        email: email,
        avatarIndex: 0,
        profileImage: profileImage,
        isGuest: false,
      );

      // Persistance dans SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      await prefs.setBool(_isGuestKey, false);
      await prefs.setString(_userNameKey, name);
      await prefs.setString(_userEmailKey, email);
      if (_user!.profileImage != null) {
        await prefs.setString(_userImageKey, _user!.profileImage!);
      }

      _status = AuthStatus.authenticated;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

// ----------------------------------
// CONTINUER EN MODE INVITÉ
// ----------------------------------
// Crée un utilisateur temporaire sans email
// Sauvegarde l'état comme "Invité"
// Permet d'utiliser l'app sans compte.
  Future<void> continueAsGuest() async {
    _user = UserModel(
      id: 'guest',
      name: 'Invité',
      email: '',
      avatarIndex: 0,
      isGuest: true,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isGuestKey, true);
    await prefs.setBool(_isLoggedInKey, false);

    _status = AuthStatus.guest;
    notifyListeners();
  }

// ----------------------------------
// DÉCONNEXION
// ----------------------------------
// Supprime toutes les données locales
// Réinitialise l'utilisateur et l'état d'authentification.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isLoggedInKey);
    await prefs.remove(_isGuestKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userEmailKey);
    await prefs.remove(_userAvatarKey);
    await prefs.remove(_userImageKey);

    _user = null;
    _status = AuthStatus.unauthenticated;
    notifyListeners();
  }

// ----------------------------------
//  MISE À JOUR PROFIL
// ----------------------------------
// Met à jour les infos en mémoire + stockage local
  Future<void> updateProfile(
      {String? name, int? avatarIndex, String? profileImage}) async {
    if (_user == null) return;

    _user = _user!.copyWith(
      name: name ?? _user!.name,
      avatarIndex: avatarIndex ?? _user!.avatarIndex,
      profileImage: profileImage ?? _user!.profileImage,
    );

    final prefs = await SharedPreferences.getInstance();
    if (name != null) await prefs.setString(_userNameKey, name);
    if (avatarIndex != null) await prefs.setInt(_userAvatarKey, avatarIndex);
    if (profileImage != null)
      await prefs.setString(_userImageKey, profileImage);

    notifyListeners();
  }

// ----------------------------------
//  MOT DE PASSE OUBLIÉ
// ----------------------------------
// Simule l'envoi d'un mail de réinitialisation
  Future<bool> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

// ----------------------------------
// VÉRIFICATION OTP
// ----------------------------------
// Simule la vérification d'un code envoyé par email
// Code de test = 123456 (mode démo)
  Future<bool> verifyOTP(String email, String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      _isLoading = false;
      notifyListeners();
      return otp == '123456';
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
