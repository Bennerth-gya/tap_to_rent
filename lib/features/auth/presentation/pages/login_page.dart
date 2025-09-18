// features/auth/presentation/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:tap_to_rent/features/auth/presentation/components/my_button.dart';
import 'package:tap_to_rent/features/auth/presentation/components/my_textfield.dart';
import 'package:tap_to_rent/screens/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text controllers
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_open,
                size: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 25),
              Text(
                "TAP  TO  RENT",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 25),

              // email textfield
              MyTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 10),

              // password textfield
              MyTextfield(
                controller: pwController,
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 15),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // login button
              MyButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const HomeScreen(showBottomNavBar: true),
                    ),
                  );
                },
                text: "LOGIN",
              ),

              const SizedBox(height: 25),

              // register prompt
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
