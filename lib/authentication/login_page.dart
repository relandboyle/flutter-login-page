import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/components/my_button.dart';
import 'package:login_page/components/my_loading_dialog.dart';
import 'package:login_page/components/my_square_tile.dart';
import 'package:login_page/components/my_textfield.dart';
import 'package:login_page/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? toggleLoginRegister;
  const LoginPage({super.key, required this.toggleLoginRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
      showErrorCode(e.code);
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
                  const Icon(Icons.lock, size: 100),
                  const SizedBox(height: 50),
                  // welcome
                  Text('Welcome back, you\'ve been missed!', style: TextStyle(color: Colors.grey[700], fontSize: 16)),
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
                        Text('Forgot Password?', style: TextStyle(color: Colors.grey[600])),
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
                      imagePath: 'lib/images/apple.png',
                      onTap: () => print('APPLE'),
                    ),
                  ]),
                  const SizedBox(height: 50),
                  // not registered? register now
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Not registered?', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    GestureDetector(
                        onTap: widget.toggleLoginRegister,
                        child: const Text('Create an account.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)))
                  ])
                ]),
              ),
            ),
          ),
        ));
  }
}
