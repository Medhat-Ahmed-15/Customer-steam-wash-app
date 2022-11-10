import 'dart:ui';

import 'package:customer_steam_wash_app/Models/orderInfo.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Screens/historyOrders_screen.dart';
import 'package:customer_steam_wash_app/Screens/scheduledOrders_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  OrderInfo orderInfo;
  String flag;
  OrderWidget(this.orderInfo, this.flag);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 130,
              color: colorProviderObj.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderInfo.servicename,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.orderInfo.locationname,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.date_range_outlined),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.orderInfo.orderdate},${widget.orderInfo.booktime}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Expanded(child: Container()),
                      Text(
                        "${widget.orderInfo.price} LE",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider()
          ],
        ),
      ),
      onPressed: () {
        if (widget.flag == 'historyOrders') {
          print('HistoryOrders');
          Navigator.pushNamed(context, HistoryOrdersScreen.routeName,
              arguments: widget.orderInfo);
        }
        if (widget.flag == 'scheduledOrders') {
          print('ScheduledOrders');
          Navigator.pushNamed(context, ScheduledOrdersScreen.routeName,
              arguments: widget.orderInfo);
        }
      },
    );
  }
}
