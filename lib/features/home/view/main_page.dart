import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_page.dart';
import '../../profile/view/profile_page.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../../profile/bloc/profile/profile_bloc.dart';
import '../../profile/bloc/profile/profile_event.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  late final HomeBloc _homeBloc;
  late final ProfileBloc _profileBloc;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _homeBloc = HomeBloc()..add(const LoadMovies());
    _profileBloc = ProfileBloc()..add(const LoadProfile());
    _pageController = PageController();

    _homeBloc.setProfileBloc(_profileBloc);
  }

  @override
  void dispose() {
    _homeBloc.close();
    _profileBloc.close();
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeBloc),
        BlocProvider.value(value: _profileBloc),
      ],
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            HomePage(key: const PageStorageKey('home_page')),
            ProfilePage(key: const PageStorageKey('profile_page')),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    label: 'main.home'.tr(),
                    isSelected: _currentIndex == 0,
                    onTap: () => _onNavItemTapped(0),
                    theme: theme,
                  ),
                  _buildNavItem(
                    icon: Icons.person,
                    label: 'main.profile'.tr(),
                    isSelected: _currentIndex == 1,
                    onTap: () => _onNavItemTapped(1),
                    theme: theme,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 125,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurface.withValues(alpha: 0.2),
              size: 24,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onSurface
                    : Colors.grey[600],
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
