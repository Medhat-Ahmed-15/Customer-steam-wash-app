// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';

class EasyToUseScreen extends StatefulWidget {
  static const routeName = '/EasyToUseScreen';

  @override
  State<EasyToUseScreen> createState() => _EasyToUseScreenState();
}

class _EasyToUseScreenState extends State<EasyToUseScreen> {
  ColorProvider colorProviderObj;
  bool _isInit = true;

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

    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            left: 330,
            right: 0,
            top: 60,
            bottom: 0,
            child: GestureDetector(
              child: Text(
                'Skip',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).primaryColor),
              ),
              onTap: () {
                // Navigator.pushNamed(
                //   context,
                //   SaveTimeScreen.routeName,
                // );
              },
            ),
          ),
          Positioned(
            left: 300,
            right: 0,
            top: 0,
            bottom: 470,
            child: Image.asset('assets/images/patternOnBoarding6.png'),
          ),
          Positioned(
            left: 0,
            right: 330,
            top: 100,
            bottom: 0,
            child: Image.asset('assets/images/patternOnBoarding5.png'),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 200,
            child: Image.asset('assets/images/easyToUse.png'),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 350,
              child: Column(
                children: [
                  Text(
                    'Easy to use 🤙',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: colorProviderObj.textColor),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    '  A great and modern user\ninterface designed to make \n your experience better 😌',
                    style: TextStyle(
                        fontSize: 16, color: colorProviderObj.textColor),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      height: 50,
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Let\'s get started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, MapScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
