// ignore_for_file: file_names

import 'dart:async';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/categoriesContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/dateTimePickerContainner_widget.dart';
import 'package:customer_steam_wash_app/Widgets/employeeDetailsContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/finishedRatingContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/logoutContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/main_drawer.dart';
import 'package:customer_steam_wash_app/Widgets/packagesOrDiscountContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/pickedCategoryContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/ratingContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/reasonForLeavingContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/searchContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/successfulBookingContainer_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/MapScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  double locationIconTopDistance = 300;
  ColorProvider colorProviderObj;

  bool loadingLocation = false,
      loadingColor = true,
      _isInit = true,
      switchToDateTimeContainer = false,
      switchToSearchContainer = true,
      discountAndPackagesContainers = true,
      switchToCategoriesContainer = false,
      switchToPickedCategoryContainer = false,
      switchToSuccessfullBookingContainer = false,
      switchToRatingContainer = false,
      switchToFinishedRatingContainer = false,
      switchToEmployeeDetailsContainer = false,
      switchToLogoutConteiner = false,
      switchToShowReasonForLeavingContainer = false;

//Locating current location
  Future<void> locatePosition() async {
    //get current position

    setState(() {
      loadingLocation = true;
    });
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    //get latitude and longitude from that position
    LatLng latlngPosition = LatLng(position.latitude, position.longitude);

    //locating camera towards this position
    CameraPosition cameraPosition =
        new CameraPosition(target: latlngPosition, zoom: 14);

    //updating the camera position
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    //converting latlng to readable addresses

    setState(() {
      loadingLocation = false;
    });
  }

  void switchToReasonForLeavingContainerWidget() {
    print('switchToEmployeeDetailsContainerWidget');
    setState(() {
      switchToShowReasonForLeavingContainer = true;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
      switchToRatingContainer = false;
      switchToFinishedRatingContainer = false;
    });
  }

  void switchToLogOutContainerWidget() {
    print('switchToEmployeeDetailsContainerWidget');
    setState(() {
      switchToLogoutConteiner = true;
      switchToShowReasonForLeavingContainer = false;
      switchToEmployeeDetailsContainer = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
      switchToRatingContainer = false;
      switchToFinishedRatingContainer = false;
    });
  }

  void switchToEmployeeDetailsContainerWidget() {
    print('switchToEmployeeDetailsContainerWidget');
    setState(() {
      switchToEmployeeDetailsContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
      switchToRatingContainer = false;
      switchToFinishedRatingContainer = false;
    });
  }

  void switchToDateTimeContainerWidget() {
    print('switchToDateTimeContainerWidget');
    setState(() {
      switchToDateTimeContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
      switchToRatingContainer = false;
      switchToFinishedRatingContainer = false;
    });
  }

  void switchToFinishedRatingContainerWidget() {
    print('switchToFinishedRatingContainerWidget');
    setState(() {
      switchToFinishedRatingContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
      switchToRatingContainer = false;
    });
  }

  void switchToRatingContainerWidget() {
    print('switchToRatingContainerWidget');

    setState(() {
      switchToRatingContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToDateTimeContainer = false;
      switchToFinishedRatingContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
    });
  }

  void switchToPickedCategoryContainerWidget() {
    print('switchToPickedCategoryContainerWidget');

    setState(() {
      switchToPickedCategoryContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToFinishedRatingContainer = false;
      switchToRatingContainer = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      switchToCategoriesContainer = false;
      discountAndPackagesContainers = false;
      switchToSuccessfullBookingContainer = false;
    });
  }

  void switchToSearchContainerWidget() {
    print('switchToSearchContainerWidget');

    setState(() {
      switchToSearchContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToFinishedRatingContainer = false;
      switchToRatingContainer = false;
      switchToDateTimeContainer = false;
      switchToCategoriesContainer = false;
      switchToSuccessfullBookingContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
    });
  }

  void switchToSuccessfullBookingContainerWidget() {
    print('switchToSuccessfullBookingContainerWidget');

    setState(() {
      switchToSuccessfullBookingContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToFinishedRatingContainer = false;
      switchToRatingContainer = false;
      switchToSearchContainer = false;
      switchToDateTimeContainer = false;
      switchToCategoriesContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
    });
  }

  void switchToCategoriesContainerWidget() {
    print('switchToCategoriesContainerWidget');

    setState(() {
      switchToCategoriesContainer = true;
      switchToShowReasonForLeavingContainer = false;
      switchToLogoutConteiner = false;
      switchToEmployeeDetailsContainer = false;
      switchToFinishedRatingContainer = false;
      switchToRatingContainer = false;
      switchToSuccessfullBookingContainer = false;
      switchToDateTimeContainer = false;
      switchToSearchContainer = false;
      discountAndPackagesContainers = false;
      switchToPickedCategoryContainer = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        loadingColor = true;
      });
      colorProviderObj = Provider.of<ColorProvider>(context, listen: true);

      Provider.of<ColorProvider>(context, listen: false)
          .checkThemeMethodInThisScreen()
          .then((value) {
        setState(() {
          loadingColor = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    locationIconTopDistance =
        MediaQuery.of(context).size.height - 282 - 91 - 100;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: MainDrawer(switchToLogOutContainerWidget),
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () async =>
            false, //this line is for avoiding the user to go to the previous page when he is in the map screen
        child: loadingColor == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Stack(
                children: [
                  GoogleMap(
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controllerGoogleMap.complete(controller);
                      newGoogleMapController = controller;

                      locatePosition();
                    },
                  ),

                  //Hamburger Button
                  Positioned(
                    top: 60.0,
                    left: 25.0,
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(27.0),
                          boxShadow: [
                            BoxShadow(
                              color: colorProviderObj.textColor,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: colorProviderObj.backgroundColor,
                          child: Icon(
                            Icons.menu,
                            color: Colors.grey[600],
                            size: 30,
                          ),
                          radius: 27.0,
                        ),
                      ),
                    ),
                  ),

                  //Current location Button
                  Positioned(
                    top: locationIconTopDistance,
                    left: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width - 300),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          locatePosition();
                        });

                        switchToRatingContainerWidget();
                        //switchToEmployeeDetailsContainerWidget();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.5),
                          boxShadow: [
                            BoxShadow(
                              color: colorProviderObj.textColor,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: colorProviderObj.backgroundColor,
                          child: Image.asset('assets/images/locationIcon.png'),
                          radius: 25.5,
                        ),
                      ),
                    ),
                  ),

                  //Profile image
                  Positioned(
                    top: 60.0,
                    left: 330.0,
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState.openDrawer();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          boxShadow: [
                            BoxShadow(
                              color: colorProviderObj.textColor,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 27.0,
                          backgroundColor: colorProviderObj.backgroundColor,
                          child: const CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/images/me.jpeg'),
                            radius: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Discount and packages containers
                  if (switchToSearchContainer == true)
                    Positioned(
                      bottom: 300,
                      left: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width - 20),
                      right: MediaQuery.of(context).size.width -
                          (MediaQuery.of(context).size.width - 20),
                      child: Row(
                        children: [
                          PackagesOrDiscountContainerWidget('Promo code',
                              '50% Discount', 'assets/images/discount.png'),
                          const SizedBox(
                            width: 15,
                          ),
                          PackagesOrDiscountContainerWidget(
                              'Packages',
                              'Choose your package',
                              'assets/images/package.png'),
                        ],
                      ),
                    ),

                  //Search Container****************************************************
                  if (switchToSearchContainer == true)
                    SearchContainerWidget(switchToDateTimeContainerWidget),

                  //Date Time picker Container
                  if (switchToDateTimeContainer == true)
                    DateTimePickerContainerWidget(
                      switchToSearchContainerWidget,
                      switchToCategoriesContainerWidget,
                    ),

                  //Categories Container
                  if (switchToCategoriesContainer == true)
                    CategoriesContainerWidget(
                        switchToPickedCategoryContainerWidget),

                  //Picked Category Container
                  if (switchToPickedCategoryContainer == true)
                    PickedCategoryContainerWidget(
                        switchToSuccessfullBookingContainerWidget),

                  //Successfull Booking Container
                  if (switchToSuccessfullBookingContainer == true)
                    SuccessfullBookingContainerWidget(
                        switchToSearchContainerWidget),

                  //Rating Container
                  if (switchToRatingContainer == true)
                    RatingContainerWidget(
                        switchToFinishedRatingContainerWidget),

                  //Finished Rating Container
                  if (switchToFinishedRatingContainer == true)
                    FinishedRatingContainerWidget(
                        switchToSearchContainerWidget),

                  //Finished Rating Container
                  if (switchToEmployeeDetailsContainer == true)
                    EmployeeDetailsContainerWidget(),

                  if (switchToLogoutConteiner == true ||
                      switchToShowReasonForLeavingContainer == true)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black38,
                    ),

                  //Reason for leaving Container
                  if (switchToShowReasonForLeavingContainer == true)
                    ReasingForLeavingContainerWidget(
                        switchToReasonForLeavingContainerWidget),

                  //Logout Container
                  if (switchToLogoutConteiner == true)
                    LogoutConatinerWidget(switchToSearchContainerWidget,
                        switchToReasonForLeavingContainerWidget),
                ],
              ),
      ),
    );
  }
}
