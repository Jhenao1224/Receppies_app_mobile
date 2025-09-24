import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receipes_app/components/custom_text_field.dart';
import 'package:receipes_app/components/primary_button.dart';
import 'package:receipes_app/constants/custom_colors.dart';
import 'package:receipes_app/constants/validator.dart';
import 'package:receipes_app/presentation/screens/login_screen.dart';
import 'package:receipes_app/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isAcceptTerms = false;

  void _handleSignUp() {
    if (_formKey.currentState?.validate() != true) {
      if (!_isAcceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please accept the terms and conditions'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final authProvider = context.read<AuthProvider>();
      authProvider.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
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
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  label: 'Name',
                  placeholder: 'Enter your name',
                  controller: _nameController, 
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  label: 'Email',
                  placeholder: 'Enter your email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  label: 'Password',
                  placeholder: 'Enter your password',
                  controller: _passwordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                CustomTextField(
                  label: 'Confirm Password',
                  placeholder: 'Re-enter your password',
                  controller: _confirmPasswordController,
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value.trim() != _passwordController.text.trim()) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
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
                      },
                    ),
                    Text(
                      'Accept terms and conditions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: CustomColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        title: authProvider.authState == AuthState.loading
                            ? 'Loading...'
                            : 'Sign Up',
                        onPressed: () {
                          if (authProvider.authState == AuthState.loading) {
                            return; // Prevent multiple submissions
                          }
                          _handleSignUp();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: "Already a member? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: CustomColors.secondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
