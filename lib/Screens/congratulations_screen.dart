import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/saveTime_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CongratulationsScreen extends StatefulWidget {
  static const routeName = '/CongratulationsScreen';

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  String flag;

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
    flag = ModalRoute.of(context).settings.arguments as String;
    checkThemeMode(context);

    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Image.asset('assets/images/thumb.png'),
            const SizedBox(
              height: 80,
            ),
            Text(
              'Congratulations 👏',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 28,
                  color: colorProviderObj.textColor),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              flag == 'From create new password screen'
                  ? 'Congratulations, your account is \n            safely restored ✅'
                  : 'Proud to have you with us We \n  hope you enjoy with us ♥',
              style: TextStyle(fontSize: 16, color: colorProviderObj.textColor),
            ),
            const SizedBox(
              height: 82,
            ),
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 50,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'How to use it ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              onTap: () {
                // Navigator.pushNamed(
                //     context, CreateNewPasswordScreen.routeName);
              },
            ),
            const SizedBox(
              height: 7,
            ),
            GestureDetector(
              child: Text(
                'Skip',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: colorProviderObj.textColor),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SaveTimeScreen.routeName,
                );
              },
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
