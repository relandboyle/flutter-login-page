import 'package:flutter/material.dart';
import '../pages/buildings_page.dart';
import '../pages/profile_page.dart';
import '../pages/temperature_page.dart';
import '../pages/units_page.dart';

class WebBody extends StatefulWidget {
  const WebBody({super.key});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  int selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  static const List<Widget> displayPages = <Widget>[
    TemperaturePage(),
    BuildingsPage(),
    UnitsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HeatSync'),
        backgroundColor: Colors.lightBlue.shade900,
        foregroundColor: Colors.grey.shade200,
        actions: [
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(0),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey.shade200,
                backgroundColor: Colors.lightBlue.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: const Text('Temperature'),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(1),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey.shade200,
                backgroundColor: Colors.lightBlue.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: const Text('Buildings'),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(2),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey.shade200,
                backgroundColor: Colors.lightBlue.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: const Text('Units'),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(3),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.grey.shade200,
                backgroundColor: Colors.lightBlue.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: const Text('Profile'),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: displayPages.elementAt(selectedIndex),
    );
  }
}
