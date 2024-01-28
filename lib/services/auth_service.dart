import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  authenticateWithGoogle() async {
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    GoogleSignInAccount? googleUser;
    try {
      // check whether platform is web or mobile
      if (kIsWeb == true) {
        // print('K IS WEB');
        googleUser = await GoogleSignIn().signInSilently();
      } else {
        // print('K IS NOT WEB');
        googleUser = await GoogleSignIn().signIn();
      }

      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   print('EVENT');
      //   print(user?.displayName);
      // });

      // obtain auth details from request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      // print('GOOGLE AUTH');
      // print(googleAuth.idToken.toString());

      // create a new credential for user
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // print('CREDENTIAL');
      // print(credential.token);
      // print(credential.idToken);
      // print(credential.accessToken);

      // sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // handle error
      print('ERROR');
      print(e);
      print(kIsWeb);
    }
  }

  authenticateWithGutHub() async {
    final authorizationEndpoint = Uri.parse('https://heat-sync.firebaseapp.com/__/auth/handler');
    final tokenEndpoint = Uri.parse('https://heat-sync.firebaseapp.com/token');
  }
}
