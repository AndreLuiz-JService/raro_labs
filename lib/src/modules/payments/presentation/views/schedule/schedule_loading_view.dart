import 'package:base_project/src/modules/payments/presentation/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class ScheduleLoadingView extends StatelessWidget {
  const ScheduleLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(
          4,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: SkeletonItem(),
          ),
        ),
      ),
    );
  }
}

class SkeletonItem extends StatelessWidget {
  const SkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: ShimmerBox(height: 56)),
          const SizedBox(width: 16),
          Expanded(child: ShimmerBox(height: 56)),
        ],
      ),
    );
  }
}
