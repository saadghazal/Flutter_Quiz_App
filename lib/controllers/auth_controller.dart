import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_study_project/firebase_ref/references.dart';
import 'package:flutter_study_project/screens/home/home_screen.dart';
import 'package:flutter_study_project/screens/login/login_screen.dart';
import 'package:flutter_study_project/widgets/dialogs/dialog_widget.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;
  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final _authAccount = await googleSignInAccount.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
        await _auth.signInWithCredential(_credential);
        saveUser(googleSignInAccount);
        navigateToHomePage();
      }
    } on Exception catch (error) {
      print(error.toString());
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'profilepic': account.photoUrl,
    });
  }

  void navigateToIntroduction() {
    Get.offAllNamed('/introduction');
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.questionStartDialog(
        onTap: () {
          Get.back();
          navigateToLoginPage();
        },
      ),
      barrierDismissible: false,
    );
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<void> signOut() async {
    print('sign out');
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }
}
