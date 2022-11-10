// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/orderInfo.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/reportingProblemContainer_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryOrdersScreen extends StatefulWidget {
  static const routeName = '/HistoryOrdersScreen';

  @override
  State<HistoryOrdersScreen> createState() => _HistoryOrdersScreenState();
}

class _HistoryOrdersScreenState extends State<HistoryOrdersScreen> {
  // String orderDate;
  // String convertedTime;
  OrderInfo orderInfoDetails;

  bool loading;
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool showReportingCOntainer = false;

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
    orderInfoDetails = ModalRoute.of(context).settings.arguments as OrderInfo;
    checkThemeMode(context);

    return Scaffold(
        backgroundColor: colorProviderObj.backgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorProviderObj.textColor),
          backgroundColor: showReportingCOntainer == true
              ? Colors.black38
              : colorProviderObj.backgroundColor,
          title: Row(
            children: [
              const SizedBox(
                width: 85,
              ),
              Text(
                'Orders',
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
            GestureDetector(
              onTap: () {
                setState(() {
                  showReportingCOntainer = false;
                });
              },
              child: Container(
                color: showReportingCOntainer == true
                    ? Colors.black38
                    : colorProviderObj.backgroundColor,
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    //Date text*********************************************************
                    Container(
                      child: Row(
                        children: [
                          const Icon(Icons.date_range_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            orderInfoDetails.orderdate +
                                ',' +
                                orderInfoDetails.booktime,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: colorProviderObj.textColor),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    //Service and location title****************************************
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Service & Location',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: colorProviderObj.textColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Service and location data*****************************************

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/category.png'),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderInfoDetails.servicename,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: colorProviderObj.textColor),
                            ),
                            Text(
                              'One service includes many',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      orderInfoDetails.locationname,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey[600]),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //Cash title****************************************
                    Row(
                      children: [
                        Text(
                          'Cash',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: colorProviderObj.textColor),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //Cash data****************************************
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Serivice:',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: colorProviderObj.textColor),
                            ),
                            Text(
                              '${orderInfoDetails.price} LE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cash',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: colorProviderObj.textColor),
                            ),
                            Text(
                              '40 LE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: colorProviderObj.textColor),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Promo code',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.grey[500]),
                            ),
                            Text(
                              '30 LE',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 40,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 37.5,
                                  backgroundImage: AssetImage(
                                    'assets/images/omar.jpeg',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderInfoDetails.employeename,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: colorProviderObj.textColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  orderInfoDetails.employeephonenumber,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            CircleAvatar(
                              backgroundColor:
                                  colorProviderObj.backgroundDialogColor,
                              radius: 26,
                              child: Icon(
                                Icons.phone,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Expanded(child: Container()),

                    FlatButton(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.redAccent,
                          ),
                          color: colorProviderObj.backgroundColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height: 50,
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Report a problem',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          showReportingCOntainer = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (showReportingCOntainer == true)
              ReportingProblemContainerWidget()
          ],
        ));
  }
}
