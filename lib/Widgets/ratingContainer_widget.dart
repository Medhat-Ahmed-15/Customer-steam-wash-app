// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingContainerWidget extends StatefulWidget {
  Function switchToFinishedRatingContainerWidget;

  RatingContainerWidget(this.switchToFinishedRatingContainerWidget);
  @override
  State<RatingContainerWidget> createState() => _RatingContainerWidgetState();
}

class _RatingContainerWidgetState extends State<RatingContainerWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;

  bool showButtons = false;

  double finalRating = 0.0;

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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 390.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, top: 54, right: 15),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 37,
                child: const CircleAvatar(
                  radius: 35.5,
                  backgroundImage: AssetImage(
                    'assets/images/omar.jpeg',
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'How was the servicec with Omar ?',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: colorProviderObj.textColor),
              ),
              Expanded(
                child: Container(),
              ),
              // RatingBar.builder(
              //   initialRating: 0,
              //   minRating: 1,
              //   direction: Axis.horizontal,
              //   allowHalfRating: false,
              //   itemCount: 5,
              //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              //   itemBuilder: (context, _) => const Icon(
              //     Icons.star,
              //     color: Colors.amber,
              //   ),
              //   onRatingUpdate: (rating) {
              //     print(rating);
              //   },
              // ),

              Expanded(
                child: RatingBar.builder(
                  initialRating: 0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 8),
                  itemSize: 50,
                  itemCount: 5,
                  // ignore: missing_return
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied_sharp,
                          color: Colors.red,
                        );
                      case 1:
                        return const Icon(
                          Icons.sentiment_very_dissatisfied,
                          color: Colors.redAccent,
                        );
                      case 2:
                        return const Icon(
                          Icons.sentiment_neutral,
                          color: Colors.amber,
                        );
                      case 3:
                        return const Icon(
                          Icons.sentiment_satisfied_alt_sharp,
                          color: Colors.lightGreen,
                        );
                      case 4:
                        return const Icon(
                          Icons.sentiment_very_satisfied,
                          color: Colors.green,
                        );
                    }
                  },

                  onRatingUpdate: (rating) {
                    finalRating = rating;
                    print('Rating:' + " " + rating.toString());

                    if (rating >= 1 && rating < 2) {
                      setState(() {
                        showButtons = true;
                      });
                    }
                  },
                ),
              ),
              Expanded(child: Container()),

              if (showButtons == true)
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    print('Final Rating:' + " " + finalRating.toString());

                    widget.switchToFinishedRatingContainerWidget();
                  },
                ),
              if (showButtons == true) Expanded(child: Container()),
              if (showButtons == true)
                Text(
                  'Cancel , Submit',
                  style: TextStyle(
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600]),
                ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
