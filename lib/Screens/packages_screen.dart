// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/pickedPackageScreen.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackagesScreen extends StatefulWidget {
  static const routeName = '/PackagesScreen';

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
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
              'Packages',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: colorProviderObj.textColor),
            ),
            //Expanded(child: Container()),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 48, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // pickedCategory = 'Full wash';
                  Navigator.of(context)
                      .pushNamed(PickedPackageScreen.routeName);
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/category.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Full wash',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorProviderObj.textColor),
                        ),
                        Text(
                          'One service includes many',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 56.0,
                      width: 56,
                      decoration: BoxDecoration(
                        color: colorProviderObj.backgroundDialogColor,
                        border: Border.all(
                          color: colorProviderObj.backgroundDialogColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          ' 70\nEGP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  // pickedCategory = 'Half wash';
                  Navigator.of(context)
                      .pushNamed(PickedPackageScreen.routeName);
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/category.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Half wash',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorProviderObj.textColor),
                        ),
                        Text(
                          'More service included it',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 56.0,
                      width: 56,
                      decoration: BoxDecoration(
                        color: colorProviderObj.backgroundDialogColor,
                        border: Border.all(
                          color: colorProviderObj.backgroundDialogColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          ' 120\nEGP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  // pickedCategory = 'in-out wash';
                  Navigator.of(context)
                      .pushNamed(PickedPackageScreen.routeName);
                },
                child: Row(
                  children: [
                    Image.asset('assets/images/category.png'),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'in-out wash',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colorProviderObj.textColor),
                        ),
                        Text(
                          'One service includes many',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 56.0,
                      width: 56,
                      decoration: BoxDecoration(
                        color: colorProviderObj.backgroundDialogColor,
                        border: Border.all(
                          color: colorProviderObj.backgroundDialogColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          ' 300\nEGP',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
