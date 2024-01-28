import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/authentication/login_or_register_page.dart';
import '../home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  void createAccount() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot);
              print(snapshot.hasData);
              return const HomePage();
            } else {
              print(snapshot);
              print(snapshot.hasData);
              return const LoginOrRegisterPage();
            }
          }),
    );
  }
}
