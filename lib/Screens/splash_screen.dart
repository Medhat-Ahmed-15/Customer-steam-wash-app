import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  Future<void> checkThemeMode(BuildContext context) async {
    await Provider.of<ColorProvider>(context, listen: false)
        .checkThemeMethodInThisScreen();
  }

  @override
  Widget build(BuildContext context) {
    ColorProvider colorProviderObj =
        Provider.of<ColorProvider>(context, listen: true);
    checkThemeMode(context);

    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: const EdgeInsets.all(70),
          child: Center(
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
