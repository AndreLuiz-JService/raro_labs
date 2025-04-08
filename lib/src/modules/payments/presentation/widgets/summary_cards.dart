import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/core/utils/utils.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/presentation.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';

class SummaryCards extends StatelessWidget {
  final PaymentsState state;
  const SummaryCards({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        final payments = (state as PaymentsLoaded);
        final hasData = payments.paymentsInfo.summary.isNotEmpty;

        if (!hasData) {
          return const SizedBox.shrink();
        }

        return Container(
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          height: 74,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: payments.paymentsInfo.summary.length,
            itemBuilder: (context, index) {
              final isLast = index == payments.paymentsInfo.summary.length - 1;
              final isFirst = index == 0;

              final summary = payments.paymentsInfo.summary[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 12 : 0,
                  right: isLast ? 12 : 0,
                ),
                child: _SummaryItem(summary: summary),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
          ),
        );

      case PaymentsLoading():
        return Container(
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          height: 74,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final isLast = index == 2;
              final isFirst = index == 0;
              return Padding(
                padding: EdgeInsets.only(
                  left: isFirst ? 12 : 0,
                  right: isLast ? 12 : 0,
                ),
                child: const _SummaryItemSkeleton(),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _SummaryItem extends StatelessWidget {
  final PaymentsSummaryEntity summary;
  const _SummaryItem({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(summary.label, style: AppTextStyles.caption),
          Text(
            ConverterHelper.currencyFormatter(summary.value),
            style: AppTextStyles.titleRegular,
          ),
        ],
      ),
    );
  }
}

class _SummaryItemSkeleton extends StatelessWidget {
  const _SummaryItemSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerBox(width: 80, height: 12),
          const SizedBox(height: 4),
          ShimmerBox(width: 112, height: 24),
        ],
      ),
    );
  }
}
