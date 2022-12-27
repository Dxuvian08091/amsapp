import 'package:flutter/material.dart';
import 'package:amsapp/app_localizations.dart';
import 'package:amsapp/myutils/app_colors.dart';
import 'package:amsapp/myutils/styles.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';

import '../myutils/dimens.dart';

class CustomRequestPopUp extends StatefulWidget {
  const CustomRequestPopUp({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomRequestPopUp> createState() => CustomRequestPopUpState();
}

class CustomRequestPopUpState extends State<CustomRequestPopUp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.normalDimens * 2,
        vertical: Dimens.normalDimens * 2,
      ),
      child: PhysicalModel(
        elevation: Dimens.normalDimens,
        color: AppColors.whitish,
        borderRadius: BorderRadius.circular(Dimens.normalDimens * 3),
        child: SizedBox(
          height: Dimens.normalDimens * 40,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.normalDimens * 2.75),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.getString(
                            context, "you_have_a_ride_request"),
                        style: Styles.boldInfoFontStyle,
                      ),
                      const SizedBox(
                        height: Dimens.normalDimens * 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                radius: Dimens.normalDimens * 3.5,
                                child: Icon(
                                  Icons.person,
                                  size: Dimens.normalDimens * 5,
                                ),
                              ),
                              const SizedBox(
                                width: Dimens.normalDimens,
                              ),
                              SizedBox(
                                height: Dimens.normalDimens * 5,
                                width: Dimens.normalDimens * 15,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        AppLocalizations.getString(
                                          context,
                                          "username",
                                        ),
                                        style: Styles.boldPrimary19,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        AppLocalizations.getString(
                                            context, "mobile_number"),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Flexible(
                            child: SizedBox(
                              height: Dimens.normalDimens * 5,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      AppLocalizations.getString(
                                          context, "fare"),
                                      style: Styles.boldPrimary19,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      AppLocalizations.getString(
                                          context, "distance"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: Dimens.normalDimens * 3,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: Dimens.normalDimens * 5,
                            height: Dimens.normalDimens * 11,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: Dimens.normalDimens * 5.75,
                                    width: Dimens.minimumDimens * 0.85,
                                    color: AppColors.textFieldtxt,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    size: Dimens.normalDimens * 3,
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    Icons.person_pin_circle_outlined,
                                    size: Dimens.normalDimens * 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: Dimens.halfDimens,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: Dimens.normalDimens * 11,
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      height: Dimens.normalDimens * 3.5,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height:
                                                  Dimens.minimumDimens * 0.65,
                                              color: AppColors.textFieldtxt,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right:
                                                      Dimens.normalDimens * 2),
                                              child: Container(
                                                width:
                                                    Dimens.normalDimens * 3.5,
                                                decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  border: Border.all(
                                                    color:
                                                        AppColors.textFieldtxt,
                                                    width: 0.75,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    Dimens.normalDimens,
                                                  ),
                                                ),
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.autorenew_rounded,
                                                    size:
                                                        Dimens.normalDimens * 3,
                                                    color:
                                                        AppColors.textFieldtxt,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: SizedBox(
                                      height: Dimens.normalDimens * 4.5,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              AppLocalizations.getString(
                                                  context, "pickup_point"),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "New Road,Kathmandu",
                                              style: Styles.boldPrimary19,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: SizedBox(
                                      height: Dimens.normalDimens * 4.5,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              AppLocalizations.getString(
                                                  context, "pickout_point"),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              "Kumaripati,Lalitpur",
                                              style: Styles.boldPrimary19,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: Dimens.normalDimens * 5,
                    ),
                    onTap: () {},
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    width: Dimens.normalDimens * 17,
                    child: CustomIndicatorButton(
                      key: null,
                      onPressed: () {},
                      text: AppLocalizations.getString(context, "decline"),
                      enableIndicator: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: Dimens.normalDimens * 17,
                    child: CustomIndicatorButton(
                      key: null,
                      onPressed: () {},
                      text: AppLocalizations.getString(context, "accept"),
                      enableIndicator: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
