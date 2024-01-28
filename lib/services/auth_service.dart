import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  authenticateWithGoogle() async {
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    GoogleSignInAccount? googleUser;
    try {
      // begin interactive sign in process
      if (kIsWeb == true) {
        print('K IS WEB');
        googleUser = await GoogleSignIn().signInSilently(suppressErrors: true);
      } else {
        print('K IS NOT WEB');
        googleUser = await GoogleSignIn().signIn();
      }

      FirebaseAuth.instance.authStateChanges().listen((event) {
        print('EVENT');
        print(event?.displayName);
      });

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
}
