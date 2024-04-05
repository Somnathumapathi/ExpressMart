import 'package:expressmart/common/widgets/customButton.dart';
import 'package:expressmart/common/widgets/customTextField.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:expressmart/services/auth_service.dart';
import 'package:flutter/material.dart';

// import '../../../common/widgets/customTextField1.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Auth _auth = Auth.signup;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    authService.signUpUser(
        context: context,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  void onLogin() {
    authService.loginUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: GlobalVariables.greyBackgroundColor,
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            tileColor: _auth == Auth.signup
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundColor,
            title: const Text('Sign in'),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.signup,
              groupValue: _auth,
              onChanged: (Auth? value) {
                setState(() {
                  _auth = value!;
                });
              },
            ),
          ),
          if (_auth == Auth.signup)
            Container(
              padding: const EdgeInsets.all(10),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      hintText: 'Enter name',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Enter email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Enter password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: 'Sign up',
                        onTap: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            onSignUp();
                          }
                        })
                  ],
                ),
              ),
            ),
          ListTile(
            tileColor: _auth == Auth.signin
                ? GlobalVariables.backgroundColor
                : GlobalVariables.greyBackgroundColor,
            title: const Text('Log in'),
            leading: Radio(
              activeColor: GlobalVariables.secondaryColor,
              value: Auth.signin,
              groupValue: _auth,
              onChanged: (Auth? value) {
                setState(() {
                  _auth = value!;
                });
              },
            ),
          ),
          if (_auth == Auth.signin)
            Container(
              padding: const EdgeInsets.all(10),
              color: GlobalVariables.backgroundColor,
              child: Form(
                key: _signInFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'Enter email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: 'Enter password',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: 'Log in',
                        onTap: () {
                          // print('Reached');
                          if (_signInFormKey.currentState!.validate()) {
                            onLogin();
                          }
                        })
                  ],
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
