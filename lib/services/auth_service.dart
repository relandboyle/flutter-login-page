import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class AuthService {
  authenticateWithGoogle() async {
    const bool kIsWeb = bool.fromEnvironment('dart.library.js_util');

    GoogleSignInAccount? googleUser;
    try {
      // check whether platform is web or mobile
      if (kIsWeb == true) {
        // logger.i('K IS WEB');
        googleUser = await GoogleSignIn().signInSilently();
      } else {
        // logger.i('K IS NOT WEB');
        googleUser = await GoogleSignIn().signIn();
      }

      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   logger.i('EVENT');
      //   logger.i(user?.displayName);
      // });

      // obtain auth details from request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      // logger.i('GOOGLE AUTH');
      // logger.i(googleAuth.idToken.toString());

      // create a new credential for user
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // logger.i('CREDENTIAL');
      // logger.i(credential.token);
      // logger.i(credential.idToken);
      // logger.i(credential.accessToken);

      // sign in
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // handle error
      logger.i('ERROR');
      logger.i(e);
      logger.i(kIsWeb);
    }
  }

  // authenticateWithGutHub() async {
  //   final authorizationEndpoint = Uri.parse('https://heat-sync.firebaseapp.com/__/auth/handler');
  //   final tokenEndpoint = Uri.parse('https://heat-sync.firebaseapp.com/token');
  // }
}
