// login_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FitZee/providers/fb_auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<FBAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FitZee - Login',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Color.fromARGB(255, 104, 4, 235),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  obscuringCharacter: '*',
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        var response = await authProvider.signInWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (response["status"]) {
                          if (mounted) {
                            Navigator.of(context).pushReplacementNamed("/user_data");
                          }
                        } else {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response["message"] ?? 'An error occurred'),
                              ),
                            );
                          }
                        }
                      } on FirebaseAuthException catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? 'An error occurred')),
                          );
                        }
                      }
                    }
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/register");
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
