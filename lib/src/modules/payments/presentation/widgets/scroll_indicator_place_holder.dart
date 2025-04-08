import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ScrollIndicatorPlaceholder extends StatelessWidget {
  const ScrollIndicatorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 32,
      margin: const EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: AppColors.greyIndicator,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
