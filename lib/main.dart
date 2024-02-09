import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/theme/theme_data.dart.dart';
import 'authentication/auth_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brightness brightness = Brightness.light;

  void swapTheme(Brightness newBrightness) {
    setState(() {
      brightness = newBrightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HeatSync',
      theme: HeatSyncTheme().lightTheme,
      darkTheme: HeatSyncTheme().darkTheme,
      themeMode: ThemeMode.system,
      home: const AuthPage(),
    );
  }
}
