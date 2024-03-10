import 'package:flutter/material.dart';
import 'package:heat_sync/pages/landing_page.dart';
import '../pages/buildings_page.dart';
import '../pages/profile_page.dart';
import '../pages/temperature_page.dart';
import '../pages/units_page.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class WebBody extends StatefulWidget {
  const WebBody({super.key});

  @override
  State<WebBody> createState() => _WebBodyState();
}

class _WebBodyState extends State<WebBody> {
  int selectedIndex = 4;

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
    LandingPage()
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    );
    final Color foregroundColor = Theme.of(context).colorScheme.onPrimaryContainer;
    final Color backgroundColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () => selectPage(4),
          child: Text(
            'HeatSync',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),
          ),
        ),
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        actions: [
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(0),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Text(
                'Temperature',
                style: textStyle,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(1),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Text(
                'Buildings',
                style: textStyle,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(2),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Text(
                'Units',
                style: textStyle,
              ),
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () => selectPage(3),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Text(
                'Profile',
                style: textStyle,
              ),
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Theme.of(context).brightness == Brightness.light
                ? const Icon(
                    Icons.nightlight_round,
                  )
                : const Icon(
                    Icons.wb_sunny_rounded,
                  ),
            hoverColor: Theme.of(context).colorScheme.secondary,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: displayPages.elementAt(selectedIndex),
    );
  }
}
