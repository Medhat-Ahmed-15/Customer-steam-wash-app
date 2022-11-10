// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/promoCodeDetails.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/congratulationsContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/singlePromoCode_widget.dart';
import 'package:customer_steam_wash_app/Widgets/usePromoCodeWidget.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PromoCodeScreen extends StatefulWidget {
  static const routeName = '/PromoCodeScreen';

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  // String orderDate;
  // String convertedTime;

  bool loading;
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool showContainer = false;
  String containerName = '';

  List<PromoCodeDetails> promoCodesList = [
    PromoCodeDetails(
      '20',
      'for new user\'s up to 50%',
      'ALEX 270',
    ),
    PromoCodeDetails(
      '30 ',
      ' up to 75%',
      'Just one wash',
    )
  ];

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

  void showUsePromoCodeContainerWidget() {
    setState(() {
      containerName = 'Use promo code';
      showContainer = true;
    });
  }

  void showCongratulationsContainerWidget() {
    setState(() {
      containerName = 'Congratulations';
      showContainer = true;
    });
  }

  void removeContainer() {
    setState(() {
      showContainer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    checkThemeMode(context);

    return Scaffold(
      backgroundColor: colorProviderObj.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorProviderObj.textColor),
        backgroundColor: showContainer == true
            ? Colors.black38
            : colorProviderObj.backgroundColor,
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
      body: Stack(
        children: [
          Container(
            color: showContainer == true
                ? Colors.black38
                : colorProviderObj.backgroundColor,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return SinglePromoCodeWidget(promoCodesList[index],
                    showContainer, showUsePromoCodeContainerWidget);
              },
              itemCount: promoCodesList.length,
            ),
          ),
          if (showContainer == true && containerName == 'Use promo code')
            UsePromoCodeContainerWidget(removeContainer, pickedPromoCode,
                showCongratulationsContainerWidget),
          if (showContainer == true && containerName == 'Congratulations')
            CongratulationsContainerWidget()
        ],
      ),
    );
  }
}
