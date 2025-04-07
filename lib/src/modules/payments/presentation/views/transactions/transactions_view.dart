import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loaded_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_loading_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/shared/error_view.dart';
import 'package:flutter/material.dart';

class TransactionsView extends StatelessWidget {
  final PaymentsState state;

  const TransactionsView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        return TransactionsLoadedView(state: state as PaymentsLoaded);
      case PaymentsLoading():
        return const TransactionsLoadingView();
      case PaymentsError():
        return ErrorView(message: (state as PaymentsError).message);
      default:
        return const Center(
          child: Text(
            'Initializing transactions data...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        );
    }
  }
}
