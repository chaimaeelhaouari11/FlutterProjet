
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/providers/activity_provider.dart';
import '../../../../core/models/activity_model.dart';

class SystemLogScreen extends StatelessWidget {
  const SystemLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = context.watch<ActivityProvider>().activities;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs Système'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => context.read<ActivityProvider>().clearActivities(),
          ),
        ],
      ),
      body: activities.isEmpty
          ? const Center(child: Text('Aucun log disponible'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final log = activities[index];
                Color color;
                switch (log.type) {
                  case ActivityType.success: color = Colors.green; break;
                  case ActivityType.warning: color = Colors.orange; break;
                  case ActivityType.error: color = Colors.red; break;
                  default: color = AppTheme.primary;
                }
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.withOpacity(0.1)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${log.timestamp.hour}:${log.timestamp.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '[${log.type.name.toUpperCase()}] ${log.title}',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              color: color,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
