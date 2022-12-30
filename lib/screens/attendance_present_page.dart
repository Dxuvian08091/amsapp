import 'package:amsapp/models/Attendance.dart';
import 'package:amsapp/webservice/ApiService.dart';
import 'package:amsapp/widgets/CustomAttendanceLogTile.dart';
import 'package:flutter/material.dart';

import '../app_localizations.dart';
import '../myutils/alert_utils.dart';
import '../myutils/app_colors.dart';
import '../myutils/constant.dart';
import '../myutils/dimens.dart';
import '../myutils/preference.dart';
import '../myutils/route_generator.dart';
import '../myutils/styles.dart';
import '../webservice/ResponseWrapper.dart';
import '../widgets/app_drawer.dart';

class AttendancePresentPage extends StatefulWidget {
  const AttendancePresentPage({Key? key}) : super(key: key);

  @override
  State<AttendancePresentPage> createState() => _AttendancePresentPageState();
}

class _AttendancePresentPageState extends State<AttendancePresentPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<CustomAttendanceLogTile> attendanceLogTile =
        <CustomAttendanceLogTile>[];
    ApiProvider()
        .get(ApiProvider.presentApi,
            Preference.getString(Constant.spAccessToken))
        .then((resWrapper) => {
              if (resWrapper.status == ResponseWrapper.COMPLETED)
                {
                  attendanceLogTile = Attendance.decode(resWrapper)
                      .map<CustomAttendanceLogTile>(
                          (item) => CustomAttendanceLogTile(
                                start: item.entry,
                                end: item.exit,
                                date: item.date,
                                startLat: item.startLat,
                                startLong: item.startLong,
                                endLat: item.endLat,
                                endLong: item.endLong,
                                type: item.type,
                                status: item.status,
                              ))
                      .toList()
                }
              else
                {
                  AlertUtils.showSnackBar(context, resWrapper.message),
                }
            });
    return Scaffold(
      drawer: const AppDrawer(),
      key: _scaffoldKey,
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
                    heroTag: 'btmMenu',
                    key: null,
                    mini: true,
                    backgroundColor: AppColors.white,
                    child: const Icon(
                      Icons.menu_rounded,
                      color: AppColors.colorPrimaryLight,
                    ),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
                  Text(
                    AppLocalizations.getString(context, "present_days"),
                    style: Styles.boldInfoFontStyle,
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ApiProvider()
                      .get(ApiProvider.presentApi,
                          Preference.getString(Constant.spAccessToken))
                      .then((resWrapper) => {
                            if (resWrapper.status == ResponseWrapper.COMPLETED)
                              {
                                attendanceLogTile =
                                    Attendance.decode(resWrapper)
                                        .map<CustomAttendanceLogTile>(
                                            (item) => CustomAttendanceLogTile(
                                                  start: item.entry,
                                                  end: item.exit,
                                                  date: item.date,
                                                  startLat: item.startLat,
                                                  startLong: item.startLong,
                                                  endLat: item.endLat,
                                                  endLong: item.endLong,
                                                  type: item.type,
                                                  status: item.status,
                                                ))
                                        .toList()
                              }
                            else
                              {
                                AlertUtils.showSnackBar(
                                    context, resWrapper.message),
                              }
                          });
                },
                child: ListView.builder(
                  itemCount: attendanceLogTile.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: attendanceLogTile.isEmpty
                          ? const SizedBox()
                          : attendanceLogTile[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
