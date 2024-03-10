import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heat_sync/components/my_icon_button.dart';
import 'package:logger/logger.dart';
import '../components/my_button.dart';
import '../components/my_loading_dialog.dart';
import '../components/my_textfield.dart';
import '../services/auth_service.dart';

Logger logger = Logger();

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
      showFeedback('Sent reset email', const Color.fromARGB(255, 14, 93, 17));
    } on FirebaseAuthException catch (e) {
      if (mounted) hideLoadingDialog(context);
      showFeedback(e.code, const Color.fromARGB(255, 101, 19, 13));
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
      showFeedback(e.code, const Color.fromARGB(255, 101, 19, 13));
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
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset('lib/images/heatsync.png', height: 100),
              const SizedBox(height: 50),
              // welcome
              Text('Welcome to HeatSync.', style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontSize: 20)),
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
                    child: Text(
                      'Create an account.',
                      style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer, fontWeight: FontWeight.bold),
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
                      thickness: 2,
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
                      thickness: 2,
                      color: Colors.grey[400],
                    )),
                  ])),
              const SizedBox(height: 50),
              MyIconButton(
                buttonAction: () => AuthService().authenticateWithGoogle(),
                label: 'Sign in with Google',
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
