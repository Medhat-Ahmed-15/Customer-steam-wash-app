// ignore_for_file: file_names

import 'dart:ui';

import 'package:customer_steam_wash_app/Models/orderInfo.dart';
import 'package:customer_steam_wash_app/Models/promoCodeDetails.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/historyOrders_screen.dart';
import 'package:customer_steam_wash_app/Screens/scheduledOrders_screen.dart';
import 'package:customer_steam_wash_app/global_variables.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SinglePromoCodeWidget extends StatefulWidget {
  PromoCodeDetails promoCodeDetails;
  bool showContainer;
  Function showUsePromoCodeContainerWidget;
  SinglePromoCodeWidget(this.promoCodeDetails, this.showContainer,
      this.showUsePromoCodeContainerWidget);

  @override
  State<SinglePromoCodeWidget> createState() => _SinglePromoCodeWidgetState();
}

class _SinglePromoCodeWidgetState extends State<SinglePromoCodeWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  //String orderDate;
  //String orderTime;

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
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: widget.showContainer == true
                      ? Colors.black38
                      : colorProviderObj.backgroundDialogColor,
                  child: Image.asset('assets/images/promoCodeIcon.png'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      widget.promoCodeDetails.title,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: colorProviderObj.textColor),
                    ),
                    Text(
                      widget.promoCodeDetails.subTitle,
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
                    color: widget.showContainer == true
                        ? Colors.black38
                        : colorProviderObj.backgroundDialogColor,
                    border: Border.all(
                      color: widget.showContainer == true
                          ? Colors.black38
                          : colorProviderObj.backgroundDialogColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      ' ${widget.promoCodeDetails.price}\nEGP',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: widget.showContainer == true
                              ? Colors.black38
                              : Theme.of(context).primaryColor),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider()
          ],
        ),
      ),
      onPressed: () {
        print('entered');
        pickedPromoCode = widget.promoCodeDetails;
        widget.showUsePromoCodeContainerWidget();
      },
    );
  }
}
