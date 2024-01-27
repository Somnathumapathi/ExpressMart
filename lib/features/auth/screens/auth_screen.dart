import 'package:expressmart/common/widgets/customButton.dart';
import 'package:expressmart/common/widgets/customTextField.dart';
import 'package:expressmart/constants/global_variables.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final signUpFormKey = GlobalKey<FormState>();
  final signInFormKey = GlobalKey<FormState>();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundColor,
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(children: [
        ListTile(
          tileColor: _auth == Auth.signup
              ? GlobalVariables.backgroundColor
              : GlobalVariables.greyBackgroundColor,
          title: Text('Sign in'),
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
            padding: EdgeInsets.all(10),
            color: GlobalVariables.backgroundColor,
            child: Form(
              key: signUpFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Enter name',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(text: 'Sign up', onTap: () {})
                ],
              ),
            ),
          ),
        ListTile(
          tileColor: _auth == Auth.signin
              ? GlobalVariables.backgroundColor
              : GlobalVariables.greyBackgroundColor,
          title: Text('Log in'),
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
            padding: EdgeInsets.all(10),
            color: GlobalVariables.backgroundColor,
            child: Form(
              key: signInFormKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter email',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter password',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(text: 'Log in', onTap: () {})
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
