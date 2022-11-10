import 'dart:ui';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/noPackages_screen.dart';
import 'package:customer_steam_wash_app/Screens/noPromoCode_screen.dart';
import 'package:customer_steam_wash_app/Screens/packages_screen.dart';
import 'package:customer_steam_wash_app/Screens/promoCode_screen.dart';
import 'package:customer_steam_wash_app/Screens/settings_screen.dart';
import 'package:customer_steam_wash_app/Screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class MainDrawer extends StatefulWidget {
  Function switchToLogOutContainerWidget;
  MainDrawer(this.switchToLogOutContainerWidget);
  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
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

  void toggleSwitchNotification(bool) {}

  Widget buildListTile(IconData iconData, String text, BuildContext context,
      Function onTapFunction) {
    return Column(
      children: [
        FlatButton(
          onPressed: onTapFunction,
          child: ListTile(
              leading: Container(
                width: 35,
                height: 35,
                child: Icon(
                  iconData,
                  color: Colors.grey[600],
                ),
              ),
              title: Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
              trailing: text == 'Notifications'
                  ? Switch(
                      onChanged: toggleSwitchNotification,
                      value: true,
                      activeColor: Colors.white,
                      activeTrackColor: Theme.of(context).primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey[600],
                    )
                  : null),
        ),
        Divider(
          height: 30,
          color: colorProviderObj.backgroundDialogColor,
        )
      ],
    );
  }

  Future<void> checkThemeMode(BuildContext context) async {
    await Provider.of<ColorProvider>(context, listen: false)
        .checkThemeMethodInThisScreen();
  }

  @override
  Widget build(BuildContext context) {
    checkThemeMode(context);
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            height: 200,
            alignment: Alignment
                .centerLeft, //THIS CONTROLS HOW THE CHILD OF THE CONTAINER IS ALIGNNED
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  radius: 40,
                  child: const CircleAvatar(
                    radius: 37.5,
                    backgroundImage: AssetImage(
                      'assets/images/me.jpeg',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Medhat Ahmed',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Edit this profile',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: colorProviderObj.backgroundDialogColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //>>
                      buildListTile(
                          Icons.notifications_none, 'Notifications', context,
                          () {
                        // Navigator.pushReplacementNamed(
                        //     context, TabsScreen.routName);
                      }),
                      //>>
                      buildListTile(Icons.car_repair, 'Orders', context, () {
                        Navigator.pushNamed(context, TabsScreen.routName);
                      }),

                      //>>
                      buildListTile(
                          Icons.content_paste_outlined, 'Packages', context,
                          () {
                        //Navigator.pushNamed(context, PackagesScreen.routeName);
                        Navigator.pushNamed(
                            context, NoPackagesScreen.routeName);
                      }),

                      //>>
                      buildListTile(
                          Icons.local_offer_outlined, 'Promo Code', context,
                          () {
                        // Navigator.pushNamed(context, NoPromoCodeScreen.routeName);
                        // Navigator.pushNamed(context, PromoCodeScreen.routeName);
                      }),

                      //>>
                      buildListTile(Icons.settings, 'Settings', context, () {
                        Navigator.of(context)
                            .pushNamed(SettingsScreen.routeName);
                      }),
                      //>>
                      buildListTile(
                          Icons.headphones_outlined, 'Help center', context,
                          () {
                        // Navigator.of(context)
                        //     .pushReplacementNamed(MapScreen.routeName);
                      }),

                      //>>
                      buildListTile(Icons.exit_to_app, 'Signout', context, () {
                        Navigator.of(context).pop(context);
                        widget.switchToLogOutContainerWidget();

                        // Navigator.of(context).pushReplacementNamed(
                        //     '/'); //   always go to slash, slash nothing and that is the home route. Since you always go there, you ensure that this logic here in the main.dart file will always run whenever the logout button is pressed and since this always runs and since this home route is always loaded, we will always end up on the AuthScreen when we clear our data in the logout method of the auth provider. So simply add this additional line here and go to your home route to ensure that you never have unexpected behaviors when logging out.
                        // // Provider.of<AuthProvider>(context, listen: false)
                        // //     .SignOut();
                      }),
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}
