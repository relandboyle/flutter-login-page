import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final bool kIsWeb = const bool.fromEnvironment('dart.library.js_util');

  void signUserOut() async {
    if (kIsWeb == true) {
      await FirebaseAuth.instance.setPersistence(Persistence.NONE);
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().disconnect();
    } else {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Logout:', style: TextStyle(color:  Theme.of(context).colorScheme.onPrimary),),
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
    );
  }
}
