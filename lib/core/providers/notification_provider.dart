import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// ===============================
///  MODEL : NotificationModel
/// ===============================
/// Représente une notification dans l'application.
/// Elle stocke :
///  • le titre
///  • le contenu
///  • la date
///  • le type de notification
///  • si elle est lue ou non
///  • éventuellement des données liées (ex : id d’un cours)
class NotificationModel {
  final String id;                  // Identifiant unique
  final String title;               // Titre affiché
  final String body;                // Message détaillé
  final DateTime timestamp;         // Date de réception
  final String type;                // Type (certificate, reminder...)
  final bool isRead;                // Notification lue ou non
  final Map<String, dynamic>? data; // Données supplémentaires optionnelles

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.data,
  });

  /// copyWith → permet de créer une nouvelle version
  /// de la notification, par exemple pour passer isRead = true.
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      timestamp: timestamp,
      type: type,
      isRead: isRead ?? this.isRead,
      data: data,
    );
  }
}

/// ===============================
///  PROVIDER : NotificationProvider
/// ===============================
/// Gère toutes les notifications de l'application.
/// Il s'occupe de :
///  configurer les notifications système (Android / iOS)
///  afficher des notifications locales
///  stocker la liste des notifications internes
///   marquer lues / non lues
///   supprimer / vider la liste
class NotificationProvider extends ChangeNotifier {
  
  // Plugin permettant d'envoyer des notifications natives
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  
  // Liste des notifications visibles dans l'app
  List<NotificationModel> _notifications = [];

  // Indique si le système de notification a été bien initialisé
  bool _isInitialized = false;

  // Getters pour accès depuis l'UI
  List<NotificationModel> get notifications => _notifications;

  // Nombre de notifications non lues
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  /// Constructeur
  /// → initialise le plugin + charge des notifications de démonstration
  NotificationProvider() {
    _initNotifications();
    _loadMockNotifications();
  }

  /// ===============================
  ///  INITIALISATION NOTIFICATIONS
  /// ===============================
  /// Configure Android + iOS et définit la réaction au clic
  Future<void> _initNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    _isInitialized = true;
  }

  /// Appelée quand l'utilisateur clique sur une notification système.
  void _onNotificationTap(NotificationResponse response) {
    debugPrint('Notification cliquée: ${response.payload}');
  }

  /// ===============================
  ///  NOTIFICATIONS DE DÉMONSTRATION
  /// ===============================
  /// Simule des notifications pour présenter la fonctionnalité.
  void _loadMockNotifications() {
    _notifications = [
      NotificationModel(
        id: '1',
        title: '⚠️ Stock Critique !',
        body: 'Le produit "Samsung S23" est descendu en dessous de son seuil d\'alerte.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'reminder',
      ),
      NotificationModel(
        id: '2',
        title: '🚚 Commande Reçue',
        body: 'La commande #ORD-2026-001 de "TechLog Solutions" a été marquée comme livrée.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: 'achievement',
      ),
      NotificationModel(
        id: '3',
        title: '📊 Nouveau Rapport Hebdomadaire',
        body: 'Votre rapport de performance pour la semaine dernière est disponible.',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        type: 'certificate',
      ),
      NotificationModel(
        id: '4',
        title: '👤 Nouvel Utilisateur',
        body: 'L\'utilisateur "Sarah" a rejoint votre organisation.',
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        type: 'achievement',
        isRead: true,
      ),
    ];
    notifyListeners();
  }

  /// ===============================
  ///  NOTIFICATION : CERTIFICAT PRÊT
  /// ===============================
  /// Envoie une notification système + l’ajoute à la liste interne
  Future<void> showCertificateNotification(String courseName) async {
    if (!_isInitialized) return;

    const androidDetails = AndroidNotificationDetails(
      'certificate_channel',
      'Certificats',
      channelDescription: 'Notifications pour certificats disponibles',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      '🎉 Certificat Disponible!',
      'Votre certificat pour "$courseName" est prêt!',
      details,
    );

    // Ajout dans la liste interne
    _notifications.insert(
      0,
      NotificationModel(
        id: DateTime.now().toString(),
        title: '🎉 Certificat Disponible!',
        body: 'Votre certificat pour "$courseName" est prêt à télécharger.',
        timestamp: DateTime.now(),
        type: 'certificate',
      ),
    );
    notifyListeners();
  }

  /// ===============================
  ///  NOTIFICATION : RAPPEL SIMPLE
  /// ===============================
  Future<void> showReminderNotification() async {
    if (!_isInitialized) return;

    const androidDetails = AndroidNotificationDetails(
      'reminder_channel',
      'Rappels',
      channelDescription: 'Rappels d’apprentissage',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const details = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      1,
      '📚 Temps d\'apprendre!',
      'N\'oubliez pas de continuer votre apprentissage aujourd\'hui.',
      details,
    );
  }

  /// ===============================
  ///  GESTION LECTURE & SUPPRESSION
  /// ===============================

  /// Marque une notification comme lue
  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  /// Marque toutes les notifications comme lues
  void markAllAsRead() {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
  }

  /// Supprime une notification
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  /// Vide toutes les notifications
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
