import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/notification_provider.dart';
import '../../../core/l10n/app_localizations.dart';

// =====================================================================
// Écran Notifications
// Rôle :
// - Afficher les notifications utilisateur
// - Marquer une notification comme lue
// - Supprimer une notification
// - Afficher un état vide s'il n'y a aucune notification
// =====================================================================
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // AppBar avec bouton retour + bouton "Tout marquer comme lu"
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF252540) : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        title: Text(context.tr('notifications')),
        actions: [
          if (provider.notifications.isNotEmpty)
            TextButton(
              onPressed: () => provider.markAllAsRead(),
              child: Text(context.tr('mark_all_read')),
            ),
        ],
      ),

      // Corps de la page
      body: provider.notifications.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: provider.notifications.length,
              itemBuilder: (context, index) =>
                  _buildNotificationCard(
                      context,
                      provider.notifications[index],
                      provider,
                      index,
                  ),
            ),
    );
  }

  // ================================================================
  // Écran affiché lorsqu'il n'y a aucune notification
  // ================================================================
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration circulaire
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_off_outlined,
              size: 50,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            context.tr('no_notifications'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Vous n\'avez aucune notification',
            style: TextStyle(color: AppTheme.grey),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // Carte d’une notification
  // - swipe pour supprimer
  // - clic pour ouvrir (selon le type)
  // - style différent si non lue
  // ================================================================
  Widget _buildNotificationCard(
    BuildContext context,
    NotificationModel n,
    NotificationProvider p,
    int i,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Définir icône selon type de notification
    IconData icon = Icons.notifications;
    Color iconColor = AppTheme.grey;

    if (n.type == 'certificate') {
      icon = Icons.workspace_premium;
      iconColor = AppTheme.warning;
    } else if (n.type == 'new_course') {
      icon = Icons.play_lesson;
      iconColor = AppTheme.primary;
    } else if (n.type == 'reminder') {
      icon = Icons.alarm;
      iconColor = AppTheme.info;
    } else if (n.type == 'achievement') {
      icon = Icons.stars;
      iconColor = AppTheme.success;
    }

    return Dismissible(
      key: Key(n.id),
      direction: DismissDirection.endToStart,

      // Suppression après glissement
      onDismissed: (_) => p.deleteNotification(n.id),

      // Fond rouge avec icône poubelle
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),

      // Contenu de la notification
      child: GestureDetector(
        onTap: () {
          // Marquer comme lue
          p.markAsRead(n.id);

          // Navigation en fonction du type
          if (n.type == 'certificate' && n.data?['courseId'] != null) {
            context.push('/certificate/${n.data!['courseId']}');
          } else if (n.type == 'new_course' && n.data?['courseId'] != null) {
            context.push('/course/${n.data!['courseId']}');
          }
        },

        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            // Couleur différente si non lue
            color: n.isRead
                ? (isDark ? const Color(0xFF252540) : Colors.white)
                : AppTheme.primaryVeryLight,
            borderRadius: BorderRadius.circular(16),
            border: n.isRead
                ? null
                : Border.all(color: AppTheme.primary.withOpacity(0.3)),
          ),

          // Ligne de contenu
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 16),

              // Texte
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre + point bleu si non lu
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            n.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: n.isRead
                                      ? FontWeight.normal
                                      : FontWeight.bold,
                                ),
                          ),
                        ),
                        if (!n.isRead)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Corps du message
                    Text(
                      n.body,
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 8),

                    // Date formatée
                    Text(
                      _formatTime(n.timestamp),
                      style: TextStyle(
                        color: AppTheme.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    )
        // Animation d'apparition
        .animate()
        .fadeIn(delay: (50 * i).ms)
        .slideX(begin: 0.1);
  }

  // ================================================================
  // Formatage du temps (il y a 2 min, hier, etc.)
  // ================================================================
  String _formatTime(DateTime t) {
    final diff = DateTime.now().difference(t);

    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours}h';
    if (diff.inDays == 1) return 'Hier';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} jours';

    return DateFormat('dd/MM/yyyy').format(t);
  }
}
