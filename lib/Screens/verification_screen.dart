import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:customer_steam_wash_app/Assistant/auth_methods.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/congratulations_screen.dart';
import 'package:customer_steam_wash_app/Screens/createNewPassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:otp_text_field/otp_text_field.dart';

class VerificationScreen extends StatefulWidget {
  static const routeName = '/VerificationScreen';

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool loading = false;
  String flag;
  String _pin;

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: colorProviderObj.backgroundDialogColor,
        textColor: colorProviderObj.textColor,
        fontSize: 14.0);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
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
    flag = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Verification Code ✅',
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
                'You need to enter the 4-digit code we sent to your phone number',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600]),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            OTPTextField(
              length: 4,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: colorProviderObj.backgroundDialogColor,
              ),
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 55,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 12,
              style: TextStyle(fontSize: 15),
              onChanged: (pin) {
                print("Changed: " + pin);
              },
              onCompleted: (pin) async {
                _pin = pin;
                try {
                  final result = await checkVerificationCOde(pin);

                  if (result == true) {
                    Navigator.pushNamed(
                        context, CongratulationsScreen.routeName,
                        arguments: 'From verification Screen');
                  } else {
                    showToast('Invalid code ❗');
                  }
                } on SocketException catch (error) {
                  showToast('Please check your internet connection');
                } catch (error) {
                  showToast('Error.could not authenticate you.');
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have code ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey[600]),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'resend SMS',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.grey[600]),
                  ),
                ),
                Expanded(child: Container()),
                Text(
                  '0:20',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey[600]),
                ),
              ],
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
              onTap: () async {
                if (flag == 'From complete profile screen') {
                  setState(() {
                    loading = true;
                  });
                  try {
                    final result = await checkVerificationCOde(_pin);

                    if (result == true) {
                      Navigator.pushNamed(
                          context, CongratulationsScreen.routeName,
                          arguments: 'From verification Screen');
                    } else {
                      showToast('Invalid code ❗');
                    }
                  } on SocketException catch (error) {
                    showToast('Please check your internet connection');
                  } catch (error) {
                    showToast('Error.could not authenticate you.');
                  }

                  setState(() {
                    loading = false;
                  });

                  Navigator.pushNamed(context, CongratulationsScreen.routeName,
                      arguments: 'From verification Screen');
                } else if (flag == 'From forgot your password screen') {
                  Navigator.pushNamed(
                      context, CreateNewPasswordScreen.routeName);
                }
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
