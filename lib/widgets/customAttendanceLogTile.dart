import 'package:flutter/material.dart';

import '../myutils/app_colors.dart';
import '../myutils/dimens.dart';
import '../myutils/styles.dart';

class CustomAttendanceLogTile extends StatefulWidget {
  final String date;
  final String start;
  final String end;
  final String startLat;
  final String startLong;
  final String endLat;
  final String endLong;
  final String type;
  final String status;
  const CustomAttendanceLogTile(
      {super.key,
      required this.date,
      required this.start,
      required this.end,
      required this.startLat,
      required this.startLong,
      required this.endLat,
      required this.endLong,
      required this.type,
      required this.status});

  @override
  State<CustomAttendanceLogTile> createState() =>
      _CustomAttendanceLogTileState();
}

class _CustomAttendanceLogTileState extends State<CustomAttendanceLogTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Dimens.minimumDimens,
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.normalDimens),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.normalDimens,
          vertical: Dimens.halfDimens * 3,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    const Icon(
                      Icons.last_page,
                      color: AppColors.textSecondary,
                      size: Dimens.normalDimens * 3,
                    ),
                    Container(
                      height: Dimens.normalDimens * 1.5,
                      width: Dimens.minimumDimens * 1,
                      color: AppColors.colorPrimary,
                    ),
                    const Icon(
                      Icons.first_page,
                      color: AppColors.textSecondary,
                      size: Dimens.normalDimens * 3,
                    ),
                  ],
                ),
                const SizedBox(
                  width: Dimens.normalDimens,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start: ${widget.start}, Coordinates: ${widget.startLat}, ${widget.startLong}',
                        style: Styles.italicSeconday,
                      ),
                      const SizedBox(
                        height: Dimens.normalDimens * 2,
                      ),
                      Text(
                        'End: ${widget.end}, Coordinates: ${widget.endLat}, ${widget.endLong}',
                        style: Styles.italicSeconday,
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.date,
                  textAlign: TextAlign.center,
                  style: Styles.textSecondary12,
                )
              ],
            ),
            const SizedBox(
              height: Dimens.halfDimens * 3,
            ),
            const Divider(
              height: 1,
            ),
            const SizedBox(
              height: Dimens.halfDimens * 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.type,
                      style: Styles.semiBoldNormalFontStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.status,
                      style: Styles.textSecondary12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        '',
                        style: Styles.textSecondary12,
                      ),
                      Text(
                        '',
                        style: Styles.titleFontStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
