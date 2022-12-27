import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';
import 'package:amsapp/myutils/constant.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/myutils/preference.dart';
import 'package:amsapp/myutils/styles.dart';
import 'package:amsapp/widgets/custom_list_tile.dart';

import '../app_localizations.dart';
import '../myutils/route_generator.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Drawer(
              backgroundColor: AppColors.colorPrimary,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: Dimens.normalDimens * 5,
                  ),
                  DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppLocalizations.getString(context, "hello"),
                          style: Styles.semiBoldRegularFontStyle,
                        ),
                        Text(
                          AppLocalizations.getString(context, "username"),
                          style: Styles.boldFontStyle_20,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens * 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens * 3,
                  ),
                  CustomListTile(
                    title: AppLocalizations.getString(context, "profile"),
                    iconData: Icons.person,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(RouteNames.profilePage);
                    },
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens,
                  ),
                  CustomListTile(
                    title:
                        AppLocalizations.getString(context, "attendance_form"),
                    iconData: Icons.home,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(RouteNames.attendanceFormPage);
                    },
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens,
                  ),
                  CustomListTile(
                    title: AppLocalizations.getString(context, "present_days"),
                    iconData: Icons.download,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context).pushReplacementNamed(
                          RouteNames.attendancePresentPage);
                    },
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens,
                  ),
                  CustomListTile(
                    title: AppLocalizations.getString(context, "leave_days"),
                    iconData: Icons.download,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.of(context)
                          .pushReplacementNamed(RouteNames.attendanceLeavePage);
                    },
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens,
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens * 18,
                  ),
                  CustomListTile(
                    title: AppLocalizations.getString(context, "log_out"),
                    iconData: Icons.logout,
                    onTap: () {
                      Preference.clear();
                      Preference.setBool(Constant.spIsFirstTime, false);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RouteNames.loginPage,
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                  const SizedBox(
                    height: Dimens.normalDimens,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
