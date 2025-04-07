import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_loaded_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_loading_view.dart';
import 'package:base_project/src/modules/payments/presentation/views/shared/error_view.dart';
import 'package:flutter/material.dart';

class ScheduleView extends StatelessWidget {
  final PaymentsState state;

  const ScheduleView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        return ScheduleLoadedView(state: state as PaymentsLoaded);
      case PaymentsLoading():
        return const ScheduleLoadingView();
      case PaymentsError():
        return ErrorView(message: (state as PaymentsError).message);
      default:
        return const Center(
          child: Text(
            'Initializing schedule data...',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        );
    }
  }
}
