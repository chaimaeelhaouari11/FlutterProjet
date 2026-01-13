import 'package:flutter/material.dart';

/// Cette classe gère l'internationalisation (i18n) de l'application.
/// Elle permet d'afficher l'interface dans différentes langues (Français, Anglais, Arabe).
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Méthode statique pour récupérer l'instance d'AppLocalizations depuis le BuildContext.
  /// Elle est utilisée partout dans l'UI pour accéder aux traductions.
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('fr'));
  }

  /// Le délégué qui gère le chargement des ressources localisées pour Flutter.
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// Conteneur central de toutes les chaines de caractères de l'application.
  /// Les clés sont identiques pour toutes les langues, ce qui facilite la maintenance.
  static final Map<String, Map<String, String>> _localizedValues = {
    'fr': {
      // General
      'app_name': 'SmartStock',
      'app_tagline': 'Gérez votre stock avec précision',
      'continue': 'Continuer',
      'cancel': 'Annuler',
      'save': 'Enregistrer',
      'delete': 'Supprimer',
      'search': 'Rechercher',
      'loading': 'Chargement...',
      'error': 'Erreur',
      'success': 'Succès',
      'retry': 'Réessayer',

      // Onboarding
      'onboarding_title_1': 'Apprenez Partout',
      'onboarding_desc_1': 'Accédez à vos cours où que vous soyez, quand vous le souhaitez.',
      'onboarding_title_2': 'Experts Qualifiés',
      'onboarding_desc_2': 'Apprenez avec les meilleurs instructeurs du domaine.',
      'onboarding_title_3': 'Certifications',
      'onboarding_desc_3': 'Obtenez des certificats reconnus pour valoriser vos compétences.',
      'get_started': 'Commencer',
      'skip': 'Passer',
      'next': 'Suivant',

      // Auth
      'welcome_back': 'Bon Retour!',
      'login': 'Connexion',
      'register': 'Inscription',
      'email': 'Email',
      'password': 'Mot de passe',
      'confirm_password': 'Confirmer le mot de passe',
      'full_name': 'Nom complet',
      'forgot_password': 'Mot de passe oublié?',
      'dont_have_account': 'Pas de compte?',
      'already_have_account': 'Déjà un compte?',
      'continue_as_guest': 'Continuer comme invité',
      'or': 'ou',
      'create_account': 'Créer un compte',
      'reset_password': 'Réinitialiser le mot de passe',
      'send_code': 'Envoyer le code',
      'verify_email': 'Vérifier l\'email',
      'enter_otp': 'Entrez le code OTP',
      'otp_sent': 'Un code a été envoyé à votre email',
      'verify': 'Vérifier',
      'resend_code': 'Renvoyer le code',

      // Home
      'home': 'Accueil',
      'hello': 'Bonjour',
      'what_to_learn': 'Que voulez-vous apprendre aujourd\'hui?',
      'categories': 'Catégories',
      'popular_courses': 'Cours Populaires',
      'see_all': 'Voir tout',
      'continue_learning': 'Continuer l\'apprentissage',

      // Courses
      'courses': 'Cours',
      'all_courses': 'Tous les cours',
      'my_courses': 'Mes cours',
      'course_details': 'Détails du cours',
      'lessons': 'Leçons',
      'about': 'À propos',
      'instructor': 'Instructeur',
      'duration': 'Durée',
      'students': 'Étudiants',
      'rating': 'Note',
      'start_course': 'Commencer le cours',
      'continue_course': 'Continuer le cours',
      'lesson': 'Leçon',
      'completed': 'Terminé',
      'in_progress': 'En cours',
      'not_started': 'Non commencé',
      'free': 'Gratuit',

      // Categories
      'development': 'Développement',
      'data_science': 'Data Science',
      'design': 'Design',
      'marketing': 'Marketing',
      'languages': 'Langues',

      // Video Player
      'video_summary': 'Résumé de la vidéo',
      'next_lesson': 'Leçon suivante',
      'previous_lesson': 'Leçon précédente',
      'mark_complete': 'Marquer comme terminé',

      // Progress
      'progress': 'Progression',
      'my_progress': 'Ma Progression',
      'courses_completed': 'Cours terminés',
      'hours_learned': 'Heures d\'apprentissage',
      'certificates_earned': 'Certificats obtenus',
      'current_streak': 'Série actuelle',

      // Quiz
      'quiz': 'Quiz',
      'start_quiz': 'Commencer le quiz',
      'question': 'Question',
      'of': 'sur',
      'submit': 'Soumettre',
      'quiz_result': 'Résultat du Quiz',
      'your_score': 'Votre score',
      'passed': 'Réussi',
      'failed': 'Échoué',
      'retake_quiz': 'Reprendre le quiz',
      'back_to_course': 'Retour au cours',

      // Certificate
      'certificate': 'Certificat',
      'certificate_of_completion': 'Certificat de Réussite',
      'download_certificate': 'Télécharger le certificat',
      'share_certificate': 'Partager le certificat',
      'certificate_ready': 'Votre certificat est prêt!',

      // Profile
      'profile': 'Profil',
      'edit_profile': 'Modifier le profil',
      'settings': 'Paramètres',
      'my_certificates': 'Mes Certificats',
      'logout': 'Déconnexion',
      'change_avatar': 'Changer l\'avatar',
      'select_avatar': 'Sélectionner un avatar',

      // Settings
      'appearance': 'Apparence',
      'dark_mode': 'Mode sombre',
      'language': 'Langue',
      'notifications': 'Notifications',
      'push_notifications': 'Notifications push',
      'email_notifications': 'Notifications par email',
      'about_app': 'À propos de l\'application',
      'version': 'Version',
      'privacy_policy': 'Politique de confidentialité',
      'terms_of_service': 'Conditions d\'utilisation',
      'help_support': 'Aide & Support',

      // Notifications
      'all_notifications': 'Toutes les notifications',
      'mark_all_read': 'Tout marquer comme lu',
      'no_notifications': 'Aucune notification',
    },
    'en': {
      // General
      'app_name': 'SmartStock',
      'app_tagline': 'Manage your stock with precision',
      'continue': 'Continue',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'search': 'Search',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'retry': 'Retry',

      // Onboarding
      'onboarding_title_1': 'Learn Anywhere',
      'onboarding_desc_1': 'Access your courses wherever you are, whenever you want.',
      'onboarding_title_2': 'Qualified Experts',
      'onboarding_desc_2': 'Learn from the best instructors in the field.',
      'onboarding_title_3': 'Certifications',
      'onboarding_desc_3': 'Get recognized certificates to enhance your skills.',
      'get_started': 'Get Started',
      'skip': 'Skip',
      'next': 'Next',

      // Auth
      'welcome_back': 'Welcome Back!',
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'full_name': 'Full Name',
      'forgot_password': 'Forgot Password?',
      'dont_have_account': 'Don\'t have an account?',
      'already_have_account': 'Already have an account?',
      'continue_as_guest': 'Continue as Guest',
      'or': 'or',
      'create_account': 'Create Account',
      'reset_password': 'Reset Password',
      'send_code': 'Send Code',
      'verify_email': 'Verify Email',
      'enter_otp': 'Enter OTP Code',
      'otp_sent': 'A code has been sent to your email',
      'verify': 'Verify',
      'resend_code': 'Resend Code',

      // Home
      'home': 'Home',
      'hello': 'Hello',
      'what_to_learn': 'What do you want to learn today?',
      'categories': 'Categories',
      'popular_courses': 'Popular Courses',
      'see_all': 'See All',
      'continue_learning': 'Continue Learning',

      // Courses
      'courses': 'Courses',
      'all_courses': 'All Courses',
      'my_courses': 'My Courses',
      'course_details': 'Course Details',
      'lessons': 'Lessons',
      'about': 'About',
      'instructor': 'Instructor',
      'duration': 'Duration',
      'students': 'Students',
      'rating': 'Rating',
      'start_course': 'Start Course',
      'continue_course': 'Continue Course',
      'lesson': 'Lesson',
      'completed': 'Completed',
      'in_progress': 'In Progress',
      'not_started': 'Not Started',
      'free': 'Free',

      // Categories
      'development': 'Development',
      'data_science': 'Data Science',
      'design': 'Design',
      'marketing': 'Marketing',
      'languages': 'Languages',

      // Video Player
      'video_summary': 'Video Summary',
      'next_lesson': 'Next Lesson',
      'previous_lesson': 'Previous Lesson',
      'mark_complete': 'Mark as Complete',

      // Progress
      'progress': 'Progress',
      'my_progress': 'My Progress',
      'courses_completed': 'Courses Completed',
      'hours_learned': 'Hours Learned',
      'certificates_earned': 'Certificates Earned',
      'current_streak': 'Current Streak',

      // Quiz
      'quiz': 'Quiz',
      'start_quiz': 'Start Quiz',
      'question': 'Question',
      'of': 'of',
      'submit': 'Submit',
      'quiz_result': 'Quiz Result',
      'your_score': 'Your Score',
      'passed': 'Passed',
      'failed': 'Failed',
      'retake_quiz': 'Retake Quiz',
      'back_to_course': 'Back to Course',

      // Certificate
      'certificate': 'Certificate',
      'certificate_of_completion': 'Certificate of Completion',
      'download_certificate': 'Download Certificate',
      'share_certificate': 'Share Certificate',
      'certificate_ready': 'Your certificate is ready!',

      // Profile
      'profile': 'Profile',
      'edit_profile': 'Edit Profile',
      'settings': 'Settings',
      'my_certificates': 'My Certificates',
      'logout': 'Logout',
      'change_avatar': 'Change Avatar',
      'select_avatar': 'Select Avatar',

      // Settings
      'appearance': 'Appearance',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'notifications': 'Notifications',
      'push_notifications': 'Push Notifications',
      'email_notifications': 'Email Notifications',
      'about_app': 'About App',
      'version': 'Version',
      'privacy_policy': 'Privacy Policy',
      'terms_of_service': 'Terms of Service',
      'help_support': 'Help & Support',

      // Notifications
      'all_notifications': 'All Notifications',
      'mark_all_read': 'Mark All as Read',
      'no_notifications': 'No Notifications',
    },
    'ar': {
      // General
      'app_name': 'SmartStock',
      'app_tagline': 'إدارة مخزونك بدقة',
      'continue': 'متابعة',
      'cancel': 'إلغاء',
      'save': 'حفظ',
      'delete': 'حذف',
      'search': 'بحث',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجاح',
      'retry': 'إعادة المحاولة',

      // Onboarding
      'onboarding_title_1': 'تعلم في أي مكان',
      'onboarding_desc_1': 'الوصول إلى دوراتك أينما كنت، متى شئت.',
      'onboarding_title_2': 'خبراء مؤهلون',
      'onboarding_desc_2': 'تعلم من أفضل المدربين في المجال.',
      'onboarding_title_3': 'شهادات',
      'onboarding_desc_3': 'احصل على شهادات معترف بها لتعزيز مهاراتك.',
      'get_started': 'ابدأ الآن',
      'skip': 'تخطي',
      'next': 'التالي',

      // Auth
      'welcome_back': 'مرحباً بعودتك!',
      'login': 'تسجيل الدخول',
      'register': 'حساب جديد',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'full_name': 'الاسم الكامل',
      'forgot_password': 'نسيت كلمة المرور؟',
      'dont_have_account': 'ليس لديك حساب؟',
      'already_have_account': 'لديك حساب بالفعل؟',
      'continue_as_guest': 'المتابعة كضيف',
      'or': 'أو',
      'create_account': 'إنشاء حساب',
      'reset_password': 'إعادة تعيين كلمة المرور',
      'send_code': 'إرسال الرمز',
      'verify_email': 'تأكيد البريد الإلكتروني',
      'enter_otp': 'أدخل رمز OTP',
      'otp_sent': 'تم إرسال رمز إلى بريدك الإلكتروني',
      'verify': 'تحقق',
      'resend_code': 'إعادة إرسال الرمز',

      // Home
      'home': 'الرئيسية',
      'hello': 'مرحباً',
      'what_to_learn': 'ماذا تريد أن تتعلم اليوم؟',
      'categories': 'الفئات',
      'popular_courses': 'الدورات الشائعة',
      'see_all': 'عرض الكل',
      'continue_learning': 'متابعة التعلم',

      // Courses
      'courses': 'الدورات',
      'all_courses': 'جميع الدورات',
      'my_courses': 'دوراتي',
      'course_details': 'تفاصيل الدورة',
      'lessons': 'الدروس',
      'about': 'حول',
      'instructor': 'المدرب',
      'duration': 'المدة',
      'students': 'الطلاب',
      'rating': 'التقييم',
      'start_course': 'بدء الدورة',
      'continue_course': 'متابعة الدورة',
      'lesson': 'درس',
      'completed': 'مكتمل',
      'in_progress': 'قيد التنفيذ',
      'not_started': 'لم يبدأ',
      'free': 'مجاني',

      // Categories
      'development': 'تطوير',
      'data_science': 'علم البيانات',
      'design': 'تصميم',
      'marketing': 'تسويق',
      'languages': 'لغات',

      // Video Player
      'video_summary': 'ملخص الفيديو',
      'next_lesson': 'الدرس التالي',
      'previous_lesson': 'الدرس السابق',
      'mark_complete': 'تحديد كمكتمل',

      // Progress
      'progress': 'التقدم',
      'my_progress': 'تقدمي',
      'courses_completed': 'دورات مكتملة',
      'hours_learned': 'ساعات التعلم',
      'certificates_earned': 'شهادات تم الحصول عليها',
      'current_streak': 'السلسلة الحالية',

      // Quiz
      'quiz': 'اختبار',
      'start_quiz': 'بدء الاختبار',
      'question': 'سؤال',
      'of': 'من',
      'submit': 'إرسال',
      'quiz_result': 'نتيجة الاختبار',
      'your_score': 'درجتك',
      'passed': 'ناجح',
      'failed': 'راسب',
      'retake_quiz': 'إعادة الاختبار',
      'back_to_course': 'العودة للدورة',

      // Certificate
      'certificate': 'شهادة',
      'certificate_of_completion': 'شهادة إتمام',
      'download_certificate': 'تحميل الشهادة',
      'share_certificate': 'مشاركة الشهادة',
      'certificate_ready': 'شهادتك جاهزة!',

      // Profile
      'profile': 'الملف الشخصي',
      'edit_profile': 'تعديل الملف الشخصي',
      'settings': 'الإعدادات',
      'my_certificates': 'شهاداتي',
      'logout': 'تسجيل الخروج',
      'change_avatar': 'تغيير الصورة الرمزية',
      'select_avatar': 'اختر صورة رمزية',

      // Settings
      'appearance': 'المظهر',
      'dark_mode': 'الوضع الداكن',
      'language': 'اللغة',
      'notifications': 'الإشعارات',
      'push_notifications': 'إشعارات الهاتف',
      'email_notifications': 'إشعارات البريد',
      'about_app': 'حول التطبيق',
      'version': 'الإصدار',
      'privacy_policy': 'سياسة الخصوصية',
      'terms_of_service': 'شروط الخدمة',
      'help_support': 'المساعدة والدعم',

      // Notifications
      'all_notifications': 'جميع الإشعارات',
      'mark_all_read': 'تحديد الكل كمقروء',
      'no_notifications': 'لا توجد إشعارات',
    },
  };

  /// Retourne la version traduite d'une clé spécifique.
  /// Si la clé n'est pas trouvée dans la langue actuelle, elle cherche en Français par défaut.
  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['fr']?[key] ??
        key;
  }
}

/// Classe interne qui indique à Flutter quelles langues sont supportées
/// et comment charger l'objet AppLocalizations.
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Liste des codes ISO 639-1 des langues gérées par l'app.
    return ['fr', 'en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // Crée l'instance de localisation lors du changement de langue.
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

/// Extension pratique pour accéder aux traductions plus rapidement dans les widgets.
/// Au lieu d'écrire: AppLocalizations.of(context).translate('key')
/// On peut écrire: context.tr('key') ou context.l10n.translate('key')

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  String tr(String key) => AppLocalizations.of(this).translate(key);
}
