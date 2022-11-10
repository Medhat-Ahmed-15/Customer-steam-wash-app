// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpOrEmergencyContainerWidget extends StatefulWidget {
  String title;
  String Image;

  HelpOrEmergencyContainerWidget(this.title, this.Image);

  @override
  State<HelpOrEmergencyContainerWidget> createState() =>
      _HelpOrEmergencyContainerWidgetState();
}

class _HelpOrEmergencyContainerWidgetState
    extends State<HelpOrEmergencyContainerWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundDialogColor,
          border: Border.all(
            color: colorProviderObj.backgroundDialogColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 52,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.Image),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
