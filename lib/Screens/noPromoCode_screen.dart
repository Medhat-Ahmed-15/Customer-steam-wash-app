// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoPromoCodeScreen extends StatefulWidget {
  static const routeName = '/NoPromoCodeScreen';

  @override
  State<NoPromoCodeScreen> createState() => _NoPromoCodeScreenState();
}

class _NoPromoCodeScreenState extends State<NoPromoCodeScreen> {
  // String orderDate;
  // String convertedTime;

  bool loading;
  ColorProvider colorProviderObj;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // orderDate =
      //     GeneralMethods.convertDateToDayInNumberMonthInText(widget.orderInfo);
      // orderTime = GeneralMethods.convertTimeTo12HFormat(widget.orderInfo);
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorProviderObj.textColor),
        backgroundColor: colorProviderObj.backgroundColor,
        title: Row(
          children: [
            const SizedBox(
              width: 55,
            ),
            Text(
              'Promo Code',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorProviderObj.textColor),
            ),
            //Expanded(child: Container()),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/noPromo.png'),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Oh we\'re sorry',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: colorProviderObj.textColor),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              'Sorry , there are no Promo Code\n      available at the moment',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
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
                    'Go Home',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
