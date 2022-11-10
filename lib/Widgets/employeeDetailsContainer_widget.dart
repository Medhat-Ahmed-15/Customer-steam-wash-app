// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpOrEmergencyContainer_widget.dart.dart';

class EmployeeDetailsContainerWidget extends StatefulWidget {
  @override
  State<EmployeeDetailsContainerWidget> createState() =>
      _EmployeeDetailsContainerWidgetState();
}

class _EmployeeDetailsContainerWidgetState
    extends State<EmployeeDetailsContainerWidget> {
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
        height: 341.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 60, right: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Expanded(child: Container()),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 37,
                    child: const CircleAvatar(
                      radius: 35.5,
                      backgroundImage: AssetImage(
                        'assets/images/omar.jpeg',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Omar Reda',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                      Text(
                        'FIAT FIORINO CARGO',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colorProviderObj.textColor),
                      ),
                      Text(
                        '9618',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  CircleAvatar(
                    backgroundColor: colorProviderObj.backgroundDialogColor,
                    radius: 26,
                    child: Icon(
                      Icons.phone,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              Row(
                children: [
                  HelpOrEmergencyContainerWidget(
                      'Help center', 'assets/images/helpCenter.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  HelpOrEmergencyContainerWidget(
                      'Emergency', 'assets/images/emergency.png'),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50),
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
                      'Cancel Order',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
