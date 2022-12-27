import 'package:amsapp/myutils/geolocation_helper.dart';
import 'package:amsapp/myutils/location_helper.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';
import 'package:flutter/material.dart';

import '../myutils/app_colors.dart';
import '../myutils/logger.dart';

class AttendanceFormPage extends StatefulWidget {
  const AttendanceFormPage({Key? key}) : super(key: key);

  @override
  State<AttendanceFormPage> createState() => _AttendanceFormPageState();
}

class _AttendanceFormPageState extends State<AttendanceFormPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: CustomIndicatorButton(
            onPressed: () {
              double latitude = 0;
              double longitude = 0;
              GeoLocationHelper.determinePosition().then((value) => {
                    GeoLocationHelper.determinePosition().then((value) =>
                        Logger.printLog(
                            'latitude: ${value.latitude}, longitude: ${value.longitude}, time stamp: ${value.timestamp}')),
                    latitude = value.longitude,
                    longitude = value.longitude,
                  });
              GeoLocationHelper.getAddressFromLatLng(
                      latitude: latitude, longitude: longitude)
                  .then((value) => Logger.printLog(value));
            },
          ),
        ),
      ),
    );
  }
}
