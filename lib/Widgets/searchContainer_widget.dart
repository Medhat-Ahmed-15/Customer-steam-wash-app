// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Assistant/address_methods.dart';
import 'package:customer_steam_wash_app/Models/placePridictions.dart';
import 'package:customer_steam_wash_app/Models/prevLocations.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/prevLocationsUsedTile.dart';
import 'package:customer_steam_wash_app/Widgets/predictionTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchContainerWidget extends StatefulWidget {
  Function switchToDateTimeContainerWidget;
  SearchContainerWidget(this.switchToDateTimeContainerWidget);
  @override
  State<SearchContainerWidget> createState() => _SearchContainerWidgetState();
}

class _SearchContainerWidgetState extends State<SearchContainerWidget> {
  ColorProvider colorProviderObj;

  Color searchBorderColor;
  Color searchFillColor;
  Color dateTimeFillColor;
  Color searchIconColor;
  Color searchInputTextColor;

  final _searchController = TextEditingController();

  bool _isInit = true;
  bool loadingAdresses = false;
  bool loadingPrevLoc = false;

  List<PlacePredictions> placePredictionList = [];

  List<PrevLocations> prevLoc = [];

  String dropdownValue = 'Now';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        loadingPrevLoc = true;
      });

      getCustomerPrevLocations().then((value) {
        prevLoc = value;
        setState(() {
          loadingPrevLoc = false;
        });
      });

      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      searchBorderColor = colorProviderObj.backgroundDialogColor;
      searchFillColor = colorProviderObj.backgroundDialogColor;

      searchIconColor = Colors.grey[600];
      searchInputTextColor = colorProviderObj.textColor;

      dateTimeFillColor = colorProviderObj.backgroundDialogColor;
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
        height: 282.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 240,
                        decoration: BoxDecoration(
                          color: searchFillColor,
                          border: Border.all(
                            color: searchBorderColor,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        height: 60,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (val) async {
                              setState(() {
                                loadingAdresses = true;
                              });
                              List<PlacePredictions>
                                  returnedListFromAddressContainer =
                                  await findNearByPlaces(val);

                              setState(() {
                                loadingAdresses = false;
                                placePredictionList =
                                    returnedListFromAddressContainer;
                              });
                            },
                            onTap: () {
                              searchInputTextColor = colorProviderObj.textColor;
                              searchFillColor =
                                  colorProviderObj.backgroundColor;
                              searchBorderColor =
                                  Theme.of(context).primaryColor;
                              searchIconColor = Theme.of(context).primaryColor;
                            },
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            cursorColor: Theme.of(context).primaryColor,
                            style: TextStyle(
                              color: searchInputTextColor,
                            ),
                            decoration: InputDecoration(
                              icon: Image.asset(
                                  'assets/images/currentLocation.png'),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(8),
                              hintText: 'Where are you?',
                              hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: dateTimeFillColor,
                          border: Border.all(
                            color: dateTimeFillColor,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/dateTime.png'),
                            const SizedBox(
                              width: 5,
                            ),
                            DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward_sharp),
                              iconSize: 13,
                              //elevation: 16,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                                // if (newValue == 'Later') {
                                //   widget.switchToDateTimeContainerWidget();
                                // }
                              },
                              items: const [
                                DropdownMenuItem(
                                  child: Text('Now'),
                                  value: 'Now',
                                ),
                                DropdownMenuItem(
                                  child: Text('Later'),
                                  value: 'Later',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                placePredictionList.isNotEmpty
                    ? loadingAdresses == true
                        ? Padding(
                            padding: const EdgeInsets.all(15),
                            child: Center(
                              child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return PredictionTile(placePredictionList[index],
                                  widget.switchToDateTimeContainerWidget);
                            },
                            itemCount: placePredictionList.length,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                          )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Most Used',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          loadingPrevLoc == true
                              ? LinearProgressIndicator(
                                  backgroundColor:
                                      colorProviderObj.backgroundDialogColor,
                                  color: Theme.of(context).primaryColor,
                                )
                              : Divider(
                                  color: Colors.grey[600],
                                  endIndent: 50,
                                  indent: 25,
                                  height: 2,
                                ),
                          loadingPrevLoc == true
                              ? Text('')
                              : ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return PrevUsedLocationsTile(prevLoc[index],
                                        widget.switchToDateTimeContainerWidget);
                                  },
                                  itemCount: prevLoc.length,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                )
                        ],
                      )
                // Container(
                //     margin: EdgeInsets.symmetric(vertical: 50),
                //     width: 100,
                //     height: 100,
                //     decoration: const BoxDecoration(
                //       image: DecorationImage(
                //         fit: BoxFit.fill,
                //         image: AssetImage("assets/images/search.png"),
                //       ),
                //     ),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
