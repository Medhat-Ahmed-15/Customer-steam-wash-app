// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Assistant/booking_methods.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PickedCategoryContainerWidget extends StatefulWidget {
  Function switchToSuccessfullBookingContainer;

  PickedCategoryContainerWidget(this.switchToSuccessfullBookingContainer);
  @override
  State<PickedCategoryContainerWidget> createState() =>
      _PickedCategoryContainerWidgetState();
}

class _PickedCategoryContainerWidgetState
    extends State<PickedCategoryContainerWidget> {
  String categoryName;
  String categoryDescription;
  String categoryPrice;
  String categoryIncludes;
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool loading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      if (pickedCategory.name == 'Full Wash') {
        categoryName = pickedCategory.name;
        categoryDescription = pickedCategory.description;
        categoryPrice = pickedCategory.price;
        categoryIncludes = pickedCategory.includes;
      } else if (pickedCategory.name == 'Half Wash') {
        categoryName = pickedCategory.name;
        categoryDescription = pickedCategory.description;
        categoryPrice = pickedCategory.price;
        categoryIncludes = pickedCategory.includes;
      } else if (pickedCategory.name == 'In-Out Wash') {
        categoryName = pickedCategory.name;
        categoryDescription = pickedCategory.description;
        categoryPrice = pickedCategory.price;
        categoryIncludes = pickedCategory.includes;
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 408.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 48, right: 15),
          child: SingleChildScrollView(
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
                        Container(
                          width: 170,
                          child: Text(
                            categoryDescription,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600]),
                          ),
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
                    if (pickedCategory.name == 'Full Wash' ||
                        pickedCategory.name == 'Half Wash')
                      Image.asset('assets/images/1.png'),
                    if (pickedCategory.name == 'Full Wash' ||
                        pickedCategory.name == 'Half Wash')
                      Image.asset('assets/images/2.png'),
                    if (pickedCategory.name == 'Full Wash')
                      Image.asset('assets/images/3.png'),
                    if (pickedCategory.name == 'Full Wash')
                      Image.asset('assets/images/4.png'),
                    if (pickedCategory.name == 'Full Wash' ||
                        pickedCategory.name == 'Half Wash')
                      Image.asset('assets/images/5.png'),
                  ],
                ),

                const SizedBox(
                  height: 20,
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
                  height: 15,
                ),

                Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorProviderObj.backgroundDialogColor,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  height: 48,
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_money_sharp,
                          color: colorProviderObj.textColor,
                        ),
                        Text(
                          'Total cost',
                          style: TextStyle(
                            color: colorProviderObj.textColor,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(child: Container()),
                        Text(
                          '${int.parse(categoryPrice) + 20} EGP',
                          style: TextStyle(
                            color: colorProviderObj.textColor,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    child: loading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Align(
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
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });

                    try {
                      final response = await bookOrderLater();

                      if (response == true) {
                        widget.switchToSuccessfullBookingContainer();
                      } else {
                        Fluttertoast.showToast(
                            msg: 'error',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 5,
                            backgroundColor:
                                colorProviderObj.backgroundDialogColor,
                            textColor: colorProviderObj.textColor,
                            fontSize: 14.0);
                      }
                    } catch (errror) {
                      Fluttertoast.showToast(
                          msg: 'error',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor:
                              colorProviderObj.backgroundDialogColor,
                          textColor: colorProviderObj.textColor,
                          fontSize: 14.0);
                    }

                    setState(() {
                      loading = false;
                    });
                  },
                ),
                //Expanded(child: Container())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
