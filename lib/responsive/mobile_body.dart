import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('MOBILE BODY'),
          Text(FirebaseAuth.instance.currentUser?.email ?? 'Not logged in'),
        ],
      ),
    );
  }
}