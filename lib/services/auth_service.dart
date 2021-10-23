import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn();

class AuthService {

  GoogleSignIn googleSignIn() => _googleSignIn;

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn().signIn();
    return googleUser;
  }

  Future<GoogleSignInAuthentication?> signInAuthentication() async {
    final GoogleSignInAccount? googleUser = await signInWithGoogle();
    return await googleUser?.authentication;
  }


  Future<void> signOut() => _googleSignIn.disconnect();

}