import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/profile_service.dart';
import '../widgets/custom_card.dart';
import 'payments_screen.dart';
import 'login_screen.dart';
import 'add_profile_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();
  bool _isLoggedIn = false;
  String _userName = '';
  String _currentProfile = ''; // Perfil actual seleccionado
  String _currentInitials = 'U'; // Iniciales del perfil

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    final userEmail = await _authService.getCurrentUserEmail();

    // Cargar el perfil actual
    final hasProfile = await _profileService.hasProfile();
    String profileName = '';
    String initials = 'U';

    if (hasProfile) {
      profileName = await _profileService.getProfileName() ?? '';
      initials = await _profileService.getProfileInitials();
    } else if (isLoggedIn) {
      // Si no hay perfil pero está logueado, usar un perfil por defecto
      profileName = 'Usuario Principal';
      await _profileService.setProfileName(profileName);
      initials = await _profileService.getProfileInitials();
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
      _userName = userEmail ?? '';
      _currentProfile = profileName;
      _currentInitials = initials;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return LoginScreen(onLoginSuccess: _checkLoginStatus);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Cuenta'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Sección de perfil actual
            _buildCurrentProfile(),

            const SizedBox(height: 24),

            // Opciones del menú
            _buildMenuOptions(),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar y nombre del perfil actual
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accent,
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _currentInitials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentProfile,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Perfil principal',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Editar datos y foto
          _buildMenuItem(
            icon: Icons.edit,
            title: 'Editar datos y foto',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),

          const SizedBox(height: 12),

          // Cambiar perfil
          _buildMenuItem(
            icon: Icons.switch_account,
            title: 'Cambiar perfil',
            onTap: () {
              _showProfileSelector();
            },
          ),

          const SizedBox(height: 12),

          // Añadir perfil
          _buildMenuItem(
            icon: Icons.person_add,
            title: 'Añadir perfil',
            onTap: () {
              _showAddProfileDialog();
            },
          ),

          const SizedBox(height: 12),

          // Mis Pagos (antes era una pantalla separada)
          _buildMenuItem(
            icon: Icons.receipt_long,
            title: 'Mis Pagos',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PaymentsScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 12),

          // Cerrar sesión
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Cerrar sesión',
            isDestructive: true,
            onTap: () {
              _showLogoutDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return CustomCard(
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? AppColors.error : AppColors.primary,
              size: 24.0,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color:
                      isDestructive ? AppColors.error : AppColors.textPrimary,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  void _showProfileSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Seleccionar perfil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileOption('Luis Perez', 'LP', true),
              _buildProfileOption('María García', 'MG', false),
              _buildProfileOption('Juan Rodríguez', 'JR', false),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileOption(String name, String initials, bool isSelected) {
    return InkWell(
      onTap: () async {
        // Actualizar el perfil en el servicio
        await _profileService.setProfileName(name);

        setState(() {
          _currentProfile = name;
          _currentInitials = initials;
        });

        if (mounted) {
          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryVeryLight : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade300,
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: AppColors.accent, width: 2)
                    : null,
              ),
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
              ),
          ],
        ),
      ),
    );
  }

  void _showAddProfileDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddProfileScreen(),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _authService.logout();
                if (mounted) {
                  Navigator.pop(context);
                  setState(() {
                    _isLoggedIn = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
              ),
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
}
