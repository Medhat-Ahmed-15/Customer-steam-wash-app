// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Models/categoryBlueprint.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCategoryWidget extends StatefulWidget {
  Function switchToPickedCategoryContainerWidget;
  CategoryBlueprint singlCategory;
  SingleCategoryWidget(
      this.switchToPickedCategoryContainerWidget, this.singlCategory);
  @override
  State<SingleCategoryWidget> createState() => _SingleCategoryWidgetState();
}

class _SingleCategoryWidgetState extends State<SingleCategoryWidget> {
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
    return Padding(
      padding: const EdgeInsets.only(left: 0, bottom: 10, right: 25),
      child: GestureDetector(
        onTap: () {
          pickedCategory = widget.singlCategory;
          widget.switchToPickedCategoryContainerWidget();
        },
        child: Row(
          children: [
            Image.asset('assets/images/category.png'),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.singlCategory.name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorProviderObj.textColor),
                ),
                Container(
                  width: 170,
                  child: Text(
                    widget.singlCategory.description,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            Expanded(child: Container()),
            Container(
              height: 56.0,
              width: 56,
              decoration: BoxDecoration(
                color: colorProviderObj.backgroundDialogColor,
                border: Border.all(
                  color: colorProviderObj.backgroundDialogColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  ' ${widget.singlCategory.price}\nEGP',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
