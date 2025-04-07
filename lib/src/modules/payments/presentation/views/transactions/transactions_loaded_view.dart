import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';

class TransactionsLoadedView extends StatelessWidget {
  final PaymentsLoaded state;

  const TransactionsLoadedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.paymentsInfo.transactions.isEmpty) {
      return const _EmptyTransactionsView();
    }

    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.paymentsInfo.transactions.length,
          itemBuilder: (context, index) {
            final transaction = state.paymentsInfo.transactions[index];
            return Placeholder();
          },
        ),
      ],
    );
  }
}

class _EmptyTransactionsView extends StatelessWidget {
  const _EmptyTransactionsView();

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
