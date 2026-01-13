
import 'package:flutter/material.dart';
import '../models/activity_model.dart';

class ActivityProvider extends ChangeNotifier {
  final List<ActivityModel> _activities = [];

  ActivityProvider() {
    _loadInitialActivities();
  }

  void _loadInitialActivities() {
    addActivity(
      title: 'Stock ajouté: Dell XPS',
      type: ActivityType.success,
      icon: Icons.add_circle_outline,
    );
    addActivity(
      title: 'Alerte: Clavier RGB bas',
      type: ActivityType.warning,
      icon: Icons.warning_amber,
    );
    addActivity(
      title: 'Commande #002 envoyée',
      type: ActivityType.info,
      icon: Icons.shopping_bag_outlined,
    );
  }

  List<ActivityModel> get activities => List.unmodifiable(_activities);
  List<ActivityModel> get recentActivities => _activities.take(5).toList();

  void addActivity({
    required String title,
    String? subtitle,
    required ActivityType type,
    required IconData icon,
  }) {
    final activity = ActivityModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      subtitle: subtitle ?? _formatTimestamp(DateTime.now()),
      timestamp: DateTime.now(),
      type: type,
      icon: icon,
    );
    _activities.insert(0, activity); // Add to top
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }

  String _formatTimestamp(DateTime dt) {
    return "Il y a quelques secondes";
  }

  void clearActivities() {
    _activities.clear();
    notifyListeners();
  }
}
