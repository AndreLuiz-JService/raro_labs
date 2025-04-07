import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  final PaymentsViewType currentViewType;
  final String firstTabTitle;
  final String secondTabTitle;
  final Function(PaymentsViewType) onViewTypeChanged;

  const TabBarWidget({
    super.key,
    required this.currentViewType,
    required this.onViewTypeChanged,
    required this.firstTabTitle,
    required this.secondTabTitle,
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
