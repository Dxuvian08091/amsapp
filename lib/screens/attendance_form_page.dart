import 'package:amsapp/myutils/geolocation_helper.dart';
import 'package:amsapp/myutils/network_connectivity.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../myutils/app_colors.dart';
import '../myutils/logger.dart';
import '../myutils/preference.dart';

class AttendanceFormPage extends StatefulWidget {
  const AttendanceFormPage({Key? key}) : super(key: key);

  @override
  State<AttendanceFormPage> createState() => _AttendanceFormPageState();
}

class _AttendanceFormPageState extends State<AttendanceFormPage> {
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = false;
  bool value = false;
  final TextEditingController typeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _networkConnectivity.initialize();
    _networkConnectivity.myStream.listen((source) {
      _source = source;
      if (kDebugMode) {
        print('source $_source');
      }

      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          isOnline = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.wifi:
          isOnline = _source.values.toList()[0] ? true : false;
          break;
        case ConnectivityResult.none:
        default:
          isOnline = false;
      }
      Preference.setBool('isOnline', isOnline);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    super.dispose();
  }

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
                    GeoLocationHelper.getAddressFromLatLng(
                            latitude: latitude, longitude: longitude)
                        .then((value) => Logger.printLog(value)),
                  });
            },
          ),
        ),
      ),
    );
  }
}
