import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:receipes_app/components/custom_text_field.dart';
import 'package:receipes_app/components/primary_button.dart';
import 'package:receipes_app/constants/custom_colors.dart';
import 'package:receipes_app/presentation/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isAcceptTerms = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    'Create Account', 
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Lets help you set up yout account, it will take a few minutes', 
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0),
            CustomTextField(label: 'Name', placeholder: 'Enter your name', controller: _nameController,),
            SizedBox(height: 20.0),
            CustomTextField(label: 'Email', placeholder: 'Enter your email', controller: _emailController, keyboardType: TextInputType.emailAddress,),
            SizedBox(height: 20.0),
            CustomTextField(label: 'Password', placeholder: 'Enter your password', controller: _passwordController, isPassword: true,),
            SizedBox(height: 20.0),
            CustomTextField(label: 'Confirm Password', placeholder: 'Re-enter your password', controller: _confirmPasswordController, isPassword: true,),
            SizedBox(height: 20.0),
            Row(
              children: [
                Checkbox(
                  activeColor: CustomColors.secondaryColor,
                  side: BorderSide(color: CustomColors.secondaryColor),
                  value: _isAcceptTerms, 
                  onChanged: (value) {
                  setState(() {
                    _isAcceptTerms = value ?? false;
                  });
                }),
                Text('Accept terms and conditions', 
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.secondaryColor),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                title: 'Sign Up',
                onPressed: () {
                  // Handle sign up logic here
                },
                ),
            ),
            Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Already a member? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: CustomColors.secondaryColor, fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
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
  );
  }
}