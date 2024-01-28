import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';
import '../components/my_loading_dialog.dart';
import '../components/my_square_tile.dart';
import '../components/my_textfield.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? toggleLoginRegister;
  const RegisterPage({super.key, required this.toggleLoginRegister});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void registerUser() async {
    showLoadingDialog(context);

    if (passwordController.text == confirmPasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) hideLoadingDialog(context);
      } on FirebaseAuthException catch (e) {
        if (mounted) hideLoadingDialog(context);
        showErrorCode(e.code);
      }
    } else {
      if (mounted) hideLoadingDialog(context);
      showErrorCode('Passwords do not match');
    }
  }

  void showErrorCode(String errorCode) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.red,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titleTextStyle: TextStyle(color: Colors.grey[100], fontWeight: FontWeight.bold),
          title: Center(
            child: Text(
              errorCode,
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
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 50),
                // logo
                const Icon(Icons.lock, size: 48),
                const SizedBox(height: 41),
                // welcome
                Text('Please create an account!', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
                const SizedBox(height: 25),
                //username
                MyTextField(controller: emailController, hintText: 'Username', obscureText: false),
                const SizedBox(height: 10),
                // password
                MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),
                const SizedBox(height: 10),
                // password confirm
                MyTextField(controller: confirmPasswordController, hintText: 'Confirm Password', obscureText: true),
                const SizedBox(height: 50),
                // sign in button
                MyButton(
                  onTap: registerUser,
                  label: 'Create Account',
                ),
                const SizedBox(height: 50),
                // not registered? register now
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Already registered?',
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.toggleLoginRegister,
                    child: const Text(
                      'Sign in.',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  )
                ]),
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
                          child: Text('Or continue with:', style: TextStyle(color: Colors.grey[700]))),
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
