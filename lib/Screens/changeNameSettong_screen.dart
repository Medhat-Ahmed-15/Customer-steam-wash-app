// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNameSettingScreen extends StatefulWidget {
  static const routeName = '/ChangeNameSettingScreen';

  @override
  State<ChangeNameSettingScreen> createState() =>
      _ChangeNameSettingScreenState();
}

class _ChangeNameSettingScreenState extends State<ChangeNameSettingScreen> {
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
              width: 85,
            ),
            Text(
              'Settings',
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
          children: [
            TextField(
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                labelStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                labelText: 'Name',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            FlatButton(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                height: 50,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
