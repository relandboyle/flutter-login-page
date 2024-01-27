import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WebBody extends StatelessWidget {
  const WebBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('WEB BODY'),
          Text(FirebaseAuth.instance.currentUser?.email ?? 'Not logged in'),
        ],
      ),
    );
  }
}
