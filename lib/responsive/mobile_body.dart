import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../pages/buildings_page.dart';
import '../pages/profile_page.dart';
import '../pages/temperature_page.dart';
import '../pages/units_page.dart';

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
      bottomNavigationBar: Container(
        color: Colors.lightBlue.shade900,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            activeColor: Colors.lightBlue.shade900,
            backgroundColor: Colors.lightBlue.shade900,
            color: Colors.grey.shade300,
            tabBackgroundColor: Colors.grey.shade300,
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
