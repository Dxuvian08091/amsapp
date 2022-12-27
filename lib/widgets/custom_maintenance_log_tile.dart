import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';
import 'package:amsapp/myutils/styles.dart';

import '../myutils/dimens.dart';

class CustomMaintenanceLogTile extends StatefulWidget {
  final String part;
  final String description;
  final String date;
  final String name;
  final String charge;
  final String registration;
  final String volume;
  const CustomMaintenanceLogTile({
    Key? key,
    required this.part,
    required this.description,
    required this.date,
    required this.name,
    required this.charge,
    required this.registration,
    required this.volume,
  }) : super(key: key);

  @override
  State<CustomMaintenanceLogTile> createState() => CustomTripListTileState();
}

class CustomTripListTileState extends State<CustomMaintenanceLogTile> {
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
                      Icons.home_repair_service_rounded,
                      color: AppColors.textSecondary,
                      size: Dimens.normalDimens * 3,
                    ),
                    Container(
                      height: Dimens.normalDimens * 1.5,
                      width: Dimens.minimumDimens * 1,
                      color: AppColors.colorPrimary,
                    ),
                    const Icon(
                      Icons.info_outline,
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
                        widget.part,
                        style: Styles.italicSeconday,
                      ),
                      const SizedBox(
                        height: Dimens.normalDimens * 2,
                      ),
                      Text(
                        widget.description,
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
                      widget.name,
                      style: Styles.semiBoldNormalFontStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.registration,
                      style: Styles.textSecondary12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.volume,
                        style: Styles.textSecondary12,
                      ),
                      Text(
                        widget.charge,
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
