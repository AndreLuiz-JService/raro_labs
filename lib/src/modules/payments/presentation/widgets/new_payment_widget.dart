import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/presentation.dart';
import 'package:flutter/material.dart';

class NewPaymentWidget extends StatelessWidget {
  final PaymentsState state;
  const NewPaymentWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        final payments = (state as PaymentsLoaded);
        final paymentsViewType = payments.viewType;
        final paymentsInfo = payments.paymentsInfo;

        if (paymentsViewType == PaymentsViewType.schedule) {
          return paymentsInfo.paymentsScheduled.isNotEmpty
              ? _buildNewPaymentWidget()
              : const SizedBox.shrink();
        }

        return paymentsInfo.transactions.isNotEmpty
            ? _buildNewPaymentWidget()
            : const SizedBox.shrink();
      case PaymentsError():
        return const SizedBox.shrink();
      default:
        return _buildNewPaymentWidget(labelColor: AppColors.grey);
    }
  }

  _buildNewPaymentWidget({Color labelColor = AppColors.successDark}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(
          text: 'Do you want to make a payment?',
          style: AppTextStyles.titleRegular,
          children: [
            TextSpan(
              text: ' Click here',
              style: AppTextStyles.titleRegular.copyWith(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}
