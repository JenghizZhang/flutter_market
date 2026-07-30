import 'package:flutter/material.dart';

class ToastUtils {
  static bool _showLoading = false;

  static void showToast(BuildContext context, String? msg) {
    if (_showLoading) {
      return;
    }

    ToastUtils._showLoading = true;

    Future.delayed(Durations.long1, () {
      ToastUtils._showLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        behavior: SnackBarBehavior.floating,
        duration: Durations.long1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(40),
        ),
        content: Text(msg ?? "加载成功", textAlign: TextAlign.center),
      ),
    );
  }
}
