// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/changeLanguage_screen.dart';
import 'package:customer_steam_wash_app/Screens/changeNameSettong_screen.dart';
import 'package:customer_steam_wash_app/Screens/changePhoneSetting_screen.dart';
import 'package:customer_steam_wash_app/Screens/map_screen.dart';
import 'package:customer_steam_wash_app/Screens/termsAndConditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/SettingsScreen';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  void toggleSwitchNotification(bool) {}

  @override
  Widget build(BuildContext context) {
    checkThemeMode(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 36.0,
                  backgroundColor: colorProviderObj.backgroundDialogColor,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/me.jpeg'),
                    radius: 26.0,
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.grey[600]),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Medhat Ahmed',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                          color: colorProviderObj.textColor),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(ChangeNameSettingScreen.routeName);
                  },
                  child: Icon(
                    Icons.edit_outlined,
                    color: colorProviderObj.textColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                    leading: Text(
                      'Notifications',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.grey[600]),
                    ),
                    trailing: Switch(
                      onChanged: toggleSwitchNotification,
                      value: true,
                      activeColor: Colors.white,
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[600],
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Phone number',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        '0109 819 0871',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  trailing: FlatButton(
                    minWidth: 1,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ChangePhoneSettingScreen.routeName);
                    },
                    child: Icon(Icons.change_circle_outlined,
                        size: 30, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'City',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        'Alexandria',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Text(
                    'Language',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Colors.grey[600]),
                  ),
                  trailing: FlatButton(
                    minWidth: 1,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ChangeLanguageScreen.routeName);
                    },
                    child: Icon(Icons.navigate_next,
                        size: 30, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListTile(
                  leading: Text(
                    'Terms & Conditionsage',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                        color: Colors.grey[600]),
                  ),
                  trailing: FlatButton(
                    minWidth: 1,
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(TermsAndConditionsScreen.routeName);
                    },
                    child: Icon(Icons.navigate_next,
                        size: 30, color: Colors.grey[600]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
