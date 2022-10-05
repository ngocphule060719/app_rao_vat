import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sugitomo/constant.dart';
import 'package:sugitomo/extension/theme_data_ext.dart';
import 'package:sugitomo/ui/extensions/date_time_ext.dart';
import 'package:sugitomo/ui/page/home/models/point/point.dart';
import 'package:sugitomo/ui/page/login/logout_function.dart';
import 'package:sugitomo/ui/router.dart';
import 'package:sugitomo/ui/theme/app_colors.dart';

class DrawerLoginStatus extends ConsumerWidget {
  const DrawerLoginStatus({super.key, required this.point});

  final Point? point;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = L10n.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 8, 0),
              child: Container(
                height: 8,
                width: 8,
                decoration: ShapeDecoration(
                  color: const AppColors.light().mainPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // side: new BorderSide(color: Colors.white)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                l.statusLogin,
                style: TextStyle(
                  fontSize: 16,
                  color: const AppColors.light().textTertiary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.availablePoint,
                style: TextStyle(
                  fontSize: 12,
                  color: const AppColors.light().textTertiary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    point != null
                        ? (point!.availablePoint <= 100000000)
                            ? AppConstant.myFormat.format(point!.availablePoint)
                            : AppConstant.pointLimit
                        : AppConstant.pointError,
                    style: TextStyle(
                      fontSize: 16,
                      color: const AppColors.light().textTertiary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text(
                      l.point,
                      style: TextStyle(
                        fontSize: 12,
                        color: const AppColors.light().textTertiary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l.nextExpirationPoint,
              style: TextStyle(
                fontSize: 12,
                color: const AppColors.light().textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              point != null
                  ? (point!.availablePoint <= 100000000)
                      ? '${AppConstant.myFormat.format(
                          point!.nextExpirationPoint,
                        )}'
                          '${l.point}'
                      : AppConstant.pointLimit
                  : '${AppConstant.pointError}${l.point}',
              style: TextStyle(
                fontSize: 12,
                color: const AppColors.light().textTertiary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.nextExpirationDate,
                style: TextStyle(
                  fontSize: 12,
                  color: const AppColors.light().textTertiary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                point != null
                    ? point!.nextExpirationDate.appFormat
                    : AppConstant.datePointError,
                style: TextStyle(
                  fontSize: 12,
                  color: const AppColors.light().textTertiary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DrawerElement extends StatelessWidget {
  const DrawerElement({
    super.key,
    required this.title,
    this.onTap,
  });

  final Text title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).appColors;
    return InkWell(
      focusColor: Colors.transparent,
      highlightColor: appColors.mainSecondaryPale,
      splashColor: appColors.mainSecondaryPale,
      borderRadius: BorderRadius.circular(5),
      onTap: onTap ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 12, bottom: 12),
            child: title,
          ),
          Icon(
            Icons.navigate_next,
            color: const AppColors.light().mainPrimary,
          )
        ],
      ),
    );
  }
}

class PointChangeButton extends ConsumerWidget {
  const PointChangeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = Theme.of(context).appColors;
    final l = L10n.of(context);
    return Container(
      color: appColors.baseWhite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => PointExchangePageRoute().push(context),
              child: Text(
                l.pointChangeButton,
                style: TextStyle(
                  color: const AppColors.light().mainPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => PointExchangePageRoute().push(context),
              child: Icon(
                Icons.navigate_next,
                color: const AppColors.light().mainPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget logoutButtonWidget(BuildContext context, WidgetRef ref) {
  final l = L10n.of(context);

  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
    child: InkWell(
      onTap: () async {
        await _showLogoutDialog(context, ref);
      },
      child: Text(
        l.logout,
        style: TextStyle(fontSize: 14, color: const AppColors.light().baseRed),
      ),
    ),
  );
}

Future<void> _showLogoutDialog(BuildContext context, WidgetRef ref) async {
  final l = L10n.of(context);
  final appColors = Theme.of(context).appColors;
  final logoutFunction = LogoutFunction();

  final result = await showDialog<bool>(
    context: context,
    builder: (contextDialog) {
      return AlertDialog(
        title: Text(
          l.logoutDialogTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: Text(
          l.logoutDialogContent,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        titlePadding: const EdgeInsets.only(
          top: 25,
          bottom: 5,
          left: 22,
          right: 22,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              l.logoutDialogCancelButton,
              style: TextStyle(
                color: appColors.mainPrimary,
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              l.logoutDialogConfirmButton,
              style: TextStyle(
                color: appColors.mainPrimary,
                fontSize: 12,
              ),
            ),
          ),
        ],
      );
    },
  );

  if (result != null && result) {
    logoutFunction.logout(ref);
  }
}
