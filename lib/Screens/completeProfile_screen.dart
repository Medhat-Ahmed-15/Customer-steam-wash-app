// ignore_for_file: file_names

import 'dart:io';

import 'package:customer_steam_wash_app/Assistant/auth_methods.dart';
import 'package:customer_steam_wash_app/Models/registerCustomer_httpException.dart';
import 'package:customer_steam_wash_app/Models/sms_httpException.dart';
import 'package:customer_steam_wash_app/Providers/auth_provider.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/verification_screen.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompleteProfileScreen extends StatefulWidget {
  static const routeName = '/CompleteProfileScreen';
  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  ColorProvider colorProviderObj;
  AuthProvider authProvider;

  bool _isInit = true;
  bool loading = false;
  bool showErrorText = false;

  Color nameBorderColor;
  Color nameFillColor;
  Color nameIconColor;
  Color nameInputTextColor;

  Color phoneNumberBorderColor;
  Color phoneNumberFillColor;
  Color phoneNumberIconColor;
  Color phoneNumberInputTextColor;

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  String errortext;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
      authProvider = Provider.of<AuthProvider>(context, listen: true);

      nameBorderColor = colorProviderObj.backgroundDialogColor;
      nameFillColor = colorProviderObj.backgroundDialogColor;
      nameIconColor = Colors.grey[600];
      nameInputTextColor = colorProviderObj.textColor;

      phoneNumberBorderColor = colorProviderObj.backgroundDialogColor;
      phoneNumberFillColor = colorProviderObj.backgroundDialogColor;
      phoneNumberIconColor = Colors.grey[600];
      phoneNumberInputTextColor = colorProviderObj.textColor;
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
          // ignore: deprecated_member_use
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
      final validPhone = await checkValidPhone(_phoneController.text.trim());

      if (validPhone != true) {
        setState(() {
          phoneNumberBorderColor = Colors.red;
          phoneNumberIconColor = Colors.red;
          phoneNumberInputTextColor = Colors.red;

          showErrorText = true;

          errortext = "Invalid phone number ❗";
          loading = false;
        });

        return;
      }

      userName = _nameController.text.trim();
      userPhone = _phoneController.text.trim();

      await authProvider.registerCustomer();

      Navigator.pushNamed(context, VerificationScreen.routeName,
          arguments: 'From complete profile screen');
    } on SocketException catch (error) {
      showErrorText = true;
      errortext = 'Please check your internet connection';
    } on registerCustomerHttpException catch (error) {
      showErrorText = true;
      errortext = error.toString();
    } on SMSHttpException catch (error) {
      showErrorText = true;
      errortext = error.toString();
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
        margin: const EdgeInsets.all(30),
        child: Column(
          // mainAxisAlignment: Main,
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Complete your profile 🤙',
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
                'We are almost done...let\'s go🚀',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600]),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: colorProviderObj.backgroundColor,
                  radius: 113,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 100,
                    child: CircleAvatar(
                      radius: 98,
                      backgroundColor: colorProviderObj.backgroundColor,
                      backgroundImage: const AssetImage(
                        'assets/images/me.jpeg',
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 186,
                  bottom: 0,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 20,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: colorProviderObj.backgroundColor,
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),
            // CircleAvatar(
            //   backgroundColor: Theme.of(context).primaryColor,
            //   radius: 100,
            //   child: CircleAvatar(
            //     radius: 98,
            //     backgroundColor: colorProviderObj.backgroundColor,
            //     child: FlatButton(
            //       onPressed: () {},
            //       child: CircleAvatar(
            //         backgroundColor: Theme.of(context).primaryColor,
            //         radius: 20,
            //         child: CircleAvatar(
            //           radius: 19,
            //           backgroundColor: colorProviderObj.backgroundColor,
            //           child: Icon(
            //             Icons.camera_alt_outlined,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            //Expanded(child: Container()),

            //Name textfield************************************************************************************

            Container(
              decoration: BoxDecoration(
                color: nameFillColor,
                border: Border.all(
                  color: nameBorderColor,
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
                      Icons.person_outline_outlined,
                      color: nameIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          nameInputTextColor = colorProviderObj.textColor;
                          nameFillColor = colorProviderObj.backgroundColor;
                          nameBorderColor = Theme.of(context).primaryColor;
                          nameIconColor = Theme.of(context).primaryColor;
                        },
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: nameInputTextColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: 'Name',
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
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
            //phone textfield************************************************************************************

            Container(
              decoration: BoxDecoration(
                color: phoneNumberFillColor,
                border: Border.all(
                  color: phoneNumberBorderColor,
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
                      Icons.phone_outlined,
                      color: phoneNumberIconColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        onTap: () {
                          phoneNumberInputTextColor =
                              colorProviderObj.textColor;
                          phoneNumberFillColor =
                              colorProviderObj.backgroundColor;
                          phoneNumberBorderColor =
                              Theme.of(context).primaryColor;
                          phoneNumberIconColor = Theme.of(context).primaryColor;
                        },
                        controller: _phoneController,
                        keyboardType: TextInputType.text,
                        cursorColor: Theme.of(context).primaryColor,
                        style: TextStyle(
                          color: phoneNumberInputTextColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(8),
                          hintText: 'Phone',
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
            //error text
            showErrorText == true
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$errortext',
                      style: const TextStyle(color: Colors.red, fontSize: 15),
                    ),
                  )
                : SizedBox(height: 0),

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
                          'Sign up',
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
