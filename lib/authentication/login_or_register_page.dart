import 'package:flutter/material.dart';

import 'login_page.dart';
import 'register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;
  void toggleLoginRegister() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: showLoginPage
            ? LoginPage(
                toggleLoginRegister: toggleLoginRegister,
              )
            : RegisterPage(
                toggleLoginRegister: toggleLoginRegister,
              ),
      ),
    );
  }
}
