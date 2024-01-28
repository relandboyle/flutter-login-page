import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  authenticateWithGoogle() async {
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    try {
      final GoogleSignInAccount? googleUser;
      // begin interactive sign in process
      if (kIsWeb == true) {
        googleUser = await GoogleSignIn().signInSilently();
      } else {
        googleUser = await GoogleSignIn().signIn();
      }

      // obtain auth details from request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      print('GOOGLE AUTH');
      print(googleAuth);

      // create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('CREDENTIAL');
      print(credential);

      // sign in
      await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // handle error
      print('ERROR');
      print(e);
      print(kIsWeb);
    }
  }
}
