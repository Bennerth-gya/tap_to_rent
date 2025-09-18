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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );

  // supabse setup
  await Supabase.initialize(
    url: 'https://wgapttjzjlfjbumaaqnn.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndnYXB0dGp6amxmamJ1bWFhcW5uIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgwNzM5NjcsImV4cCI6MjA3MzY0OTk2N30.pwdty-_GGALOHfLW7e4HryCl8Fe-yI9ioxHfS2eXzQI'
  );
}


/*
void main() async {
  // firebase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // run app
  runApp(const MyApp());
}
*/


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
        home: const UploadImages(),
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  const Responsive({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // web application
      if (constraints.maxWidth > 500) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tap to Rent - Web'),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
          body: Row(
            children: [
              // Sidebar for web
              Container(
                width: 200,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text('Home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomeScreen(showBottomNavBar: false)),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.search),
                      title: const Text('Search'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.favorite),
                      title: const Text('Favorites'),
                      onTap: () {
                        // TODO: Replace with FavoritesPage
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.message),
                      title: const Text('Messages'),
                      onTap: () {
                        
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Profile'),
                      onTap: () {
                        // TODO: Replace with ProfilePage
                      },
                    ),
                  ],
                ),
              ),
              // Main content area
              const Expanded(
                child: HomeScreen(showBottomNavBar: false),
              ),
            ],
          ),
        );
      } else {
        // mobile
        return const HomeScreen(showBottomNavBar: true);
      }
    });
  }
}
