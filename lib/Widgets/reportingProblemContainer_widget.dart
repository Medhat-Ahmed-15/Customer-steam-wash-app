// ignore_for_file: file_names

import 'package:customer_steam_wash_app/Providers/color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Problems { problem1, problem2, problem3 }

class ReportingProblemContainerWidget extends StatefulWidget {
  @override
  State<ReportingProblemContainerWidget> createState() =>
      _ReportingProblemContainerWidgetState();
}

class _ReportingProblemContainerWidgetState
    extends State<ReportingProblemContainerWidget> {
  ColorProvider colorProviderObj;
  bool _isInit = true;

  Problems problem = Problems.problem1;

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
        height: 432.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorProviderObj.backgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Please tell us a problem',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: colorProviderObj.textColor),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('The service is less than expected'),
                      leading: Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: Problems.problem1,
                        groupValue: problem,
                        onChanged: (Problems value) {
                          setState(() {
                            problem = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Bad experience'),
                      leading: Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: Problems.problem2,
                        groupValue: problem,
                        onChanged: (Problems value) {
                          setState(() {
                            problem = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Others'),
                      leading: Radio(
                        activeColor: Theme.of(context).primaryColor,
                        value: Problems.problem3,
                        groupValue: problem,
                        onChanged: (Problems value) {
                          setState(() {
                            problem = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: colorProviderObj.backgroundDialogColor,
                    border: Border.all(
                      color: colorProviderObj.backgroundDialogColor,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //controller: _emailAddressController,
                      keyboardType: TextInputType.text,
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(
                        color: colorProviderObj.textColor,
                      ),
                      decoration: InputDecoration(
                        icon: Image.asset('assets/images/comment.png'),
                        border: InputBorder.none,
                        // contentPadding: const EdgeInsets.all(8),
                        hintText: 'Please tell us the reason',
                        hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 56,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
