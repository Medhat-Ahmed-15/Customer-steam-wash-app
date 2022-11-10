// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Screens/congratulations_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  static const routeName = '/CreateNewPasswordScreen';

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  ColorProvider colorProviderObj;

  bool _isInit = true;
  bool loading = false;
  bool showErrorText = false;
  bool hidePasswordText = true;
  bool hideConfirmPasswordText = true;

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

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

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
                'Create New Password 🔒',
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
                'You can create a new password, please dont forget it too.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              height: 30,
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
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '❗ Password doesn\'t match',
                      style: TextStyle(color: Colors.red, fontSize: 16),
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
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, CongratulationsScreen.routeName,
                    arguments: 'From create new password screen');
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
