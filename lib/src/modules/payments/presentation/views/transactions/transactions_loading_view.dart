import 'package:base_project/src/modules/payments/presentation/widgets/scroll_indicator_place_holder.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/skeleton_with_title.dart';
import 'package:flutter/material.dart';

class TransactionsLoadingView extends StatelessWidget {
  const TransactionsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SkeletonItem(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const ScrollIndicatorPlaceholder(),
        ],
      ),
    );
  }
}

class SkeletonItem extends StatelessWidget {
  const SkeletonItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      padding: const EdgeInsets.all(8.0),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SkeletonWithTitle(title: "Process date")),
                Expanded(child: SkeletonWithTitle(title: "Amount")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: SkeletonWithTitle(title: "Type")),
                Expanded(child: SkeletonWithTitle()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
