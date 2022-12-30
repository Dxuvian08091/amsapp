import 'dart:convert';

import 'package:amsapp/models/Attendance.dart';
import 'package:amsapp/models/Queue.dart';
import 'package:amsapp/myutils/geolocation_helper.dart';
import 'package:amsapp/myutils/network_connectivity.dart';
import 'package:intl/intl.dart';
import 'package:amsapp/webservice/ApiService.dart';
import 'package:amsapp/widgets/custom_indicator_button.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_localizations.dart';
import '../myutils/alert_utils.dart';
import '../myutils/app_colors.dart';
import '../myutils/constant.dart';
import '../myutils/data_items.dart';
import '../myutils/dimens.dart';
import '../myutils/logger.dart';
import '../myutils/preference.dart';
import '../myutils/route_generator.dart';
import '../myutils/styles.dart';
import '../webservice/ResponseWrapper.dart';
import '../widgets/app_drawer.dart';
import '../widgets/custom_dropdown_button.dart';

class AttendanceFormPage extends StatefulWidget {
  const AttendanceFormPage({Key? key}) : super(key: key);

  @override
  State<AttendanceFormPage> createState() => _AttendanceFormPageState();
}

class _AttendanceFormPageState extends State<AttendanceFormPage> {
  bool started = false;
  Map _source = {ConnectivityResult.none: false};
  final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
  bool isOnline = false;
  bool value = false;
  final _shiftTypeKey = GlobalKey<CustomDropDownButtonState>();
  final _statusKey = GlobalKey<CustomDropDownButtonState>();
  final _startShiftButtonKey = GlobalKey<CustomIndicatorButtonState>();
  final _endShiftButtonKey = GlobalKey<CustomIndicatorButtonState>();
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
    String workStatus = statusItems[0];
    String shiftType = shiftTypeItems[0];
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
                    AppLocalizations.getString(context, "attendance"),
                    style: Styles.boldInfoFontStyle,
                  ),
                  const SizedBox(),
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
                    Align(
                      alignment: Alignment.center,
                      child: CustomDropDownButton(
                        key: _shiftTypeKey,
                        iconData: Icons.work,
                        items: shiftTypeItems,
                        value: shiftType,
                        hasBorder: true,
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 2,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomDropDownButton(
                        key: _statusKey,
                        iconData: Icons.work_history,
                        items: statusItems,
                        value: workStatus,
                        hasBorder: true,
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.normalDimens * 2,
                    ),
                    Visibility(
                      visible: !started,
                      child: CustomIndicatorButton(
                        key: _startShiftButtonKey,
                        onPressed: () async {
                          String date =
                              DateFormat("dd/MM/yyyy").format(DateTime.now());
                          String type = _shiftTypeKey.currentState!.value;
                          String status = _statusKey.currentState!.value;
                          String entry = DateTime.now().toString();
                          String exit = DateTime.now().toString();
                          Future<Map<String, dynamic>> body =
                              GeoLocationHelper.determinePosition().then(
                                  (location) => Attendance(
                                          id: 0,
                                          person: "",
                                          type: type,
                                          date: date,
                                          status: status,
                                          startLat:
                                              location.altitude.toString(),
                                          startLong:
                                              location.longitude.toString(),
                                          endLat: '0',
                                          endLong: '0',
                                          entry: entry,
                                          exit: '0')
                                      .toMap());

                          if (isOnline) {
                            ApiProvider()
                                .postUpdate(
                                    ApiProvider.attendancesApi,
                                    await body,
                                    Preference.getString(
                                        Constant.spAccessToken))
                                .then((resWrapper) => {
                                      if (resWrapper.status ==
                                          ResponseWrapper.COMPLETED)
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setSuccess(),
                                          Logger.printLog(resWrapper.data),
                                        }
                                      else
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setError(),
                                          AlertUtils.showSnackBar(
                                              context, resWrapper.message),
                                        }
                                    });
                          } else {
                            Preference.setString(
                                'attendance', json.encode(body));
                            List<Queue> queueLogs =
                                Queue.decode(Preference.getString('queueLogs'));
                            queueLogs.add(Queue(
                                method: "POST",
                                url: ApiProvider.attendancesApi,
                                id: 0,
                                data: json.encode(body),
                                status: "Pending"));
                            Preference.setString(
                                "queueLogs", Queue.encode(queueLogs));
                          }
                          started = !started;
                        },
                        enableIndicator: true,
                        text:
                            AppLocalizations.getString(context, "start_shift"),
                      ),
                    ),
                    Visibility(
                      visible: started,
                      child: CustomIndicatorButton(
                        key: _startShiftButtonKey,
                        onPressed: () async {
                          Attendance attendance = Attendance.fromJson(
                              Preference.getString('attendance'));
                          String exit = DateTime.now().toString();
                          Future<Map<String, dynamic>> body =
                              GeoLocationHelper.determinePosition().then(
                                  (location) => Attendance(
                                          id: attendance.id,
                                          person: attendance.person,
                                          type: attendance.type,
                                          date: attendance.date,
                                          status: attendance.status,
                                          startLat: attendance.startLat,
                                          startLong: attendance.startLong,
                                          endLat: location.altitude.toString(),
                                          endLong: location.altitude.toString(),
                                          entry: attendance.entry,
                                          exit: exit)
                                      .toMap());

                          if (isOnline) {
                            int id = 0;
                            ApiProvider()
                                .get(
                                    ApiProvider.attendancesApi,
                                    Preference.getString(
                                        Constant.spAccessToken))
                                .then((resWrapper) => {
                                      if (resWrapper.status ==
                                          ResponseWrapper.COMPLETED)
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setSuccess(),
                                          id = Attendance.decode(resWrapper)[0]
                                              .id,
                                          Logger.printLog(resWrapper.data),
                                        }
                                      else
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setError(),
                                          AlertUtils.showSnackBar(
                                              context, resWrapper.message),
                                        }
                                    });
                            ApiProvider()
                                .put(
                                    ApiProvider.attendancesApi,
                                    id,
                                    await body,
                                    Preference.getString(
                                        Constant.spAccessToken))
                                .then((resWrapper) => {
                                      if (resWrapper.status ==
                                          ResponseWrapper.COMPLETED)
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setSuccess(),
                                          Logger.printLog(resWrapper.data),
                                        }
                                      else
                                        {
                                          _startShiftButtonKey.currentState
                                              ?.setError(),
                                          AlertUtils.showSnackBar(
                                              context, resWrapper.message),
                                        }
                                    });
                          } else {
                            List<Queue> queueLogs =
                                Queue.decode(Preference.getString('queueLogs'));
                            queueLogs.add(Queue(
                                method: "PUT",
                                url: ApiProvider.attendancesApi,
                                id: 0, //search by date
                                data: body.toString(),
                                status: "Pending"));
                            Preference.setString(
                                "queueLogs", Queue.encode(queueLogs));
                          }
                          started = !started;
                        },
                        enableIndicator: true,
                        text: AppLocalizations.getString(context, "end_shift"),
                      ),
                    )
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
