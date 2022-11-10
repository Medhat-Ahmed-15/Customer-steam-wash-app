import 'dart:io';

import 'package:customer_steam_wash_app/Models/loginCustomer_httpException.dart';
import 'package:customer_steam_wash_app/Providers/auth_provider.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/forgotPassword_screen.dart';
import 'package:customer_steam_wash_app/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  static const routName = '/SiginScreen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  ColorProvider colorProviderObj;
  AuthProvider authProvider;

  bool _isInit = true;
  bool loading = false;
  bool loadingScreen;
  bool showErrorText = false;
  bool hidePasswordText = true;

  Color emailBorderColor;
  Color emailFillColor;
  Color emailIconColor;
  Color emailInputTextColor;

  Color passwordBorderColor;
  Color passwordFillColor;
  Color passwordIconColor;
  Color passwordInputTextColor;
  Color eyeColor;

  final _emailAddressController = TextEditingController();
  final _passwordController = TextEditingController();

  String errortext;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
      authProvider = Provider.of<AuthProvider>(context, listen: true);

      setState(() {
        loadingScreen = true;
      });

      Provider.of<ColorProvider>(context, listen: false)
          .checkThemeMethodInThisScreen()
          .then((value) {
        emailBorderColor = colorProviderObj.backgroundDialogColor;
        emailFillColor = colorProviderObj.backgroundDialogColor;
        emailIconColor = Colors.grey[600];
        emailInputTextColor = colorProviderObj.textColor;

        passwordBorderColor = colorProviderObj.backgroundDialogColor;
        passwordFillColor = colorProviderObj.backgroundDialogColor;
        passwordIconColor = Colors.grey[600];
        passwordInputTextColor = colorProviderObj.textColor;
        eyeColor = Colors.grey[600];

        setState(() {
          loadingScreen = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // void showErrorDialog(String errorMessage) {
  //   showDialog(
  //     barrierColor: Colors.white10,
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       backgroundColor: Provider.of<ColorProvider>(context, listen: true)
  //           .backgroundDialogColor,
  //       title: const Text('An Error Occurred!'),
  //       titleTextStyle: TextStyle(color: Theme.of(context).primaryColor),
  //       content: Text(
  //         errorMessage,
  //         style: TextStyle(
  //             color:
  //                 Provider.of<ColorProvider>(context, listen: true).textColor),
  //       ),
  //       actions: [
  //         FlatButton(
  //             onPressed: () => Navigator.of(context).pop(),
  //             child: Text('Okay',
  //                 style: TextStyle(color: Theme.of(context).primaryColor)))
  //       ],
  //     ),
  //   );
  // }

  void customerLogin(BuildContext context) async {
    setState(() {
      loading = true;
    });

    try {
      await authProvider.loginCustomerWithEmailAndPassword(
          _emailAddressController.text.trim(), _passwordController.text.trim());
    } on loginCustomerHttpException catch (error) {
      var errorField = error.errorField();

      if (errorField == 'email') {
        setState(() {
          emailBorderColor = Colors.red;
          emailIconColor = Colors.red;
          emailInputTextColor = Colors.red;
          showErrorText = true;
          errortext = error.errorMessage();
          loading = false;
        });
      } else if (errorField == 'password') {
        setState(() {
          passwordBorderColor = Colors.red;
          passwordIconColor = Colors.red;
          passwordInputTextColor = Colors.red;
          showErrorText = true;
          eyeColor = Colors.red;
          errortext = error.errorMessage();
          loading = false;
        });
      }
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
    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: loadingScreen == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Expanded(child: Container()),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome Back 👋',
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
                      'I am happy to see you here. You can continue where you left off by logging in',
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
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
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
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
                                emailInputTextColor =
                                    colorProviderObj.textColor;
                                emailFillColor =
                                    colorProviderObj.backgroundColor;
                                emailBorderColor =
                                    Theme.of(context).primaryColor;
                                emailIconColor = Theme.of(context).primaryColor;
                              },
                              controller: _emailAddressController,
                              keyboardType: TextInputType.text,
                              cursorColor: Theme.of(context).primaryColor,
                              style: TextStyle(
                                color: emailInputTextColor,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(8),
                                hintText: 'Email Address',
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                ),
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
                  //password signin textfield************************************************************************************

                  Container(
                    // margin: const EdgeInsets.only(top: 25, left: 25, right: 30),
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
                      padding: const EdgeInsets.all(8),
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
                                passwordInputTextColor =
                                    colorProviderObj.textColor;
                                passwordFillColor =
                                    colorProviderObj.backgroundColor;
                                passwordBorderColor =
                                    Theme.of(context).primaryColor;
                                passwordIconColor =
                                    Theme.of(context).primaryColor;
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
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
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
                    height: 5,
                  ),
                  //error text
                  showErrorText == true
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '❗$errortext',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 15),
                          ),
                        )
                      : const SizedBox(height: 0),

                  FlatButton(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, ForgotPasswordScreen.routeName);
                    },
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 60,
                      child: Align(
                        alignment: Alignment.center,
                        child: loading == true
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Sign in',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    onTap: () {
                      customerLogin(context);
                    },
                  ),

                  const SizedBox(
                    height: 47,
                  ),
                  Text(
                    '- OR -',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                  const SizedBox(
                    height: 74,
                  ),

                  //Google Button****************************************************

                  GestureDetector(
                    child: Container(
                      // margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 2,
                        ),
                        color: colorProviderObj.backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            child: Image.asset('assets/images/google.png'),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Sign in with google',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      //sign_in(context);
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //Facebook Button****************************************************

                  GestureDetector(
                    child: Container(
                      //  margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[600],
                          width: 2,
                        ),
                        color: colorProviderObj.backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 60,
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            padding: EdgeInsets.all(8),
                            child: Image.asset('assets/images/facebook.png'),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Sign in with Facebook',
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      //sign_in(context);
                    },
                  ),
                  Expanded(child: Container()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.grey[600]),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
