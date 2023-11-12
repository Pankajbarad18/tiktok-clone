import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../widgets/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TikTok Clone',
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: buttonColor),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Register',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 25,
            ),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 64,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/Images/user.png'),
                ),
                Positioned(
                  bottom: -10,
                  left: 95,
                  child: IconButton(
                      onPressed: () => authController.pickImage(),
                      icon: const Icon(Icons.add_a_photo)),
                )
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  icon: Icons.person),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                  controller: _emailController,
                  labelText: 'Email',
                  icon: Icons.email),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextField(
                controller: _passwordController,
                labelText: 'Password',
                icon: Icons.password,
                isobscure: true,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: () => authController.registerUser(
                  _usernameController.text,
                  _emailController.text,
                  _passwordController.text,
                  authController.pickedImage),
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                    color: buttonColor, borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: buttonColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
