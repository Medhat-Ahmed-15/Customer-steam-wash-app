// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Assistant/booking_methods.dart';
import 'package:customer_steam_wash_app/Models/availableTime.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/singleDayContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/singleTimeContainer_widget.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DateTimePickerContainerWidget extends StatefulWidget {
  Function switchToSearchContainerWidget;
  Function switchToCategoriesContainerWidget;
  DateTimePickerContainerWidget(this.switchToSearchContainerWidget,
      this.switchToCategoriesContainerWidget);
  @override
  State<DateTimePickerContainerWidget> createState() =>
      _DateTimePickerContainerWidgetState();
}

class _DateTimePickerContainerWidgetState
    extends State<DateTimePickerContainerWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool loaidng = false;
  List<AvailableTime> timeList = [];

  DateTime _currentDate;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _currentDate = DateTime.now();
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      setState(() {
        loaidng = true;
      });

      getAvailableTime().then((value) {
        timeList = value;
        setState(() {
          loaidng = false;
        });
      });
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
    final dates = <Widget>[];

    for (int i = 0; i < 30; i++) {
      final date = _currentDate.add(Duration(days: i));
      dates.add(SingleDayContainerWidget(
        date: date,
        index: i,
      ));
    }

    checkThemeMode(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 731.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorProviderObj.backgroundDialogColor,
                        border: Border.all(
                          color: colorProviderObj.backgroundDialogColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 64,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.asset('assets/images/currentLocation.png'),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    'Service address',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    pickedAddress == null
                                        ? 'No address picked'
                                        : pickedAddress.placeName,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 31,
                    ),
                    Column(
                      children: [
                        FlatButton(
                          child: Image.asset('assets/images/change.png'),
                          onPressed: widget.switchToSearchContainerWidget,
                        ),
                        Text(
                          'Change',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'When do you want the service?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: colorProviderObj.textColor),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Date',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colorProviderObj.textColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: dates,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Select Pick-up Time Slot',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: colorProviderObj.textColor),
                ),
                const SizedBox(
                  height: 11,
                ),
                loaidng == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(
                        height: 320,
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: timeList.length,
                          itemBuilder: (context, index) =>
                              SingleTimeContainerWidget(
                                  time: timeList[index],
                                  prevTime: index == 0
                                      ? timeList[index]
                                      : timeList[index - 1],
                                  index: index),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 7 / 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 25),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Book',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    widget.switchToCategoriesContainerWidget();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
