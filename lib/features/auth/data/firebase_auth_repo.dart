/*
FIREBASE IS OUR BACKEND 
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tap_to_rent/features/auth/domain/entities/app_user.dart';
import 'package:tap_to_rent/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo{

  /// access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //LOGIN: Email & password

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // attempt sign in
      UserCredential userCredential = await firebaseAuth
      .signInWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid, 
        email: email
        );
        // return user 
        return user;
    }

    // catch error......
    catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  @override
  Future<AppUser?> registerWithEmailPassword(
    String email, String password) async{
      try {
        // attempt sign up
        UserCredential userCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

        // create user
        AppUser user = AppUser(uid: userCredential.user!.uid, email:  email);

        // return user
        return user;
      }

      // any errors...
      catch (e) {
        throw Exception('Registration failed $e');
      }

  }
  
  @override
  Future<void> deleteAccount() async{
    try {
      // get current user
      final user = firebaseAuth.currentUser;

      // check if there is a logged in user
      if (user == null) throw Exception('No user logged in..');

      // delete account
      await user.delete();

      // logout 
      await logout();
    }
    catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }
  
  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      // get current firebase user
      final firebaseUser = firebaseAuth.currentUser;
      
      // if no user is logged in, return null
      if (firebaseUser == null) return null;
      
      // convert firebase user to app user
      return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
      );
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }
  
  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }
  
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent successfully';
    } catch (e) {
      throw Exception('Failed to send password reset email: $e');
    }
  }
}