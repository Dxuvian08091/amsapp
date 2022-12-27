import 'dart:async';
import 'dart:convert';

import 'package:amsapp/myutils/alert_utils.dart';
import 'package:amsapp/myutils/constant.dart';
import 'package:amsapp/webservice/ApiService.dart';
import 'package:amsapp/webservice/ResponseWrapper.dart';
import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/myutils/styles.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';

import '../app_localizations.dart';
import '../myutils/app_colors.dart';
import '../myutils/logger.dart';
import '../myutils/preference.dart';
import '../myutils/route_generator.dart';
import '../widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<CustomIndicatorButtonState> _buttonKey =
      GlobalKey<CustomIndicatorButtonState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final StreamController<String> _usernameStream =
      StreamController<String>.broadcast();
  final StreamController<String> _passwordStream =
      StreamController<String>.broadcast();

  void onLogin(BuildContext context, String data) {
    dynamic resMap = jsonDecode(data);
    Preference.setString(Constant.spAccessToken, resMap["access"].toString());
    Preference.setString(Constant.spRefreshToken, resMap["refresh"].toString());
    Preference.setBool(Constant.spIsLogin, true);
    Logger.printLog(
        "access: ${Preference.getBool(Constant.spAccessToken).toString()}");
    Logger.printLog(
        "refresh: ${Preference.getBool(Constant.spRefreshToken).toString()}");
    _buttonKey.currentState?.setSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.getString(context, "welcome"),
                      textAlign: TextAlign.left,
                      style: Styles.boldFontStyle,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    Text(
                      AppLocalizations.getString(context, "login_to_continue"),
                      textAlign: TextAlign.left,
                      style: Styles.infoFontStyle,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 7,
                    ),
                    CustomTextField(
                      stream: _usernameStream.stream,
                      controller: _usernameController,
                      iconData: Icons.person,
                      label: AppLocalizations.getString(context, "username"),
                      hasPrefixIcon: true,
                      hasSuffixIcon: false,
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens,
                    ),
                    CustomTextField(
                      stream: _passwordStream.stream,
                      controller: _passwordController,
                      iconData: Icons.vpn_key,
                      label: AppLocalizations.getString(context, "password"),
                      passwordField: true,
                      hasPrefixIcon: true,
                      hasSuffixIcon: false,
                      suffixIcon: null,
                      submittable: true,
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 7,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomIndicatorButton(
                        key: _buttonKey,
                        iconData: Icons.arrow_forward,
                        onPressed: () {
                          bool isValid = true;
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          if (username.isEmpty) {
                            _usernameStream.sink
                                .add("Please enter your username");
                            isValid = false;
                          } else {
                            _usernameStream.sink.add("");
                          }
                          if (password.isEmpty) {
                            _passwordStream.sink
                                .add("Please enter your password");
                            isValid = false;
                          } else {
                            _passwordStream.sink.add("");
                          }
                          if (isValid) {
                            _buttonKey.currentState?.setLoading();

                            Map<String, String> body = {
                              "username": username,
                              "password": password
                            };

                            ApiProvider()
                                .post(ApiProvider.loginApi, body)
                                .then((resWrapper) => {
                                      if (resWrapper.status ==
                                          ResponseWrapper.COMPLETED)
                                        {
                                          _buttonKey.currentState?.setSuccess(),
                                          Logger.printLog(resWrapper.data),
                                          onLogin(context, resWrapper.data),
                                        }
                                      else
                                        {
                                          _buttonKey.currentState?.setError(),
                                          AlertUtils.showSnackBar(
                                              context, resWrapper.message),
                                        }
                                    });
                            Navigator.pushReplacementNamed(
                                context, RouteNames.attendanceFormPage);
                          }
                        },
                        enableIndicator: true,
                        text: AppLocalizations.getString(context, "login"),
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
