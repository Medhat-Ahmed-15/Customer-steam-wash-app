// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/orderInfo.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/reportingProblemContainer_widget.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PickedPackageScreen extends StatefulWidget {
  static const routeName = '/PickedPackageScreen';

  @override
  State<PickedPackageScreen> createState() => _PickedPackageScreenState();
}

class _PickedPackageScreenState extends State<PickedPackageScreen> {
  // String orderDate;
  // String convertedTime;

  bool loading;
  ColorProvider colorProviderObj;
  bool _isInit = true;

  String categoryName;
  String categoryDescription;
  String categoryPrice;
  String categoryIncludes;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // orderDate =
      //     GeneralMethods.convertDateToDayInNumberMonthInText(widget.orderInfo);
      // orderTime = GeneralMethods.convertTimeTo12HFormat(widget.orderInfo);
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      if (pickedCategory == 'Full wash') {
        categoryName = 'Full wash';
        categoryDescription = 'One service includes many';
        categoryPrice = '70';
        categoryIncludes =
            'full steam cleaning , car interior vacuum, rear trunk vacuum cleaner, car polishing, windshield wipe';
      } else if (pickedCategory == 'Half wash') {
        categoryName = 'Half wash';
        categoryDescription = 'More service included it';
        categoryPrice = '120';
        categoryIncludes =
            'full steam cleaning , car interior vacuum, rear trunk';
      } else if (pickedCategory == 'in-out wash') {
        categoryName = 'in-out wash';
        categoryDescription = 'One service includes many';
        categoryPrice = '300';
        categoryIncludes =
            'full steam cleaning , car interior vacuum, rear trunk';
      }
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
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                              categoryName,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: colorProviderObj.textColor),
                            ),
                            Text(
                              categoryDescription,
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
                              ' $categoryPrice\nEGP',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (pickedCategory == 'Full wash' ||
                            pickedCategory == 'Half wash')
                          Image.asset('assets/images/1.png'),
                        if (pickedCategory == 'Full wash' ||
                            pickedCategory == 'Half wash')
                          Image.asset('assets/images/2.png'),
                        if (pickedCategory == 'Full wash')
                          Image.asset('assets/images/3.png'),
                        if (pickedCategory == 'Full wash')
                          Image.asset('assets/images/4.png'),
                        if (pickedCategory == 'Full wash' ||
                            pickedCategory == 'Half wash')
                          Image.asset('assets/images/5.png'),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'The service includes',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: colorProviderObj.textColor),
                        ),
                        Text(
                          categoryIncludes,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    FlatButton(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 50,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Book',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),

                    Text(
                      'Book a later date',
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600]),
                    ),

                    //Expanded(child: Container())
                  ],
                ),
              ),
      ),
    );
  }
}
