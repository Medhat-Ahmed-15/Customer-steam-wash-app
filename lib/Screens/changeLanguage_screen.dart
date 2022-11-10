// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeLanguageScreen extends StatefulWidget {
  static const routeName = '/ChangeLanguageScreen';

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  // String orderDate;
  // String convertedTime;

  bool loading;
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool switchLanguage = true;

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
              'Language',
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
        margin: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            FlatButton(
              child: Container(
                decoration: BoxDecoration(
                  color: switchLanguage == true
                      ? Theme.of(context).primaryColor
                      : colorProviderObj.backgroundDialogColor,
                  border: Border.all(
                    color: switchLanguage == true
                        ? Theme.of(context).primaryColor
                        : colorProviderObj.backgroundDialogColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(
                      'English',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: switchLanguage == true
                              ? Colors.white
                              : Colors.grey[600]),
                    ),
                    trailing: switchLanguage == false
                        ? null
                        : FlatButton(
                            minWidth: 1,
                            onPressed: () {},
                            child: Icon(Icons.check_circle_outline,
                                size: 30,
                                color: switchLanguage == true
                                    ? Colors.white
                                    : Colors.grey[600]),
                          ),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  switchLanguage = !switchLanguage;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
              child: Container(
                decoration: BoxDecoration(
                  color: switchLanguage == false
                      ? Theme.of(context).primaryColor
                      : colorProviderObj.backgroundDialogColor,
                  border: Border.all(
                    color: switchLanguage == false
                        ? Theme.of(context).primaryColor
                        : colorProviderObj.backgroundDialogColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(
                      'Arabic',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: switchLanguage == false
                              ? Colors.white
                              : Colors.grey[600]),
                    ),
                    trailing: switchLanguage == true
                        ? null
                        : FlatButton(
                            minWidth: 1,
                            onPressed: () {},
                            child: Icon(Icons.check_circle_outline,
                                size: 30,
                                color: switchLanguage == false
                                    ? Colors.white
                                    : Colors.grey[600]),
                          ),
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  switchLanguage = !switchLanguage;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
