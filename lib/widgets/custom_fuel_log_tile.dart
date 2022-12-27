import 'package:flutter/material.dart';
import 'package:amsapp/myutils/app_colors.dart';
import 'package:amsapp/myutils/styles.dart';

import '../myutils/dimens.dart';

class CustomFuelLogTile extends StatefulWidget {
  final String type;
  final String description;
  final String filled;
  final String location;
  final String date;
  final String registration;
  final String volume;
  final String amount;

  const CustomFuelLogTile({
    Key? key,
    required this.type,
    required this.description,
    required this.filled,
    required this.location,
    required this.date,
    required this.registration,
    required this.volume,
    required this.amount,
  }) : super(key: key);

  @override
  State<CustomFuelLogTile> createState() => CustomFuelLogTileState();
}

class CustomFuelLogTileState extends State<CustomFuelLogTile> {
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
                      Icons.water_drop,
                      color: AppColors.textSecondary,
                      size: Dimens.normalDimens * 3,
                    ),
                    Container(
                      height: Dimens.normalDimens * 1.5,
                      width: Dimens.minimumDimens * 1,
                      color: AppColors.colorPrimary,
                    ),
                    const Icon(
                      Icons.propane_tank_rounded,
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
                        "Fuel Type: ${widget.type}",
                        style: Styles.italicSeconday,
                      ),
                      const SizedBox(
                        height: Dimens.normalDimens * 2,
                      ),
                      Text(
                        "Volume Filled: ${widget.volume}",
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
                      widget.location,
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
                        "${widget.filled} Litres",
                        style: Styles.textSecondary12,
                      ),
                      Text(
                        "Rs. ${widget.amount}",
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
