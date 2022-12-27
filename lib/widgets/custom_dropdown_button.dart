import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';

import '../myutils/dimens.dart';
import '../myutils/styles.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String>? condition;
  final StreamController<bool>? streamController;
  final Stream<bool>? stream;
  final String? value;
  final IconData? iconData;
  final List<String>? items;
  final bool? hasBorder;

  const CustomDropDownButton({
    Key? key,
    this.iconData,
    this.items,
    this.value,
    this.stream,
    this.condition,
    this.streamController,
    this.hasBorder,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => CustomDropDownButtonState();
}

class CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? value;

  @override
  Widget build(BuildContext context) {
    List<String> condition = widget.condition ?? ["Default Option"];
    IconData iconData = widget.iconData ?? Icons.app_blocking;
    List<String> items = widget.items ?? ["Default Option"];
    String? defaultValue = value ?? widget.value;
    bool hasBorder = widget.hasBorder ?? false;
    return Container(
      height: Dimens.normalDimens * 5,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(
          color: hasBorder ? AppColors.textFieldtxt : AppColors.transparent,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Dimens.normalDimens * 5,
          ),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.normalDimens * 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              color: AppColors.txtFieldLblColor,
              size: Dimens.normalDimens * 2.5,
            ),
            const SizedBox(
              width: Dimens.normalDimens,
            ),
            DropdownButton(
              underline: const SizedBox(),
              value: defaultValue,
              style: Styles.labelFontStyle,
              items: items.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (condition.contains(newValue)) {
                  widget.streamController?.sink.add(true);
                } else {
                  widget.streamController?.sink.add(false);
                }
                setState(() {
                  value = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
