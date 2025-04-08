import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class TransactionsLoadedView extends StatelessWidget {
  final PaymentsLoaded state;

  const TransactionsLoadedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.paymentsInfo.transactions.isEmpty) {
      return const EmptyTransactionsView();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.paymentsInfo.transactions.length,
        itemBuilder: (context, index) {
          final transaction = state.paymentsInfo.transactions[index];
          return TransactionCard(
            transaction: transaction,
            activeFilters: state.activeFilters,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8);
        },
      ),
    );
  }
}

class EmptyTransactionsView extends StatelessWidget {
  const EmptyTransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'Once you begin your payments they will appear',
            children: [
              TextSpan(
                text: '\nhere. This process may take 1-2 business days.',
              ),
            ],
            style: AppTextStyles.bodyRegular.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final PaymentsTransactionsEntity transaction;
  final Map<String, bool> activeFilters;
  const TransactionCard({
    super.key,
    required this.transaction,
    required this.activeFilters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 16) / 2;
          return Wrap(
            spacing: 16,
            children:
                activeFilters.entries.map((entry) {
                  return SizedBox(
                    width: itemWidth,
                    child: TransactionItem(
                      title: entry.key,
                      value:
                          entry.value
                              ? transaction.getValueByLabel(entry.key)
                              : '',
                    ),
                  );
                }).toList(),
          );
        },
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String value;
  const TransactionItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.caption),
          Text(value, style: AppTextStyles.titleRegular),
        ],
      ),
    );
  }
}
