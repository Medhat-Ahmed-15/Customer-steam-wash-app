// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleDayContainerWidget extends StatefulWidget {
  int index;
  DateTime date;

  SingleDayContainerWidget({this.date, this.index});

  @override
  State<SingleDayContainerWidget> createState() =>
      _SingleDayContainerWidgetState();
}

class _SingleDayContainerWidgetState extends State<SingleDayContainerWidget> {
  ColorProvider colorProviderObj;

  bool _isInit = true;
  bool clicked = false;

  String dayName;
  String dayNumber;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
      dayName = DateFormat.E().format(widget.date);
      dayNumber = DateFormat.d().format(widget.date);
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
      //minWidth: 1,
      padding: EdgeInsets.all(0),
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
        height: 60,
        width: dayName.length == 3 ? 75 : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.index == 0
                      ? 'Today'
                      : widget.index == 1
                          ? 'Tomorrow'
                          : dayName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: clicked == true
                          ? Colors.white
                          : colorProviderObj.textColor),
                ),
              ),
              Expanded(
                child: Text(
                  dayNumber,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: clicked == true
                          ? Colors.white
                          : colorProviderObj.textColor),
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        if (clicked == true) {
          pickedDay.clear();
          clicked = !clicked;
        } else if (clicked == false && pickedDay.isEmpty) {
          pickedDay.add(DateFormat('yyyy-MM-dd').format(widget.date));
          clicked = !clicked;
        } else {
          Fluttertoast.showToast(
              msg: 'Only one day must be picked ☝',
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
