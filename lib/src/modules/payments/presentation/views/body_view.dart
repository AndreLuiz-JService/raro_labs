import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/transactions/transactions_view.dart';
import 'package:flutter/material.dart';

/// BodyView é um componente de direcionamento que seleciona qual view exibir com base no tipo atual
class BodyView extends StatelessWidget {
  final PaymentsState state;
  final PaymentsViewType viewType;

  const BodyView({super.key, required this.state, required this.viewType});

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case PaymentsViewType.schedule:
        return ScheduleView(state: state);
      case PaymentsViewType.transactions:
        return TransactionsView(state: state);
    }
  }
}
