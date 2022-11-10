// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutConatinerWidget extends StatefulWidget {
  Function switchToSearchContainerWidget,
      switchToReasonForLeavingContainerWidget;
  LogoutConatinerWidget(this.switchToSearchContainerWidget,
      this.switchToReasonForLeavingContainerWidget);
  @override
  State<LogoutConatinerWidget> createState() => _LogoutConatinerWidgetState();
}

class _LogoutConatinerWidgetState extends State<LogoutConatinerWidget> {
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
        height: 455.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 54, right: 15),
          child: Column(
            children: [
              Image.asset('assets/images/sorryEmoji.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Sign out ',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: colorProviderObj.textColor),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'Are you sure? You will be logged out',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 50,
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sign out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  widget.switchToReasonForLeavingContainerWidget();
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
                onTap: () {
                  widget.switchToSearchContainerWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
