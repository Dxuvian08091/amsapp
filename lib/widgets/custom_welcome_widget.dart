// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';

import '../app_localizations.dart';
import '../myutils/styles.dart';

class CustomWelcomeWidget extends StatefulWidget {
  final String? header;
  final String? image;

  const CustomWelcomeWidget({Key? key, this.header, this.image})
      : super(key: key);

  @override
  _CustomWelcomeWidgetState createState() => _CustomWelcomeWidgetState();
}

class _CustomWelcomeWidgetState extends State<CustomWelcomeWidget> {
  @override
  Widget build(BuildContext context) {
    String info =
        widget.header ?? AppLocalizations.getString(context, "default_text");
    String image = widget.image ?? "assets/images/car.jpg";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Dimens.normalDimens * 4.0),
            child: Image.asset(
              image,
              fit: BoxFit.fitWidth,
              width: Dimens.normalDimens * 40,
            ),
          ),
        ),
        const SizedBox(
          height: Dimens.inputScreenPadding,
        ),
        Flexible(
          child: Text(
            info,
            textAlign: TextAlign.center,
            style: Styles.boldFontStyle_20,
          ),
        ),
      ],
    );
  }
}
