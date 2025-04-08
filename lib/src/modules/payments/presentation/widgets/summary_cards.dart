import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/core/utils/utils.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/presentation.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/skeleton_with_title.dart';
import 'package:flutter/material.dart';

class _SummaryListContainer<T extends Widget> extends StatelessWidget {
  final int itemCount;
  final T Function(int) itemBuilder;
  const _SummaryListContainer({
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 12),
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final isLast = index == itemCount - 1;
          final isFirst = index == 0;

          return Padding(
            padding: EdgeInsets.only(
              left: isFirst ? 12 : 0,
              right: isLast ? 12 : 0,
            ),
            child: itemBuilder(index),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
      ),
    );
  }
}

class SummaryCards extends StatelessWidget {
  final PaymentsState state;
  const SummaryCards({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        final payments = (state as PaymentsLoaded);
        final transactions = payments.paymentsInfo.transactions;
        final paymentsScheduled = payments.paymentsInfo.paymentsScheduled;
        final hasData = transactions.isNotEmpty || paymentsScheduled.isNotEmpty;

        if (!hasData) {
          return const SizedBox.shrink();
        }

        return _SummaryListContainer<_SummaryItem>(
          itemCount: payments.paymentsInfo.summary.length,
          itemBuilder:
              (index) =>
                  _SummaryItem(summary: payments.paymentsInfo.summary[index]),
        );

      case PaymentsLoading():
        return _SummaryListContainer<_SummaryItemSkeleton>(
          itemCount: summaryLabels.length,
          itemBuilder:
              (index) => _SummaryItemSkeleton(title: summaryLabels[index]),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _BaseSummaryCard extends StatelessWidget {
  final Widget child;
  const _BaseSummaryCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final PaymentsSummaryEntity summary;
  const _SummaryItem({required this.summary});

  @override
  Widget build(BuildContext context) {
    return _BaseSummaryCard(
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
  final String title;
  const _SummaryItemSkeleton({required this.title});

  @override
  Widget build(BuildContext context) {
    return _BaseSummaryCard(child: SkeletonWithTitle(title: title));
  }
}

List<String> summaryLabels = [
  "Outstanding",
  "Total Paid",
  "Principal Paid",
  "Interest Paid",
];
