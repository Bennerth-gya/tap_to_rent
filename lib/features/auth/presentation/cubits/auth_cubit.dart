/*
Cubits are responsible for state management

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_to_rent/features/auth/domain/entities/app_user.dart';
import 'package:tap_to_rent/features/auth/domain/repos/auth_repo.dart';
import 'package:tap_to_rent/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState>{
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // get current user
  AppUser? get currentUser => _currentUser;

  // check if user is authenticated
  void checkAuth() async {
    try {
      // loading..
      emit(AuthLoading());

      // get current user
      final AppUser? user = await authRepo.getCurrentUser();

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // Login with email + pw
  Future<void> login(String email, String pw) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.loginWithEmailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // Register with email + pw
  Future<void> register(String email, String pw) async {
    try {
      emit(AuthLoading());
      final AppUser? user = await authRepo.registerWithEmailPassword(email, pw);
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      emit(AuthLoading());
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  // Forgot pw
  Future<String> forgotPassword(String email) async {
    try {
      final message = await authRepo.sendPasswordResetEmail(email);
      return message;
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }
// Delete account
Future<void> deleteAccount() async {
  try {
    emit(AuthLoading());
    await authRepo.deleteAccount();
    emit(Unauthenticated());
  } catch (e) {
    emit(AuthError(e.toString()));
    emit(Unauthenticated());
  }
}
}