// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/orderInfo.dart';
import 'package:customer_steam_wash_app/Widgets/order_widget.dart';
import 'package:flutter/material.dart';

class ScheduledOrdersTab extends StatefulWidget {
  // bool loading;
  // ScheduledOrdersTab(this.loading);
  @override
  State<ScheduledOrdersTab> createState() => _ScheduledOrdersTabState();
}

class _ScheduledOrdersTabState extends State<ScheduledOrdersTab> {
  List<OrderInfo> ordersList = [
    OrderInfo(
        id: '1',
        employeename: 'Omar Reda',
        employeephonenumber: '01282914670',
        orderdate: '7 Jan',
        booktime: '8.45 PM',
        servicename: 'Full wash',
        latitude: 2.0,
        longitude: 4.0,
        locationname: 'Smouha Club , Karm Alsham r....',
        price: '70'),
    OrderInfo(
        id: '2',
        employeename: 'Karim Hesham',
        employeephonenumber: '01282564670',
        orderdate: '10 Feb',
        booktime: '10.00 AM',
        servicename: 'In car wash',
        latitude: 2.0,
        longitude: 4.0,
        locationname: 'Sidi beashr , Mohamed Nagieb aft....',
        price: '3000')
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return OrderWidget(ordersList[index], 'scheduledOrders');
      },
      itemCount: ordersList.length,
    );
  }
}
