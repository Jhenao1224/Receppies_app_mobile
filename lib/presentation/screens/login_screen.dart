import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:receipes_app/components/custom_text_field.dart';
import 'package:receipes_app/components/primary_button.dart';
import 'package:receipes_app/constants/custom_colors.dart';
import 'package:receipes_app/presentation/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.6, 
                child: 
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello', 
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontSize: 30),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Welcome back', 
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  ],
                ),
              ),
              SizedBox(height: 80.0),            SizedBox(height: 20.0),
              CustomTextField(label: 'Email', placeholder: 'Enter your email', controller: _emailController, keyboardType: TextInputType.emailAddress,),
              SizedBox(height: 20.0),
              CustomTextField(label: 'Password', placeholder: 'Enter your password', controller: _passwordController, isPassword: true,),
              SizedBox(height: 25.0),
              InkWell(
                child: Text('Forgot your password?', 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.secondaryColor),
                ),
              ),
              SizedBox(height: 25.0),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  title: 'Sign In',
                  onPressed: () {
                    // Handle sign up logic here
                  },
                  ),
              ),
              SizedBox(height: 20.0),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.secondaryColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
            ),
      ),
  );
  }
}