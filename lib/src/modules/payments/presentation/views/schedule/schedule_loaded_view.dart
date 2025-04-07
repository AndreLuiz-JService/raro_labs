import 'package:base_project/src/core/utils/converter_helper.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';

class ScheduleLoadedView extends StatelessWidget {
  final PaymentsLoaded state;

  const ScheduleLoadedView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state.paymentsInfo.paymentsScheduled.isEmpty) {
      return const _EmptyScheduleView();
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.paymentsInfo.paymentsScheduled.length,
      itemBuilder: (context, index) {
        final schedule = state.paymentsInfo.paymentsScheduled[index];
        return _ScheduleItem(schedule: schedule);
      },
    );
  }
}

class _EmptyScheduleView extends StatelessWidget {
  const _EmptyScheduleView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'Once your loan is booked your payment',
            children: [
              TextSpan(
                text: '\nschedule will appear here. This process may take',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              TextSpan(
                text: '\n1-2 business days.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ],
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  final PaymentsScheduledEntity schedule;

  const _ScheduleItem({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ConverterHelper.stringNullableToMMDDYYYY(
                    schedule.paymentDate.toString(),
                  ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ConverterHelper.currencyFormatter(schedule.principal),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
