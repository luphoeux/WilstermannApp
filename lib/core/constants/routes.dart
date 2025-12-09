/// Rutas de navegación de la aplicación
class AppRoutes {
  // Auth
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Main
  static const String home = '/home';
  static const String memberships = '/memberships';
  static const String membershipDetail = '/membership-detail';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';

  // Memberships
  static const String buyMembership = '/buy-membership';
  static const String paymentMethod = '/payment-method';
  static const String paymentConfirmation = '/payment-confirmation';

  // News
  static const String news = '/news';
  static const String newsDetail = '/news-detail';

  // Admin
  static const String adminDashboard = '/admin';
  static const String userManagement = '/admin/users';
  static const String membershipManagement = '/admin/memberships';
  static const String contentManagement = '/admin/content';
  static const String reports = '/admin/reports';

  // Settings
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String about = '/about';
  static const String termsAndConditions = '/terms';
  static const String privacyPolicy = '/privacy';
}
