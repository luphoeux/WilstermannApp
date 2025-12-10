import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import '../../core/constants/colors.dart';
import 'home_screen.dart';
import 'fixture_screen.dart';
import 'store_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeScreen(),
          FixtureScreen(),
          StoreScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackMedium,
              blurRadius: 20,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, HugeIcons.strokeRoundedHome01,
                    HugeIcons.strokeRoundedHome01, 'Inicio'),
                _buildNavItem(1, HugeIcons.strokeRoundedCalendarFavorite01,
                    HugeIcons.strokeRoundedCalendarFavorite01, 'Fixture'),
                _buildNavItem(2, HugeIcons.strokeRoundedShoppingBag01,
                    HugeIcons.strokeRoundedShoppingBag01, 'Tienda'),
                _buildNavItem(3, HugeIcons.strokeRoundedUser,
                    HugeIcons.strokeRoundedUser, 'Cuenta'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, dynamic icon, dynamic activeIcon, String label) {
    final isSelected = _currentIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HugeIcon(
                icon: isSelected ? activeIcon : icon,
                color: isSelected ? AppColors.primary : Colors.grey.shade600,
                size: 24.0,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? AppColors.primary : Colors.grey.shade600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
