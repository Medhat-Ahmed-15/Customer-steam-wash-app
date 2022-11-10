// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackagesOrDiscountContainerWidget extends StatefulWidget {
  String title;
  String subTitle;
  String Image;

  PackagesOrDiscountContainerWidget(this.title, this.subTitle, this.Image);

  @override
  State<PackagesOrDiscountContainerWidget> createState() =>
      _PackagesOrDiscountContainerWidgetState();
}

class _PackagesOrDiscountContainerWidgetState
    extends State<PackagesOrDiscountContainerWidget> {
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
    return Container(
      decoration: BoxDecoration(
        color: colorProviderObj.backgroundDialogColor,
        border: Border.all(
          color: colorProviderObj.backgroundDialogColor,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 91,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Image.asset(widget.Image),
            const SizedBox(
              width: 5,
            ),
            Image.asset('assets/images/verticalLine.png'),
            const SizedBox(
              width: 5,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[600]),
                ),
                Text(
                  widget.subTitle,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
