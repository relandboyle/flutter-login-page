import 'package:flutter/material.dart';
import 'package:login_page/components/my_button.dart';
import 'package:login_page/components/my_square_tile.dart';
import 'package:login_page/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {
    print(userNameController.text);
    print(passwordController.text);
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
                  MyTextField(controller: userNameController, hintText: 'Username', obscureText: false),
                  const SizedBox(height: 10),
                  // password
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
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
                            child: Text('Or continue with', style: TextStyle(color: Colors.grey[700]))),
                        Expanded(
                            child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        )),
                      ])),
                  const SizedBox(height: 50),
                  // google + apple sign in buttons
                  const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    MySquareTile(imagePath: 'lib/images/google.png'),
                    SizedBox(width: 20),
                    MySquareTile(imagePath: 'lib/images/apple.png'),
                  ]),
                  const SizedBox(height: 50),
                  // not registered? register now
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Not registered?', style: TextStyle(color: Colors.grey[700])),
                    const SizedBox(width: 4),
                    const Text('Sign up.', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))
                  ])
                ]),
              ),
            ),
          ),
        ));
  }
}
