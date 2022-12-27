import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';

import '../myutils/dimens.dart';
import '../myutils/styles.dart';

class CustomTextField extends StatefulWidget {
  final bool? submittable;
  final int? maxlength;
  final TextEditingController? controller;
  final IconData? iconData;
  final Widget? prefixIcon;
  final String? label;
  final bool? passwordField;
  final TextInputType? keyboard;
  final String? prefix;
  final bool? hasPrefixIcon;
  final Widget? suffixIcon;
  final bool? hasSuffixIcon;
  final Stream<String>? stream;
  final bool? hasBorder;
  final int? maxLines;

  const CustomTextField({
    Key? key,
    this.iconData,
    this.controller,
    this.label,
    this.passwordField,
    this.keyboard,
    this.prefix,
    this.hasPrefixIcon,
    this.maxlength,
    this.prefixIcon,
    this.hasSuffixIcon,
    this.suffixIcon,
    this.stream,
    this.submittable,
    this.hasBorder,
    this.maxLines,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  String value = "";
  bool valid = false;
  bool _textVisibility = true;
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
    widget.stream?.listen((errorString) {
      updateValidate(errorString);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool submittable = widget.submittable ?? false;
    int maxLines = widget.maxLines ?? 1;
    int maxLength = widget.maxlength ?? TextField.noMaxLength;
    TextEditingController controller =
        widget.controller ?? TextEditingController();
    IconData iconData = widget.iconData ?? Icons.app_blocking;
    String label = widget.label ?? "";
    bool passwordField = widget.passwordField ?? false;
    TextInputType keyboard = widget.keyboard ?? TextInputType.text;
    String prefix = widget.prefix ?? "";
    bool hasPrefixIcon = widget.hasPrefixIcon ?? false;
    bool hasBorder = widget.hasBorder ?? false;
    Widget? prefixIcon = hasPrefixIcon
        ? Icon(
            iconData,
            size: Dimens.normalDimens * 2.0,
            color: AppColors.txtFieldLblColor,
          )
        : widget.prefixIcon;
    bool? hasSuffixIcon = widget.hasSuffixIcon ?? false;
    Widget? suffixIcon = passwordField && !hasSuffixIcon
        ? InkWell(
            canRequestFocus: false,
            onTap: () {
              setState(() => _textVisibility = !_textVisibility);
            },
            child: Icon(
              _textVisibility
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.txtFieldLblColor,
              size: Dimens.normalDimens * 3.0,
            ),
          )
        : widget.suffixIcon;
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: Dimens.normalDimens * 6,
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              onEditingComplete:
                  submittable ? null : () => FocusScope.of(context).nextFocus(),
              onSubmitted:
                  !submittable ? null : (_) => FocusScope.of(context).unfocus(),
              textInputAction:
                  submittable ? TextInputAction.done : TextInputAction.next,
              onChanged: (value) {
                this.value = controller.text;
                if (maxLength != TextField.noMaxLength &&
                    value.length == maxLength) {
                  setState(() {
                    valid = true;
                  });
                } else {
                  setState(() {
                    valid = false;
                  });
                }
              },
              obscureText: passwordField ? _textVisibility : false,
              maxLength: maxLength,
              decoration: InputDecoration(
                suffixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 0, minHeight: 0),
                counter: const Offstage(),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                filled: true,
                fillColor: AppColors.white,
                isDense: true,
                labelText: label,
                labelStyle: Styles.labelFontStyle,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: hasBorder
                        ? AppColors.textFieldtxt
                        : AppColors.transparent,
                  ),
                  borderRadius:
                      BorderRadius.circular(Dimens.normalDimens * 6.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: hasBorder
                        ? AppColors.textFieldtxt
                        : AppColors.transparent,
                  ),
                  borderRadius:
                      BorderRadius.circular(Dimens.normalDimens * 6.0),
                ),
                prefixIcon: Visibility(
                  visible: hasPrefixIcon,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: Dimens.normalDimens * 3,
                        right: Dimens.normalDimens),
                    child: prefixIcon,
                  ),
                ),
                suffixIcon: Visibility(
                  visible: passwordField || hasSuffixIcon,
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.normalDimens),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.normalDimens * 3),
                      child: suffixIcon,
                    ),
                  ),
                ),
                prefix: Visibility(
                  visible: prefix.isEmpty ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(right: Dimens.halfDimens),
                    child: Text(prefix),
                  ),
                ),
              ),
              style: Styles.txtFieldFontStyle,
              keyboardType: keyboard,
            ),
          ),
          if (!_isValid)
            Text(
              _errorText,
              style: Styles.errorTextStyle,
            ),
        ],
      ),
    );
  }
}
