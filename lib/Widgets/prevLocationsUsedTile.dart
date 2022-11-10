// ignore_for_file: file_names, missing_return

import 'package:customer_steam_wash_app/Models/placePridictions.dart';
import 'package:customer_steam_wash_app/Models/prevLocations.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';

class PrevUsedLocationsTile extends StatelessWidget {
  PrevLocations prevLoc;
  Function switchToDateTimeContainerWidget;
  PrevUsedLocationsTile(this.prevLoc, this.switchToDateTimeContainerWidget);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        pickedAddress = null;
        pickedPrevLoc = prevLoc;
        switchToDateTimeContainerWidget();
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      // onPressed: () async {
      //   var result =
      //       await Provider.of<AddressDataProvider>(context, listen: false)
      //           .getParkingAreaDetails(currentPlacePredicted.place_id, context);

      //   if (result == 'Alexandria Sporting Club' ||
      //       result == 'Smouha Sporting Club') {
      //     pickedArea = result;

      //     Navigator.of(context).pushNamed(ParkingSlotsScreen.routeName);

      //     Provider.of<AddressDataProvider>(context, listen: false)
      //         .updateThePredictedPlaceAfterItIsPicked(currentPlacePredicted);
      //   } else if (result == 'failed') {
      //     showToast(
      //         "Something went wrong, Please check you internet connection and try again",
      //         context);
      //     FocusManager.instance.primaryFocus?.unfocus();
      //   } else {
      //     showToast("GoPark isn't available in this area yet", context);
      //     FocusManager.instance.primaryFocus?.unfocus();
      //   }
      // },
      child: Row(
        children: [
          Icon(
            Icons.star_border,
            color: Colors.grey[600],
          ),
          const SizedBox(
            width: 14.0,
          ),
          Text(
            prevLoc.locationname,
            style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
