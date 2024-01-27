import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'responsive/responsive_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[800],
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout), color: Colors.grey[300],
          ),
        ],
      ),
      body: const ResponsiveLayout(),
    );
  }
}
