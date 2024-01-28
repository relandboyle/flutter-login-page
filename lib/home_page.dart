import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'responsive/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');

  void signUserOut() async {
    if (kIsWeb == true) {
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
    } else {
      await GoogleSignIn().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Colors.grey[300],
          ),
        ],
      ),
      body: const ResponsiveLayout(),
    );
  }
}
