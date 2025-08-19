import 'package:another_flushbar/flushbar.dart';
import 'package:easy_stars/easy_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:translate_now/utils/app_colors.dart';

import '../view_modal/rating_provider.dart';

class CustomDialog {
  void exitDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            width: 320,
            height: 327,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Image.asset("assets/rating.png", height: 140),
                Text(
                  "Did you enjoy our app?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68.0),
                  child: Text(
                    "Please rate your experience so we can improve further",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 7),
                EasyStars(
                  config: StarConfig(
                    alignment: StarAlignment.center,
                    allowClear: true,
                    rating: context.watch<RatingProvider>().rating,
                    spacing: 20,
                    customSizes: [1, 1.17, 1.25, 1.45, 1.65],
                    interactionMode: StarInteractionMode.tap,
                  ),
                  onRatingChanged: (value) {
                    context.read<RatingProvider>().setRating(value);
                  },
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xffFF6600),
                        ),
                        fixedSize: WidgetStatePropertyAll(Size(105, 40)),
                        elevation: WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                      child: Text(
                        "Exit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> flushBarMessage(BuildContext context, String msg) {
    return Flushbar(
      message: msg,
      margin: EdgeInsets.only(left: 25, right: 25, bottom: 85),
      duration: Duration(seconds: 1),
      icon: Icon(Icons.info_outline_rounded, color: AppColors.darkOrange),
      messageSize: 18,
      backgroundColor: Colors.black54,
      shouldIconPulse: false,
      borderRadius: BorderRadius.circular(5),
      leftBarIndicatorColor: AppColors.darkOrange,
      messageColor: Colors.white,
    ).show(context);
  }

  Future progressLoading(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColors.darkBlue,
            backgroundColor: AppColors.lightPurple,
          ),
        );
      },
    );
  }
}
