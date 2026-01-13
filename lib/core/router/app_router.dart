
import 'package:go_router/go_router.dart';

import '../../features/splash/splash_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../models/product_model.dart';
import '../models/supplier_model.dart';
import '../../features/home/screens/main_navigation_screen.dart';
import '../../features/stock/screens/product_list_screen.dart';
import '../../features/stock/screens/product_detail_screen.dart';
import '../../features/stock/screens/add_edit_product_screen.dart';
import '../../features/stock/screens/low_stock_alerts_screen.dart';
import '../../features/suppliers/screens/supplier_list_screen.dart';
import '../../features/suppliers/screens/supplier_form_screen.dart';
import '../../features/stock/screens/category_list_screen.dart';
import '../../features/profile/screens/edit_profile_screen.dart';
import '../../features/profile/screens/user_management_screen.dart';
import '../../features/profile/screens/system_log_screen.dart';
import '../../features/profile/screens/help_support_screen.dart';
import '../../features/profile/screens/chat_support_screen.dart';
import '../../features/profile/screens/user_guide_screen.dart';
import '../../features/profile/screens/report_problem_screen.dart';
import '../../features/profile/screens/faq_screen.dart';
import '../../features/profile/screens/settings_screen.dart';
import '../../features/notifications/screens/notifications_screen.dart';
import '../../features/orders/screens/purchase_order_list_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/suppliers',
        name: 'suppliers',
        builder: (context, state) => const SupplierListScreen(),
      ),
      GoRoute(
        path: '/supplier-form',
        name: 'supplier-form',
        builder: (context, state) {
          final supplier = state.extra as Supplier?;
          return SupplierFormScreen(supplier: supplier);
        },
      ),
      GoRoute(
        path: '/categories',
        name: 'categories',
        builder: (context, state) => const CategoryListScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        builder: (context, state) => const ProductListScreen(),
      ),
      GoRoute(
        path: '/add-product',
        name: 'add-product',
        builder: (context, state) => const AddEditProductScreen(),
      ),
      GoRoute(
        path: '/edit-product',
        name: 'edit-product',
        builder: (context, state) {
          final product = state.extra as Product;
          return AddEditProductScreen(product: product);
        },
      ),
      GoRoute(
        path: '/low-stock',
        name: 'low-stock',
        builder: (context, state) => const LowStockAlertsScreen(),
      ),
      GoRoute(
        path: '/product/:id',
        name: 'product-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          // For now we get the product from extra or mock
          final product = state.extra as Product;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/user-management',
        name: 'user-management',
        builder: (context, state) => const UserManagementScreen(),
      ),
      GoRoute(
        path: '/system-logs',
        name: 'system-logs',
        builder: (context, state) => const SystemLogScreen(),
      ),
      GoRoute(
        path: '/help-support',
        name: 'help-support',
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/chat-support',
        name: 'chat-support',
        builder: (context, state) => const ChatSupportScreen(),
      ),
      GoRoute(
        path: '/user-guide',
        name: 'user-guide',
        builder: (context, state) => const UserGuideScreen(),
      ),
      GoRoute(
        path: '/report-problem',
        name: 'report-problem',
        builder: (context, state) => const ReportProblemScreen(),
      ),
      GoRoute(
        path: '/faq',
        name: 'faq',
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/orders',
        name: 'orders',
        builder: (context, state) => const PurchaseOrderListScreen(),
      ),
    ],
  );
}
