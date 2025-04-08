import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class SkeletonWithTitle extends StatelessWidget {
  final String? title;
  const SkeletonWithTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? "", style: AppTextStyles.caption),
        ShimmerBox(height: 24),
      ],
    );
  }
}
