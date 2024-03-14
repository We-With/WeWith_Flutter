import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginRemoteDataSource {
  late String? _token;

  Future<bool> login() async {
    GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    _token = googleAuth?.accessToken;
    if (_token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    await GoogleSignIn().signOut();

    return false;
  }

  Future<String> getToken() async {
    try {
      return _token ?? '';
    } catch (err) {
      return err.toString();
    }
  }
}
