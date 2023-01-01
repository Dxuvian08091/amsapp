import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';

import '../myutils/dimens.dart';
import '../myutils/styles.dart';

class CustomAutoCompleteTextField extends StatefulWidget {
  final Stream<String>? stream;
  final IconData? iconData;
  final List<String>? items;
  final String? label;
  final double? width;
  final String? value;
  final bool? hasBorder;

  const CustomAutoCompleteTextField({
    Key? key,
    this.iconData,
    this.items,
    this.stream,
    this.label,
    this.width,
    this.value,
    this.hasBorder,
  }) : super(key: key);

  @override
  State<CustomAutoCompleteTextField> createState() =>
      CustomAutoCompleteTextFieldState();
}

class CustomAutoCompleteTextFieldState
    extends State<CustomAutoCompleteTextField> {
  String? text;
  bool valid = false;
  bool _isValid = true;
  String _errorText = "";

  void updateValidate(String error) {
    setState(() {
      _errorText = error;
      _isValid = _errorText.isEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      text = widget.value;
      valid = true;
    }
    widget.stream?.listen((errorString) {
      updateValidate(errorString);
    });
  }

  @override
  Widget build(BuildContext context) {
    IconData iconData = widget.iconData ?? Icons.app_blocking;
    List<String> items = widget.items ?? ["Default Option"];
    String label = widget.label ?? "";
    double width = widget.width ?? Dimens.normalDimens * 18;
    String value = widget.value ?? "";
    bool hasBorder = widget.hasBorder ?? false;
    return Column(
      children: [
        Container(
          height: Dimens.normalDimens * 5,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
                color:
                    hasBorder ? AppColors.textFieldtxt : AppColors.transparent),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                Dimens.normalDimens * 5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.normalDimens * 3,
              vertical: Dimens.normalDimens * 1.5,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  color: AppColors.txtFieldLblColor,
                  size: Dimens.normalDimens * 2,
                ),
                const SizedBox(
                  width: Dimens.normalDimens,
                ),
                SizedBox(
                  width: width,
                  child: Autocomplete<String>(
                    initialValue:
                        value.isNotEmpty ? TextEditingValue(text: value) : null,
                    optionsBuilder: (textEditingValue) {
                      return items
                          .where(
                            (String item) => item.toLowerCase().startsWith(
                                  textEditingValue.text.toLowerCase(),
                                ),
                          )
                          .toList();
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          child: Container(
                            height: Dimens.normalDimens * 37,
                            width: width,
                            color: AppColors.white,
                            child: ListView.builder(
                              padding:
                                  const EdgeInsets.all(Dimens.normalDimens),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final String option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                    setState(() {
                                      text = option.toLowerCase();
                                      if (!items.every((item) =>
                                          item.toLowerCase().compareTo(text!) !=
                                          0)) {
                                        valid = true;
                                      } else {
                                        valid = false;
                                      }
                                    });
                                  },
                                  child: ListTile(
                                    title: Text(option,
                                        style: Styles.labelFontStyle),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    fieldViewBuilder: (context, fieldController, fieldFocusNode,
                        onFieldSubmittedd) {
                      return TextField(
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: label,
                          labelStyle: Styles.labelFontStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        controller: fieldController,
                        focusNode: fieldFocusNode,
                        style: Styles.labelFontStyle,
                        onChanged: (value) {
                          setState(
                            () {
                              text = fieldController.text.toLowerCase();
                              if (!items.every((item) =>
                                  item.toLowerCase().compareTo(text!) != 0)) {
                                valid = true;
                                text = text!.substring(0, 1).toUpperCase() +
                                    text!.substring(1).toLowerCase();
                                fieldController.text = text!;
                              } else {
                                valid = false;
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: Dimens.normalDimens,
        ),
        if (!_isValid)
          Text(
            _errorText,
            style: Styles.errorTextStyle,
          ),
      ],
    );
  }
}
