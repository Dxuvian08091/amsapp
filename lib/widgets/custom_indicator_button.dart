import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';
import 'package:amsapp/myutils/styles.dart';

import '../myutils/dimens.dart';

class CustomIndicatorButton extends StatefulWidget {
  final bool? enableIndicator;
  final Function? onPressed;
  final IconData? iconData;
  final bool? outlineBtn;

  // final bool? isLoading;
  final bool? isIcon;
  final String? text;

  const CustomIndicatorButton({
    Key? key,
    this.onPressed,
    this.outlineBtn,
    // this.isLoading,
    this.iconData,
    this.enableIndicator,
    this.isIcon,
    this.text,
  }) : super(key: key);

  @override
  State<CustomIndicatorButton> createState() => CustomIndicatorButtonState();
}

class CustomIndicatorButtonState extends State<CustomIndicatorButton> {
  bool _done = false;

  // bool execute = false;
  bool _error = false;
  bool _isLoading = false;
  bool _showText = true;
  double _width = Dimens.normalDimens * 19.0;
  final double _height = Dimens.normalDimens * 6.0;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(32);

  void setLoading() {
    setState(() {
      // execute = true;
      _isLoading = true;
      _error = false;
      _done = false;
      _showText = false;
      _width = Dimens.normalDimens * 6.0;
      _borderRadius = BorderRadius.circular(Dimens.normalDimens * 4.0);
    });
  }

  void setError() {
    setState(() {
      // execute = true;
      _isLoading = false;
      _error = true;
      _done = false;
      _showText = false;
      setState(() {
        _isLoading = false;
        _done = false;
        _error = false;
        _showText = true;
        _width = Dimens.normalDimens * 19.0;
        _borderRadius = BorderRadius.circular(Dimens.normalDimens * 4.0);
      });
    });
  }

  void setSuccess() {
    setState(() {
      // execute = true;
      _isLoading = false;
      _error = false;
      _done = true;
      _showText = false;
      setState(() {
        _isLoading = false;
        _done = false;
        _error = false;
        _showText = true;
        _width = Dimens.normalDimens * 19.0;
        _borderRadius = BorderRadius.circular(Dimens.normalDimens * 4.0);
      });
    });
  }

  void setButtonState() {
    setState(() {
      // execute = true;
      _isLoading = false;
      _error = false;
      _done = true;
      _showText = false;
      setState(() {
        _isLoading = false;
        _done = false;
        _error = false;
        _showText = true;
        _width = Dimens.normalDimens * 19.0;
        _borderRadius = BorderRadius.circular(Dimens.normalDimens * 4.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool outlineBtn = widget.outlineBtn ?? false;
    Function onPressed = widget.onPressed ?? () {};
    IconData iconData = widget.iconData ?? Icons.app_blocking;
    bool isIcon = widget.isIcon ?? false;
    String text = widget.text ?? "Text";
    return GestureDetector(
      onTap: () {
        if (_showText) onPressed();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 352),
        curve: Curves.fastOutSlowIn,
        height: _height,
        width: _width,
        decoration: BoxDecoration(
          color: outlineBtn ? AppColors.transparent : AppColors.normal,
          border: Border.all(
            color: AppColors.normal,
            width: Dimens.minimumDimens,
          ),
          borderRadius: _borderRadius,
        ),
        child: Center(
          child: Stack(
            children: [
              Visibility(
                visible: _showText,
                child: Text(
                  text,
                  style: Styles.titleFontStyle,
                ),
              ),
              Visibility(
                visible: !_isLoading && isIcon,
                child: Icon(
                  iconData,
                  color: AppColors.colorPrimary,
                ),
              ),
              Visibility(
                visible: _isLoading,
                child: const SizedBox(
                  height: Dimens.normalDimens * 4.0,
                  width: Dimens.normalDimens * 4.0,
                  child: CircularProgressIndicator(
                    color: AppColors.colorPrimary,
                  ),
                ),
              ),
              Visibility(
                visible: !_isLoading && !isIcon && _done,
                child: const Icon(
                  Icons.check,
                  color: AppColors.colorPrimary,
                  size: Dimens.halfDimens * 9.0,
                ),
              ),
              Visibility(
                visible: !_isLoading && !isIcon && _error,
                child: const Icon(
                  Icons.close,
                  color: AppColors.colorPrimary,
                  size: Dimens.halfDimens * 9.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
