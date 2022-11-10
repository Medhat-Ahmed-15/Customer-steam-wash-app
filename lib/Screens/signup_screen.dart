import 'dart:io';

import 'package:customer_steam_wash_app/Assistant/auth_methods.dart';
import 'package:customer_steam_wash_app/Providers/auth_provider.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'completeProfile_screen.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/SignupScreen';
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ColorProvider colorProviderObj;
  AuthProvider authProvider;

  bool _isInit = true;
  bool loading = false;
  bool showErrorText = false;
  bool hidePasswordText = true;
  bool hideConfirmPasswordText = true;

  Color emailBorderColor;
  Color emailFillColor;
  Color emailIconColor;
  Color emailInputTextColor;

  Color passwordBorderColor;
  Color passwordFillColor;
  Color passwordIconColor;
  Color passwordInputTextColor;
  Color passwordEyeColor;

  Color confirmPasswordBorderColor;
  Color confirmPasswordFillColor;
  Color confirmPasswordIconColor;
  Color confirmPasswordInputTextColor;
  Color confirmPasswordEyeColor;

  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String errortext;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
      authProvider = Provider.of<AuthProvider>(context, listen: true);

      emailBorderColor = colorProviderObj.backgroundDialogColor;
      emailFillColor = colorProviderObj.backgroundDialogColor;
      emailIconColor = Colors.grey[600];
      emailInputTextColor = colorProviderObj.textColor;

      passwordBorderColor = colorProviderObj.backgroundDialogColor;
      passwordFillColor = colorProviderObj.backgroundDialogColor;
      passwordIconColor = Colors.grey[600];
      passwordInputTextColor = colorProviderObj.textColor;
      passwordEyeColor = Colors.grey[600];

      confirmPasswordBorderColor = colorProviderObj.backgroundDialogColor;
      confirmPasswordFillColor = colorProviderObj.backgroundDialogColor;
      confirmPasswordIconColor = Colors.grey[600];
      confirmPasswordInputTextColor = colorProviderObj.textColor;
      confirmPasswordEyeColor = Colors.grey[600];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> checkThemeMode(BuildContext context) async {
    await Provider.of<ColorProvider>(context, listen: false)
        .checkThemeMethodInThisScreen();
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      barrierColor: Colors.white10,
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Provider.of<ColorProvider>(context, listen: true)
            .backgroundDialogColor,
        title: const Text('An Error Occurred!'),
        titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
        content: Text(
          errorMessage,
          style: TextStyle(
              color:
                  Provider.of<ColorProvider>(context, listen: true).textColor),
        ),
        actions: [
          FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Okay',
                  style: TextStyle(color: Theme.of(context).primaryColor)))
        ],
      ),
    );
  }

  Future<void> signUpUser() async {
    setState(() {
      loading = true;
    });

    try {
      final validEmail =
          await checkValidEmail(_emailAddressController.text.trim());

      if (validEmail != true) {
        setState(() {
          emailBorderColor = Colors.red;
          emailIconColor = Colors.red;
          emailInputTextColor = Colors.red;

          showErrorText = true;

          errortext = "Invalid email ❗";
          loading = false;
        });

        return;
      }

      if (_passwordController.text != _confirmPasswordController.text) {
        setState(() {
          passwordBorderColor = Colors.red;
          passwordIconColor = Colors.red;
          passwordInputTextColor = Colors.red;
          passwordEyeColor = Colors.red;

          confirmPasswordEyeColor = Colors.red;
          confirmPasswordBorderColor = Colors.red;
          confirmPasswordIconColor = Colors.red;
          confirmPasswordInputTextColor = Colors.red;

          showErrorText = true;

          errortext = "Passwords don't match ❗";
          loading = false;
        });

        return;
      }

      if (_passwordController.text.isEmpty ||
          _confirmPasswordController.text.isEmpty) {
        setState(() {
          passwordBorderColor = Colors.red;
          passwordIconColor = Colors.red;
          passwordInputTextColor = Colors.red;
          passwordEyeColor = Colors.red;

          confirmPasswordEyeColor = Colors.red;
          confirmPasswordBorderColor = Colors.red;
          confirmPasswordIconColor = Colors.red;
          confirmPasswordInputTextColor = Colors.red;

          showErrorText = true;

          errortext = "Invalid password ❗";

          loading = false;
        });

        return;
      }

      userEmail = _emailAddressController.text;
      userPassword = _passwordController.text;

      print('userEmail ${userEmail}');
      print('userPassword ${userPassword}');

      Navigator.pushNamed(context, CompleteProfileScreen.routeName);
    } on SocketException catch (error) {
      showErrorText = true;
      errortext = 'Please check your internet connection';
    } catch (error) {
      showErrorText = true;
      errortext = 'Error.could not authenticate you.';
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkThemeMode(context);
    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          // mainAxisAlignment: Main,
          children: [
            const SizedBox(
              height: 30,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Welcome 👋',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: colorProviderObj.textColor),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'I am happy to see you here ❤',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            //Email signin textfield************************************************************************************

            Container(
              decoration: BoxDecoration(
                color: emailFillColor,
                border: Border.all(
                  color: emailBorderColor,
                  width: 1.5,
                ),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              // width: 400,
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: emailIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          emailInputTextColor = colorProviderObj.textColor;
                          emailFillColor = colorProviderObj.backgroundColor;
                          emailBorderColor = Theme.of(context).primaryColor;
                          emailIconColor = Theme.of(context).primaryColor;
                        },
                        controller: _emailAddressController,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: emailInputTextColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: 'Email Address',
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //password signin textfield************************************************************************************

            Container(
              decoration: BoxDecoration(
                color: passwordFillColor,
                border: Border.all(
                  color: passwordBorderColor,
                  width: 1.5,
                ),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: passwordIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          passwordInputTextColor = colorProviderObj.textColor;
                          passwordFillColor = colorProviderObj.backgroundColor;
                          passwordBorderColor = Theme.of(context).primaryColor;
                          passwordIconColor = Theme.of(context).primaryColor;
                        },
                        controller: _passwordController,
                        obscureText: hidePasswordText,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: passwordInputTextColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            bool prevHidePasswordText = hidePasswordText;
                            hidePasswordText = !prevHidePasswordText;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: passwordIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            //confirm password signin textfield************************************************************************************

            Container(
              decoration: BoxDecoration(
                color: confirmPasswordFillColor,
                border: Border.all(
                  color: confirmPasswordBorderColor,
                  width: 1.5,
                ),
                // color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.lock_outline,
                      color: confirmPasswordIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          confirmPasswordInputTextColor =
                              colorProviderObj.textColor;
                          confirmPasswordFillColor =
                              colorProviderObj.backgroundColor;
                          confirmPasswordBorderColor =
                              Theme.of(context).primaryColor;
                          confirmPasswordIconColor =
                              Theme.of(context).primaryColor;
                        },
                        controller: _confirmPasswordController,
                        obscureText: hideConfirmPasswordText,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: confirmPasswordInputTextColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: 'Confirm password',
                          hintStyle:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            bool prevHideConfirmPasswordText =
                                hideConfirmPasswordText;
                            hideConfirmPasswordText =
                                !prevHideConfirmPasswordText;
                          });
                        },
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: confirmPasswordIconColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            // //error text
            showErrorText == true
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$errortext',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  )
                : SizedBox(height: 0),

            const SizedBox(
              height: 25,
            ),

            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: loading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              onTap: () {
                signUpUser();
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
