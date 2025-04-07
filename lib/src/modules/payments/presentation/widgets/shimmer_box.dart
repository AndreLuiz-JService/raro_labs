import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_theme.dart';

class ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;

  const ShimmerBox({super.key, this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer(
        gradient: AppColors.shimmerGradient,
        period: const Duration(seconds: 2),
        loop: 0,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.shimmerGradient.colors.first,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}
