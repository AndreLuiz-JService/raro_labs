import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/presentation.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final PaymentsViewType currentViewType;
  final String firstTabTitle;
  final String secondTabTitle;
  final PaymentsState state;
  final Function(PaymentsViewType) onViewTypeChanged;

  const TabBarWidget({
    super.key,
    required this.currentViewType,
    required this.onViewTypeChanged,
    required this.firstTabTitle,
    required this.secondTabTitle,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _buildTabItem(
            title: firstTabTitle,
            viewType: PaymentsViewType.schedule,
            isSelected: currentViewType == PaymentsViewType.schedule,
          ),
          _buildTabItem(
            title: secondTabTitle,
            viewType: PaymentsViewType.transactions,
            isSelected: currentViewType == PaymentsViewType.transactions,
          ),
          _ToggleFilter(currentViewType: currentViewType, state: state),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required String title,
    required PaymentsViewType viewType,
    required bool isSelected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onViewTypeChanged(viewType),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.success : AppColors.lightGrey,
                width: isSelected ? 2 : 1,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: isSelected ? AppTextStyles.body : AppTextStyles.bodyLight,
          ),
        ),
      ),
    );
  }
}

class _ToggleFilter extends StatelessWidget {
  final PaymentsViewType currentViewType;
  final PaymentsState state;

  const _ToggleFilter({required this.currentViewType, required this.state});

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PaymentsLoaded():
        final payments = (state as PaymentsLoaded);
        final paymentsViewType = payments.viewType;
        final paymentsInfo = payments.paymentsInfo;
        if (paymentsViewType == PaymentsViewType.schedule) {
          return paymentsInfo.paymentsScheduled.isNotEmpty
              ? IconButton(
                onPressed: null,
                icon: Icon(Icons.more_vert, color: AppColors.grey),
              )
              : const SizedBox.shrink();
        }

        return paymentsInfo.transactions.isNotEmpty
            ? IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_vert, color: AppColors.textPrimary),
            )
            : const SizedBox.shrink();

      case PaymentsLoading():
        return const Icon(Icons.more_vert, color: AppColors.grey);
      default:
        return const SizedBox.shrink();
    }
  }
}
