import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/myutils/styles.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';
import 'package:amsapp/widgets/custom_text_field.dart';

import '../app_localizations.dart';
import '../myutils/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final StreamController<String> _oldPasswordStream =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStream =
      StreamController<String>.broadcast();

  final _buttonKey = GlobalKey<CustomIndicatorButtonState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.colorPrimary,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: Dimens.inputScreenPadding,
                  horizontal: Dimens.inputScreenPadding,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.getString(context, "change_password"),
                        style: Styles.boldFontStyle,
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 7,
                    ),
                    CustomTextField(
                      stream: _oldPasswordStream.stream,
                      controller: oldPasswordController,
                      iconData: Icons.vpn_key,
                      label:
                          AppLocalizations.getString(context, "old_password"),
                      passwordField: true,
                      hasPrefixIcon: true,
                      hasSuffixIcon: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    CustomTextField(
                      controller: newPasswordController,
                      iconData: Icons.vpn_key,
                      label:
                          AppLocalizations.getString(context, "new_password"),
                      passwordField: true,
                      hasPrefixIcon: true,
                      hasSuffixIcon: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    CustomTextField(
                      submittable: true,
                      stream: _passwordStream.stream,
                      controller: confirmPasswordController,
                      iconData: Icons.vpn_key,
                      label: AppLocalizations.getString(
                          context, "confirm_password"),
                      passwordField: true,
                      hasPrefixIcon: true,
                      hasSuffixIcon: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 7,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomIndicatorButton(
                        key: _buttonKey,
                        enableIndicator: true,
                        isIcon: false,
                        text: AppLocalizations.getString(
                            context, "change_password"),
                        onPressed: () {
                          bool isValid = true;
                          String oldPassword = oldPasswordController.text;
                          String password = confirmPasswordController.text;
                          String newPassword = newPasswordController.text;
                          if (oldPassword.isEmpty) {
                            _oldPasswordStream.sink
                                .add("Please enter your current password");
                            isValid = false;
                          } else {
                            _oldPasswordStream.sink.add("");
                          }
                          if (newPassword.isEmpty || newPassword.length < 6) {
                            _passwordStream.sink.add(
                                "Please enter password: At least 6 characters long");
                            isValid = false;
                          } else if (password.isEmpty) {
                            _passwordStream.sink
                                .add("Please enter the confirm password");
                            isValid = false;
                          } else if (password != newPassword) {
                            _passwordStream.sink.add(
                                "New Password and Confirm Password did not match");
                            isValid = false;
                          } else {
                            _passwordStream.sink.add("");
                          }
                          if (isValid) {
                            Navigator.pop(context);
                            _buttonKey.currentState?.setSuccess();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
