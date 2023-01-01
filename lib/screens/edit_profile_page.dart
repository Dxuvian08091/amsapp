import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amsapp/myutils/dimens.dart';
import 'package:amsapp/widgets/custom_autocomplete_textfield.dart';
import 'package:amsapp/widgets/custom_dropdown_button.dart';
import 'package:amsapp/widgets/custom_image_selector.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';

import '../app_localizations.dart';
import '../models/person.dart';
import '../myutils/alert_utils.dart';
import '../myutils/app_colors.dart';
import '../myutils/constant.dart';
import '../myutils/data_items.dart';
import '../myutils/logger.dart';
import '../myutils/preference.dart';
import '../myutils/route_generator.dart';
import '../myutils/styles.dart';
import '../webservice/ApiService.dart';
import '../webservice/ResponseWrapper.dart';
import '../widgets/custom_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool value = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final StreamController<String> _firstNameStream =
      StreamController<String>.broadcast();
  final StreamController<String> _middleNameStream =
      StreamController<String>.broadcast();
  final StreamController<String> _lastNameStream =
      StreamController<String>.broadcast();
  final StreamController<String> _mobileStream =
      StreamController<String>.broadcast();
  final StreamController<String> _districtStream =
      StreamController<String>.broadcast();
  final StreamController<String> _stateStream =
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
  final _bloodGroupKey = GlobalKey<CustomDropDownButtonState>();
  final _profileImgKey = GlobalKey<CustomImageSelectorState>();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Person user;
    ApiProvider()
        .get(ApiProvider.personsApi,
            Preference.getString(Constant.spAccessToken))
        .then((resWrapper) => {
              user = Person.fromJson(jsonDecode(resWrapper)[0]),
              Preference.setInt('id', user.id),
              Preference.setString('username', user.username),
              Preference.setString('role', user.role),
              Preference.setString('firstName', user.firstName),
              Preference.setString('middleName', user.middleName),
              Preference.setString('lastName', user.lastName),
              Preference.setString('gender', user.gender),
              Preference.setString('dob', user.dob),
              Preference.setString('state', user.state),
              Preference.setString('district', user.district),
              Preference.setString('email', user.email),
              Preference.setString('contactNo', user.contactNumber),
              Preference.setString('address', user.address),
              Preference.setString('bloodGroup', user.bloodGroup),
              Preference.setString('profilePicuture', user.profilePicture),
            });
  }

  void onUpdated(BuildContext context, Map<String, dynamic> resData) {
    ApiProvider()
        .put(ApiProvider.personsApi, Preference.getInt('id'), resData,
            Preference.getString(Constant.spAccessToken))
        .then((resWrapper) => {
              if (resWrapper.status == ResponseWrapper.COMPLETED)
                {
                  _buttonKey.currentState?.setSuccess(),
                  Logger.printLog(resWrapper.data),
                  Navigator.pushReplacementNamed(
                      context, RouteNames.profilePage),
                }
              else
                {
                  _buttonKey.currentState?.setError(),
                  AlertUtils.showSnackBar(context, resWrapper.message),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    String username = Preference.getString('username');
    String role = Preference.getString('role');
    String firstName = Preference.getString('firstName');
    String middleName = Preference.getString('middleName');
    String lastName = Preference.getString('lastName');
    String gender = Preference.getString('gender');
    String dob = Preference.getString('dob');
    String state = Preference.getString('state');
    String district = Preference.getString('district');
    String email = Preference.getString('email');
    String contactNo = Preference.getString('contactNo');
    String address = Preference.getString('address');
    String bloodGroup = Preference.getString('bloodGroup');
    String profilePicture = Preference.getString('profilePicuture');

    firstNameController.text = firstName;
    middleNameController.text = middleName;
    lastNameController.text = lastName;
    dobController.text = dob;
    emailController.text = email;
    mobileController.text = contactNo;
    addressController.text = address;
    _profileImgKey.currentState!.filePath = profilePicture;

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
                        Navigator.of(context).pushNamed(RouteNames.loginPage);
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
                          stream: _firstNameStream.stream,
                          controller: firstNameController,
                          iconData: Icons.person,
                          label:
                              AppLocalizations.getString(context, "first_name"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        CustomTextField(
                          stream: _middleNameStream.stream,
                          controller: middleNameController,
                          iconData: Icons.tag,
                          label: AppLocalizations.getString(
                              context, "middle_name"),
                          hasPrefixIcon: true,
                          hasBorder: true,
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens,
                        ),
                        CustomTextField(
                          stream: _lastNameStream.stream,
                          controller: lastNameController,
                          iconData: Icons.tag,
                          label:
                              AppLocalizations.getString(context, "last_name"),
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
                            value: state,
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
                            value: district,
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
                            value: gender,
                            hasBorder: true,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens * 2,
                        ),
                        TextField(
                          controller: dobController,
                          decoration: InputDecoration(
                            prefixIconConstraints:
                                const BoxConstraints(minWidth: 0, minHeight: 0),
                            counter: const Offstage(),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: AppColors.white,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  left: Dimens.normalDimens * 3,
                                  right: Dimens.normalDimens),
                              child: Icon(Icons.calendar_month),
                            ),
                            isDense: true,
                            labelText:
                                AppLocalizations.getString(context, "dob"),
                            labelStyle: Styles.labelFontStyle,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldtxt),
                              borderRadius: BorderRadius.circular(
                                  Dimens.normalDimens * 6.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: AppColors.textFieldtxt),
                              borderRadius: BorderRadius.circular(
                                  Dimens.normalDimens * 6.0),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2000),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                dobController.text =
                                    DateFormat("dd/MM/yyyy").format(pickedDate);
                              });
                            }
                          },
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
                            key: _bloodGroupKey,
                            iconData: Icons.water_drop_outlined,
                            items: bloodGroupItems,
                            value: bloodGroup,
                            hasBorder: true,
                          ),
                        ),
                        const SizedBox(
                          height: Dimens.normalDimens * 2,
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
                              String firstName = firstNameController.text;
                              String middleName = middleNameController.text;
                              String lastName = lastNameController.text;
                              String mobileNo = mobileController.text;
                              String dob = dobController.text;
                              String email = emailController.text;
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
                              if (firstName.isEmpty) {
                                _firstNameStream.sink
                                    .add("Please enter your first name");
                                isValid = false;
                              } else {
                                _firstNameStream.sink.add("");
                              }
                              if (lastName.isEmpty) {
                                _lastNameStream.sink
                                    .add("Please enter your last name");
                                isValid = false;
                              } else {
                                _lastNameStream.sink.add("");
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
                                onUpdated(
                                    context,
                                    (Person(
                                            user: '',
                                            created: '',
                                            id: 0,
                                            role: 'Staff',
                                            username: '',
                                            firstName: firstName,
                                            middleName: middleName,
                                            lastName: lastName,
                                            gender:
                                                _genderKey.currentState!.value,
                                            dob: dob,
                                            email: email,
                                            contactNumber: mobileNo,
                                            address: address,
                                            state: state,
                                            district: district,
                                            bloodGroup: _bloodGroupKey
                                                .currentState!.value,
                                            profilePicture: _profileImgKey
                                                .currentState!.filePath)
                                        .toMap()));
                              }
                            },
                            enableIndicator: true,
                            text: AppLocalizations.getString(context, "create"),
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
