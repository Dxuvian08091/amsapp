// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/styles.dart';

import '../app_localizations.dart';
import 'dimens.dart';

class AlertUtils {
  static void showAlertDialog(context, title, message, positiveButtonText) {
    Future<void> _alertDialogBuilder() async {
      return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(positiveButtonText),
                )
              ],
            );
          });
    }

    _alertDialogBuilder();
  }

  static void showSnackBar(context, message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static dynamic showProgressDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.normalDimens),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    width: Dimens.normalDimens * 3,
                  ),
                  Text(AppLocalizations.getString(context, "loading"),
                      style: Styles.semiBoldRegularFontStyle),
                ],
              ),
            ),
          );
        });
  }
}
