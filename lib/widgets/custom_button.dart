import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';

import '../myutils/dimens.dart';

class CustomButton extends StatefulWidget {
  final IconData? iconData;
  final bool isMini;

  const CustomButton({
    Key? key,
    this.iconData,
    required this.isMini,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    IconData iconData = widget.iconData ?? Icons.app_blocking;
    return FloatingActionButton(
      mini: widget.isMini,
      heroTag: null,
      elevation: Dimens.minimumDimens * 6.0,
      backgroundColor: AppColors.normal,
      onPressed: null,
      child: Center(
        child: Icon(
          iconData,
          size: Dimens.halfDimens * 6.0,
          color: AppColors.white,
        ),
      ),
    );
  }
}
