import 'dart:io';

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/myutils/route_generator.dart';
import 'package:amsapp/widgets/app_drawer.dart';

import '../app_localizations.dart';
import '../myutils/app_colors.dart';
import '../myutils/constant.dart';
import '../myutils/preference.dart';
import '../myutils/styles.dart';
import '../widgets/custom_list_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController oldController = TextEditingController();
  final TextEditingController newController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String fullName = AppLocalizations.getString(context, 'username');
    String address = AppLocalizations.getString(context, 'address');
    return Scaffold(
      drawer: const AppDrawer(),
      key: scaffoldKey,
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.normalDimens * 2,
                horizontal: Dimens.normalDimens * 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    heroTag: "btnMenu",
                    key: null,
                    mini: true,
                    backgroundColor: AppColors.white,
                    child: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.colorPrimaryLight,
                    ),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  ),
                  Text(
                    AppLocalizations.getString(context, "my_profile"),
                    style: Styles.boldInfoFontStyle,
                  ),
                  FloatingActionButton(
                      heroTag: "btnEdit",
                      key: null,
                      mini: true,
                      backgroundColor: AppColors.white,
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.colorPrimaryLight,
                      ),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(RouteNames.editProfilePage)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.normalDimens * 3,
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: Dimens.normalDimens * 2,
                    ),
                    CircleAvatar(
                      radius: Dimens.normalDimens * 5,
                      child: Preference.getString("profile_picture").isEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimens.normalDimens * 5),
                              child: Image.file(
                                File(Preference.getString("profile_picture")),
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Icon(Icons.camera_alt),
                    ),
                    const SizedBox(
                      height: Dimens.halfDimens,
                    ),
                    Text(fullName, style: Styles.boldInfoFontStyleGrey),
                    const SizedBox(
                      height: Dimens.minimumDimens,
                    ),
                    Text(
                      address,
                      style: Styles.textSecondary10,
                    ),
                    const SizedBox(
                      height: Dimens.minimumDimens,
                    ),
                    const Text(
                      "Pradesh 2, Ba 5 Pa 2933",
                      style: Styles.textSecondary10,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              AppLocalizations.getString(context, "fuel_log"),
                              style: Styles.semiBoldMediumFontStyle,
                            ),
                            Text(
                              AppLocalizations.getString(context, "9999"),
                              style: Styles.boldPrimary19,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              AppLocalizations.getString(
                                  context, "maintenance_log"),
                              style: Styles.semiBoldMediumFontStyle,
                            ),
                            Text(
                              AppLocalizations.getString(context, "9999"),
                              style: Styles.boldPrimary19,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              AppLocalizations.getString(context, "attendance"),
                              style: Styles.semiBoldMediumFontStyle,
                            ),
                            Text(
                              AppLocalizations.getString(context, "365"),
                              style: Styles.boldPrimary19,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 6,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.getString(context, "dashboard"),
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    CustomListTile(
                      normal: true,
                      title: AppLocalizations.getString(context, "fuel_log"),
                      iconData: Icons.info,
                      onTap: () {},
                      trailing: true,
                      textStyle: Styles.semiBoldNormal15,
                    ),
                    const SizedBox(
                      height: Dimens.halfDimens,
                    ),
                    CustomListTile(
                      normal: true,
                      title: AppLocalizations.getString(
                          context, "drive_schedules"),
                      iconData: Icons.drive_eta,
                      trailing: true,
                      onTap: () {},
                      textStyle: Styles.semiBoldNormal15,
                    ),
                    const SizedBox(
                      height: Dimens.halfDimens,
                    ),
                    CustomListTile(
                      normal: true,
                      title: AppLocalizations.getString(
                          context, "maintenance_log"),
                      iconData: Icons.edit,
                      trailing: true,
                      onTap: () {},
                      textStyle: Styles.semiBoldNormal15,
                    ),
                    const SizedBox(
                      height: Dimens.halfDimens,
                    ),
                    CustomListTile(
                      normal: true,
                      title: AppLocalizations.getString(
                          context, "update_vehicle_info"),
                      iconData: Icons.drive_eta,
                      trailing: true,
                      onTap: () {},
                      textStyle: Styles.semiBoldNormal15,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 6,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(AppLocalizations.getString(
                          context, "security_settings")),
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    CustomListTile(
                      normal: true,
                      title: AppLocalizations.getString(
                          context, "change_password"),
                      iconData: Icons.password,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(RouteNames.changePasswordPage);
                      },
                      trailing: true,
                      textStyle: Styles.semiBoldNormal15,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 4,
                    ),
                    GestureDetector(
                      child: Text(
                        AppLocalizations.getString(context, "log_out"),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: AppColors.error,
                        ),
                      ),
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
                      height: Dimens.normalDimens * 7,
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
