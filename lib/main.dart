// main.dart
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tap_to_rent/features/auth/data/firebase_auth_repo.dart';
import 'package:tap_to_rent/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tap_to_rent/features/auth/presentation/pages/login_page.dart';
import 'package:tap_to_rent/firebase_options.dart';
import 'package:tap_to_rent/screens/home_screen.dart';
import 'package:tap_to_rent/themes/dark_mode.dart';
import 'package:tap_to_rent/themes/light_mode.dart';
import 'package:tap_to_rent/upload_images.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase setup
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Supabase setup
  await Supabase.initialize(
    url: 'https://wgapttjzjlfjbumaaqnn.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndnYXB0dGp6amxmamJ1bWFhcW5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwNzM5NjcsImV4cCI6MjA3MzY0OTk2N30.pwdty-_GGALOHfLW7e4HryCl8Fe-yI9ioxHfS2eXzQI',
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(authRepo: FirebaseAuthRepo())..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tap to Rent',
        theme: lightMode,
        darkTheme: darkMode,
        home: const HomeScreen(showBottomNavBar: true),
        routes: {
          '/home': (context) => const HomeScreen(showBottomNavBar: true),
          '/upload': (context) => const UploadImagesPage(),
        },
      ),
    );
  }
}
