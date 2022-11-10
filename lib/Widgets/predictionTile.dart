// ignore_for_file: file_names, missing_return

import 'package:customer_steam_wash_app/Assistant/address_methods.dart';
import 'package:customer_steam_wash_app/Models/placePridictions.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../global_variables.dart';

class PredictionTile extends StatefulWidget {
  Function switchToDateTimeContainerWidget;
  PlacePredictions currentPlacePredicted;

  PredictionTile(
      this.currentPlacePredicted, this.switchToDateTimeContainerWidget);

  @override
  State<PredictionTile> createState() => _PredictionTileState();
}

class _PredictionTileState extends State<PredictionTile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var colorProviderObj = Provider.of<ColorProvider>(context, listen: true);
    return FlatButton(
      onPressed: () async {
        pickedPrevLoc = null;

        setState(() {
          loading = true;
        });
        await getPickedAddressDetaila(widget.currentPlacePredicted.place_id);

        setState(() {
          loading = false;
        });

        widget.switchToDateTimeContainerWidget();
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },

      // () async {
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
      child: loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Colors.grey[600],
                ),
                const SizedBox(
                  width: 14.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentPlacePredicted.main_text,
                      style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        widget.currentPlacePredicted.secondary_text,
                        style: TextStyle(
                            fontSize: 12.0, color: colorProviderObj.textColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
