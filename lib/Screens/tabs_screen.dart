//import 'dart:io';

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/main_drawer.dart';
import 'package:customer_steam_wash_app/tabs/historyOrders_tab.dart';
import 'package:customer_steam_wash_app/tabs/scheduledOrders_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  static final routName = '/tabs_screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  bool _isInit = true;
  ColorProvider colorProviderObj;

  @override
  void didChangeDependencies() {
    if (_isInit) {
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
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
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
                'Orders',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: colorProviderObj.textColor),
              ),
              //Expanded(child: Container()),
            ],
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            isScrollable: true,
            labelPadding: const EdgeInsets.only(left: 65, right: 65),
            labelStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            unselectedLabelColor: colorProviderObj.textColor,
            tabs: const [
              Tab(
                text: 'History',
              ),
              Tab(
                text: 'Scheduled',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            HistoryOrdersTab(),
            ScheduledOrdersTab(),
          ],
        ),
      ),
    );
  }
}
