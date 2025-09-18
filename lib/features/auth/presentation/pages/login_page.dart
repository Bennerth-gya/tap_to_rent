// features/auth/presentation/pages/login_page.dart
/*
LOGIN PAGE UI:
  In this page the user logs into their account

  And if the user does not have an account,
    they are being redirected to the register page to register an account

*/
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

  // text controller
  final emailControlller = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APP BAR
     
      // BODY
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(
                Icons.lock_open,
                size: 80,
                color: Colors.black,
              ),
          
              const SizedBox(height: 25,),
          
              // name of app
              Text(
                "TAP  TO  RENT",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(height: 25,),
          
                // email textfield
                MyTextfield(
                  controller: emailControlller, 
                  hintText: "Email", 
                  obscureText: false
                  ),

                const SizedBox(height: 10,),

                  // pw Textfield
                  MyTextfield(
                    controller: pwController, 
                    hintText: "Password", 
                    obscureText: true
                    ),

                    const SizedBox(height: 15,),

                    // forgot password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                const SizedBox(height: 25,),
                    // login button
                    MyButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      text: "LOGIN",
                    ),

                    // auth sign in later... (google + apple)
                    
                    const SizedBox(height: 25,),

                    // don't have an account? register now!
                    Row(
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(width: 6,),
                        Text(
                          "Register now", 
                          style: TextStyle(fontWeight: FontWeight.bold),
                          )
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}