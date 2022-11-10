// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/availableTime.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';

class SingleTimeContainerWidget extends StatefulWidget {
  AvailableTime time;
  AvailableTime prevTime;
  int index;
  SingleTimeContainerWidget({this.time, this.prevTime, this.index});

  @override
  State<SingleTimeContainerWidget> createState() =>
      _SingleTimeContainerWidgetState();
}

class _SingleTimeContainerWidgetState extends State<SingleTimeContainerWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool clicked = false;
  String timeIn12hFormat;
  String prevTimeIn12hFormat;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
      timeIn12hFormat = DateFormat("h:mm a").format(DateFormat("hh:mm").parse(
          widget.time.booktime.split(':')[0] +
              ":" +
              widget.time.booktime.split(':')[1]));

      prevTimeIn12hFormat = DateFormat("h:mm a").format(DateFormat("hh:mm")
          .parse(widget.prevTime.booktime.split(':')[0] +
              ":" +
              widget.prevTime.booktime.split(':')[1]));
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
      child: Container(
        decoration: BoxDecoration(
          color: clicked == true
              ? Theme.of(context).primaryColor
              : colorProviderObj.backgroundColor,
          border: Border.all(
            color: clicked == true
                ? Theme.of(context).primaryColor
                : colorProviderObj.textColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        height: 50,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            widget.index == 0
                ? timeIn12hFormat
                : '$prevTimeIn12hFormat - $timeIn12hFormat',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color:
                  clicked == true ? Colors.white : colorProviderObj.textColor,
            ),
          ),
        ),
      ),
      onPressed: () {
        if (clicked == true) {
          pickedTime.clear();
          clicked = !clicked;
        } else if (clicked == false && pickedTime.isEmpty) {
          pickedTime.add(widget.time.booktime);
          clicked = !clicked;
        } else {
          Fluttertoast.showToast(
              msg: 'Only one time slot must be picked ☝',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: colorProviderObj.backgroundDialogColor,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        setState(() {});
      },
    );
  }
}
