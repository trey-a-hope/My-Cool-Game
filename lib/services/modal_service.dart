import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

class ModalService {
  void showToast({
    required String title,
    required ToastificationType type,
    Widget? icon,
  }) =>
      Toastification().show(
        type: type,
        title: Text(title),
        icon: icon,
        autoCloseDuration: const Duration(seconds: 3),
        showProgressBar: false,
        closeButtonShowType: CloseButtonShowType.none,
      );
}
