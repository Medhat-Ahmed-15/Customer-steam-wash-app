// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Assistant/category_methods.dart';
import 'package:customer_steam_wash_app/Models/categoryBlueprint.dart';
import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:customer_steam_wash_app/Widgets/pickedCategoryContainer_widget.dart';
import 'package:customer_steam_wash_app/Widgets/singleCategory_widget.dart';
import 'package:customer_steam_wash_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesContainerWidget extends StatefulWidget {
  Function switchToPickedCategoryContainerWidget;
  CategoriesContainerWidget(this.switchToPickedCategoryContainerWidget);
  @override
  State<CategoriesContainerWidget> createState() =>
      _CategoriesContainerWidgetState();
}

class _CategoriesContainerWidgetState extends State<CategoriesContainerWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;
  bool loading = false;

  List<CategoryBlueprint> categoriesList = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        loading = true;
      });

      getCategories().then((value) {
        categoriesList = value;
        setState(() {
          loading = false;
        });
      });

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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 408.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Align(
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SingleCategoryWidget(
                          widget.switchToPickedCategoryContainerWidget,
                          categoriesList[index],
                        ),
                        Divider(),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                  itemCount: categoriesList.length,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                ),
              ),
      ),
    );
  }
}
