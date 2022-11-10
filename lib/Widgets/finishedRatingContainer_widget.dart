// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishedRatingContainerWidget extends StatefulWidget {
  Function switchToSearchContainerWidget;
  FinishedRatingContainerWidget(this.switchToSearchContainerWidget);
  @override
  State<FinishedRatingContainerWidget> createState() =>
      _FinishedRatingContainerWidgetState();
}

class _FinishedRatingContainerWidgetState
    extends State<FinishedRatingContainerWidget> {
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
        height: 380.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 34, right: 15),
          child: Column(
            children: [
              Image.asset('assets/images/rate.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Thank you for your review',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: colorProviderObj.textColor),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                'We always strive to make your service better',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
              const SizedBox(
                height: 20,
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
                      'Go home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
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
