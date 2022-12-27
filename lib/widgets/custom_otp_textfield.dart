// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';

import '../myutils/app_colors.dart';
import '../myutils/styles.dart';

class CustomOtpTextfield extends StatefulWidget {
  final bool first;
  final bool last;
  final TextEditingController controller;

  const CustomOtpTextfield({
    Key? key,
    required this.first,
    required this.last,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomOtpTextfieldState createState() => _CustomOtpTextfieldState();
}

class _CustomOtpTextfieldState extends State<CustomOtpTextfield> {
  @override
  Widget build(BuildContext context) {
    bool first = widget.first;
    bool last = widget.last;
    return SizedBox(
      height: Dimens.halfDimens * 11,
      width: Dimens.halfDimens * 9,
      child: Center(
        child: TextField(
          controller: widget.controller,
          textInputAction: last ? TextInputAction.done : TextInputAction.next,
          enableInteractiveSelection: false,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          style: Styles.otpCodeFontStyle,
          readOnly: false,
          textAlign: TextAlign.end,
          textAlignVertical: const TextAlignVertical(y: -0.65),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1.5, color: AppColors.normal),
                borderRadius: BorderRadius.circular(Dimens.normalDimens * 3.0)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1.5, color: AppColors.white),
                borderRadius: BorderRadius.circular(Dimens.normalDimens * 3.0)),
          ),
        ),
      ),
    );
  }
}
