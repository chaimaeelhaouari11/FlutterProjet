
import 'package:flutter/material.dart';

enum ActivityType { info, warning, success, error }

class ActivityModel {
  final String id;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final ActivityType type;
  final IconData icon;

  ActivityModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.type,
    required this.icon,
  });
}
