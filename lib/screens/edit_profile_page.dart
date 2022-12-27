import 'dart:async';

import 'package:flutter/material.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/widgets/custom_autocomplete_textfield.dart';
import 'package:amsapp/widgets/custom_dropdown_button.dart';
import 'package:amsapp/widgets/custom_image_selector.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';

import '../app_localizations.dart';
import '../myutils/app_colors.dart';
import '../myutils/data_items.dart';
import '../myutils/route_generator.dart';
import '../myutils/styles.dart';
import '../widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool value = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final StreamController<String> _mobileStream =
      StreamController<String>.broadcast();
  final StreamController<String> _districtStream =
      StreamController<String>.broadcast();
  final StreamController<String> _stateStream =
      StreamController<String>.broadcast();
  // final StreamController<String> _genderStream =
  //     StreamController<String>.broadcast();
  final StreamController<String> _nameStream =
      StreamController<String>.broadcast();
  final StreamController<String> _addressStream =
      StreamController<String>.broadcast();
  final StreamController<String> _emailStream =
      StreamController<String>.broadcast();
  final StreamController<String> _dobStream =
      StreamController<String>.broadcast();

  final StreamController<String> _profileImgStream =
      StreamController<String>.broadcast();

  final _buttonKey = GlobalKey<CustomIndicatorButtonState>();
  final _districtKey = GlobalKey<CustomAutoCompleteTextFieldState>();
  final _stateKey = GlobalKey<CustomAutoCompleteTextFieldState>();
  final _genderKey = GlobalKey<CustomDropDownButtonState>();
  // final _genderKey = GlobalKey<CustomAutoCompleteTextFieldState>();
  final _profileImgKey = GlobalKey<CustomImageSelectorState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void onUpdated(BuildContext context, String resData) {
    Navigator.pushReplacementNamed(context, RouteNames.profilePage);
    _buttonKey.currentState?.setSuccess();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = "Hari Bahadur";
    mobileController.text = "9846664977";
    addressController.text = "Kumaripati";
    emailController.text = "hari.bahadur@gmail.com";
    dobController.text = "09/12/1996";
    String _district = "Kathmandu";
    String _gender = "Male";
    String _state = "Bagmati Province";

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                      heroTag: "btnBack",
                      key: null,
                      mini: true,
                      backgroundColor: AppColors.white,
                      child: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: Dimens.normalDimens * 5,
                        color: AppColors.colorPrimaryLight,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(RouteNames.profilePage);
                      },
                    ),
                    Text(
                      AppLocalizations.getString(context, "edit_profile"),
                      style: Styles.boldInfoFontStyle,
                    ),
                    const SizedBox(
                      width: Dimens.normalDimens * 5,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.inputScreenPadding,
                    ),
                    child: Column(
                      children: [
                        CustomImageSelector(
                          key: _profileImgKey,
                          stream: _profileImgStream.stream,
                          fileId: "profile_picture",
                        ),
                        // const CircleAvatar(
                        //   radius: Dimens.normalDimens * 5,
                        //   backgroundImage: NetworkImage(
                        //       'https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg'),
                        // ),
                        const SizedBox(
                          height: Dimens.normalDimens * 4,
                        ),
                        CustomTextField(
                          stream: _nameStream.stream,
                          controller: nameController,
                          iconData: Icons.person,
                          label: AppLocalizations.getString(context, "name"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        CustomTextField(
                          stream: _mobileStream.stream,
                          controller: mobileController,
                          iconData: Icons.smartphone,
                          label: AppLocalizations.getString(
                              context, "contact_number"),
                          keyboard: TextInputType.number,
                          hasPrefixIcon: true,
                          hasSuffixIcon: false,
                          prefix: AppLocalizations.getString(context, "+977"),
                          maxlength: 10,
                          suffixIcon: null,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomAutoCompleteTextField(
                            key: _stateKey,
                            stream: _stateStream.stream,
                            value: _state,
                            iconData: Icons.location_city,
                            items: stateItems,
                            label:
                                AppLocalizations.getString(context, "province"),
                            width: Dimens.normalDimens * 18,
                            hasBorder: true,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomAutoCompleteTextField(
                            key: _districtKey,
                            stream: _districtStream.stream,
                            value: _district,
                            iconData: Icons.location_city,
                            items: districtItems,
                            label:
                                AppLocalizations.getString(context, "district"),
                            width: Dimens.normalDimens * 18,
                            hasBorder: true,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        CustomTextField(
                          stream: _addressStream.stream,
                          controller: addressController,
                          iconData: Icons.location_city,
                          label: AppLocalizations.getString(context, "address"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          // child: CustomAutoCompleteTextField(
                          //   key: _genderKey,
                          //   stream: _genderStream.stream,
                          //   value: _gender,
                          //   iconData: Icons.person_pin_rounded,
                          //   items: gender_items,
                          //   label:
                          //       AppLocalizations.getString(context, "gender"),
                          //   width: Dimens.normalDimens * 18,
                          // ),
                          child: CustomDropDownButton(
                            key: _genderKey,
                            iconData: Icons.person_pin_rounded,
                            items: genderItems,
                            value: _gender,
                            hasBorder: true,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens * 2,
                        ),
                        CustomTextField(
                          stream: _dobStream.stream,
                          controller: dobController,
                          iconData: Icons.calendar_today_rounded,
                          label: AppLocalizations.getString(context, "dob"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        CustomTextField(
                          stream: _emailStream.stream,
                          controller: emailController,
                          iconData: Icons.email,
                          label: AppLocalizations.getString(context, "email"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),

                        const SizedBox(
                          height: Dimens.normalDimens * 5,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomIndicatorButton(
                            key: _buttonKey,
                            iconData: Icons.arrow_forward,
                            onPressed: () {
                              bool isValid = true;
                              String mobileNo = mobileController.text;
                              String fullName = nameController.text;
                              String address = addressController.text;
                              String district =
                                  '${_districtKey.currentState!.text}';
                              String state = '${_stateKey.currentState!.text}';
                              if (mobileNo.isEmpty ||
                                  !mobileNo.startsWith("9")) {
                                _mobileStream.sink
                                    .add("Please enter valid mobile number");
                                isValid = false;
                              } else {
                                _mobileStream.sink.add("");
                              }

                              if (fullName.isEmpty) {
                                _nameStream.sink
                                    .add("Please enter your full name");
                                isValid = false;
                              } else {
                                _nameStream.sink.add("");
                              }
                              if (address.isEmpty) {
                                _addressStream.sink
                                    .add("Please enter your address/street");
                                isValid = false;
                              } else {
                                _addressStream.sink.add("");
                              }
                              if (!_stateKey.currentState!.valid) {
                                _stateStream.sink
                                    .add("Please enter a valid province");
                                isValid = false;
                              } else {
                                _districtStream.sink.add("");
                              }
                              if (!_districtKey.currentState!.valid) {
                                _districtStream.sink
                                    .add("Please enter a valid district");
                                isValid = false;
                              } else {
                                _districtStream.sink.add("");
                              }
                              if (!_profileImgKey.currentState!.valid) {
                                _profileImgStream.sink.add(
                                    "Please select a file or take a profile picture");
                                isValid = false;
                              } else {
                                _profileImgStream.sink.add("");
                              }
                              if (isValid) {
                                onUpdated(context, "");
                              }
                            },
                            enableIndicator: true,
                            text: AppLocalizations.getString(context, "update"),
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens * 5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
