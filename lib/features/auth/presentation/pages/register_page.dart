import 'package:flutter/material.dart';
import 'package:tap_to_rent/features/auth/presentation/components/my_button.dart';
import 'package:tap_to_rent/features/auth/presentation/components/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  // text controller
  final emailControlller = TextEditingController();
  final pwController = TextEditingController();

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                size: 78,
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

                  // Confirm Password
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

                    // login button
                    MyButton(
                      onTap: () {},
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
