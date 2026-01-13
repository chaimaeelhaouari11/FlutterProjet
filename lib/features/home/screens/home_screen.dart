import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/product_provider.dart';
import '../../../core/providers/supplier_provider.dart';
import '../../../core/providers/activity_provider.dart';
import '../../../core/providers/notification_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Structure simple et ultra-stable pour éviter l'erreur "ancestor == this"
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Consumer<AuthProvider>(
          builder: (context, auth, _) => Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.primaryLight,
                child: Text(auth.user?.avatarEmoji ?? '👤', style: const TextStyle(fontSize: 18)),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bonjour,', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(auth.user?.name ?? 'Admin', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notif, _) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.primary),
                  onPressed: () => context.push('/notifications'),
                ),
                if (notif.unreadCount > 0)
                  Positioned(right: 12, top: 12, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle))),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            
            // 1. Barre de recherche statique
            _buildSearchBox(context),
            
            const SizedBox(height: 24),
            
            // 2. Grille de statistiques avec Consumer local
            _buildStatsGrid(context),
            
            const SizedBox(height: 30),
            
            // 3. Actions Rapides
            const Text('Actions Rapides', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            
            const SizedBox(height: 30),
            
            // 4. Activités Récentes (Source du bug, maintenant sécurisée)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Activités Récentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () => context.push('/system-logs'), child: const Text('Voir tout')),
              ],
            ),
            const SizedBox(height: 8),
            _buildActivitiesList(context),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add-product'),
        backgroundColor: AppTheme.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/products'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Text('Rechercher...', style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.5,
        children: [
          Consumer<ProductProvider>(builder: (context, p, _) => _statCard('Produits', p.products.length.toString(), Icons.inventory_2_rounded, AppTheme.primary)),
          Consumer<ProductProvider>(builder: (context, p, _) => _statCard('Bas stock', p.lowStockProducts.length.toString(), Icons.warning_rounded, AppTheme.error)),
          Consumer<SupplierProvider>(builder: (context, s, _) => _statCard('Fournisseurs', s.suppliers.length.toString(), Icons.business_rounded, AppTheme.accent)),
          _statCard('Entrepôts', '3', Icons.map_rounded, Colors.blueGrey),
        ],
      );
    });
  }

  Widget _statCard(String label, String val, IconData icon, Color col) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: col, size: 24),
          const Spacer(),
          Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionBtn(context, 'Produit', Icons.add_box_rounded, '/add-product'),
        _actionBtn(context, 'Fournisseur', Icons.person_add_rounded, '/supplier-form'),
        _actionBtn(context, 'Commandes', Icons.shopping_cart_rounded, '/orders'),
        _actionBtn(context, 'Stock', Icons.assessment_rounded, '/products'),
      ],
    );
  }

  Widget _actionBtn(BuildContext context, String label, IconData icon, String route) {
    return Column(
      children: [
        InkWell(
          onTap: () => context.push(route),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primary),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildActivitiesList(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, provider, _) {
        final activities = provider.recentActivities;
        if (activities.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text('Aucune activité récente', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: activities.length,
          itemBuilder: (context, index) {
            final act = activities[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 16,
                  backgroundColor: AppTheme.primary.withOpacity(0.1),
                  child: Icon(act.icon, color: AppTheme.primary, size: 16),
                ),
                title: Text(act.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                subtitle: Text(act.subtitle, style: const TextStyle(fontSize: 11)),
              ),
            );
          },
        );
      },
    );
  }
}
