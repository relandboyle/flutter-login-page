import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_loading_dialog.dart';
import '../components/my_square_tile.dart';
import '../components/my_textfield.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? toggleLoginRegister;
  const LoginPage({super.key, required this.toggleLoginRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void forgotPassword() async {
    showLoadingDialog(context);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      if (mounted) hideLoadingDialog(context);
      showFeedback('Sent reset email', Colors.green);
    } on FirebaseAuthException catch (e) {
      if (mounted) hideLoadingDialog(context);
      showFeedback(e.code, Colors.red);
    }
  }

  void signUserIn() async {
    showLoadingDialog(context);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (mounted) hideLoadingDialog(context);
    } on FirebaseAuthException catch (e) {
      if (mounted) hideLoadingDialog(context);
      showFeedback(e.code, Colors.red);
    }
  }

  void showFeedback(String message, Color color) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: color,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          titleTextStyle: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  // logo
                  const Icon(Icons.lock, size: 100),
                  const SizedBox(height: 50),
                  // welcome
                  Text('Welcome back!', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                  const SizedBox(height: 25),
                  //username
                  MyTextField(controller: emailController, hintText: 'Username', obscureText: false),
                  const SizedBox(height: 10),
                  // password
                  MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                  const SizedBox(height: 10),
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: forgotPassword,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // sign in button
                  MyButton(
                    onTap: signUserIn,
                    label: 'Sign In',
                  ),
                  const SizedBox(height: 50),
                  // not registered? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not registered?', style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.toggleLoginRegister,
                        child: const Text(
                          'Create an account.',
                          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // or continue with
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(children: [
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with:',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ])),
                  const SizedBox(height: 50),
                  // google + apple sign in buttons
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MySquareTile(
                      imagePath: 'lib/images/google.png',
                      onTap: () => AuthService().authenticateWithGoogle(),
                    ),
                    const SizedBox(width: 20),
                    MySquareTile(
                      imagePath: 'lib/images/github.png',
                      onTap: () => print(widget),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
