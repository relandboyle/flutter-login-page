import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/authentication/login_or_register_page.dart';
import '../pages/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // logger.i(snapshot);
            // logger.i(snapshot.hasData);
            return const HomePage();
          } else {
            // logger.i(snapshot);
            // logger.i(snapshot.hasData);
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
