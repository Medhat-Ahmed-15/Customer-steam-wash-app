// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Screens/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/ForgotPasswordScreen';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Color emailBorderColor;
  Color emailFillColor;
  Color emailIconColor;
  Color emailInputTextColor;

  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool loading = false;

  final _emailAddressController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      emailBorderColor = colorProviderObj.backgroundDialogColor;
      emailFillColor = colorProviderObj.backgroundDialogColor;
      emailIconColor = Colors.grey[600];
      emailInputTextColor = colorProviderObj.textColor;
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
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Forgot your password 😥',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: colorProviderObj.textColor),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'We need your email adress so we can send you the password reset code.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
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
            const SizedBox(
              height: 30,
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
                Navigator.pushNamed(context, VerificationScreen.routeName,
                    arguments: 'From forgot your password screen');
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
