import 'package:base_project/src/core/theme/app_theme.dart';
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
        final schedule = state.paymentsInfo.paymentsScheduledSorted[index];
        final isNextPayment = index == 0;
        return _ScheduleItem(schedule: schedule, isNextPayment: isNextPayment);
      },
    );
  }
}

class _EmptyScheduleView extends StatelessWidget {
  const _EmptyScheduleView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'Once your loan is booked your payment',
            children: [
              TextSpan(
                text: '\nschedule will appear here. This process may take',
              ),
              TextSpan(text: '\n1-2 business days.'),
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

class _ScheduleItem extends StatelessWidget {
  final PaymentsScheduledEntity schedule;
  final bool isNextPayment;

  const _ScheduleItem({required this.schedule, required this.isNextPayment});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                ConverterHelper.stringNullableToMMDDYYYY(
                  schedule.paymentDate.toString(),
                ),
                style: AppTextStyles.dialogBody,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ConverterHelper.currencyFormatter(schedule.interest),
                    style: AppTextStyles.dialogBody,
                  ),
                  const SizedBox(width: 16),

                  Visibility(
                    visible: isNextPayment,
                    child: Container(
                      width: 54,
                      height: 24,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryShadow,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Next',
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
