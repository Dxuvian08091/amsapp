// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:amsapp/app_localizations.dart';

import '../myutils/app_colors.dart';
import '../myutils/dimens.dart';
import '../myutils/styles.dart';

class CustomListTile extends StatelessWidget {
  final bool? normal;
  final Function? onTap;
  final String? title;
  final IconData? iconData;
  final bool? trailing;
  final TextStyle? textStyle;

  const CustomListTile(
      {Key? key,
      this.iconData,
      this.title,
      this.onTap,
      this.normal,
      this.trailing,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData _iconData = iconData ?? Icons.app_blocking;
    Function _onTap = onTap ?? () {};
    bool _normal = normal ?? false;
    bool _trailing = trailing ?? false;
    String _title =
        title ?? AppLocalizations.getString(context, "default_text");
    return ListTile(
      title: Text(
        _title,
        style: textStyle ?? Styles.boldInfoFontStyle,
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: _normal ? 0 : MediaQuery.of(context).size.width * 0.095,
        ),
        child: Icon(
          _iconData,
          color: AppColors.normal,
          size: Dimens.normalDimens * 3,
        ),
      ),
      minLeadingWidth: Dimens.normalDimens * 2,
      onTap: () {
        _onTap();
      },
      trailing:
          _trailing ? const Icon(Icons.keyboard_arrow_right_rounded) : null,
    );
  }
}
