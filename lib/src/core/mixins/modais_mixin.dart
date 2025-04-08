import 'package:flutter/material.dart';

mixin ModalMixin<T extends StatefulWidget> on State<T> {
  Future<T?> showCustomDialog({
    required Widget child,
    bool barrierDismissible = true,
    Color? barrierColor,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      builder: (context) => child,
    );
  }

  Future<T?> showCustomBottomSheet({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
    double? elevation,
    ShapeBorder? shape,
    bool isScrollControlled = false,
    bool useSafeArea = true,
    RouteSettings? routeSettings,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      elevation: elevation,
      shape: shape,
      isScrollControlled: isScrollControlled,
      useSafeArea: useSafeArea,
      routeSettings: routeSettings,
      builder: (context) => child,
    );
  }
}
