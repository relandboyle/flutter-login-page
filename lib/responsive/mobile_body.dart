import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../pages/buildings_page.dart';
import '../pages/profile_page.dart';
import '../pages/temperature_page.dart';
import '../pages/units_page.dart';
import '../theme/theme_provider.dart';

class MobileBody extends StatefulWidget {
  const MobileBody({super.key});

  @override
  State<MobileBody> createState() => _MobileBodyState();
}

class _MobileBodyState extends State<MobileBody> {
  int selectedIndex = 0;

  static const List<Widget> displayPages = <Widget>[
    TemperaturePage(),
    BuildingsPage(),
    UnitsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FloatingActionButton(
          elevation: 10,
          highlightElevation: 10,
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Theme.of(context).brightness == Brightness.light
              ? const Icon(
                  Icons.nightlight_round,
                )
              : const Icon(
                  Icons.wb_sunny_rounded,
                ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            activeColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            color: Theme.of(context).colorScheme.secondary,
            tabBackgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.thermostat,
                text: 'Temps',
              ),
              GButton(
                icon: Icons.location_city,
                text: 'Bldngs',
              ),
              GButton(
                icon: Icons.chair,
                text: 'Units',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: displayPages.elementAt(selectedIndex),
    );
  }
}
