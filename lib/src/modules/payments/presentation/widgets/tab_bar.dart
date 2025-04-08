import 'package:base_project/src/core/mixins/mixin.dart';
import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/presentation.dart';
import 'package:base_project/src/modules/payments/presentation/views/filter_modal.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final PaymentsViewType currentViewType;
  final String firstTabTitle;
  final String secondTabTitle;
  final PaymentsState state;
  final Function(PaymentsViewType) onViewTypeChanged;
  final Function(Map<String, bool>) onFiltersChanged;

  const TabBarWidget({
    super.key,
    required this.currentViewType,
    required this.onViewTypeChanged,
    required this.firstTabTitle,
    required this.secondTabTitle,
    required this.state,
    required this.onFiltersChanged,
  });

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with ModalMixin {
  void _showFilterModal(PaymentsLoaded payments) {
    showCustomBottomSheet(
      child: FilterModal(
        filters: payments.paymentsInfo.transactionFilter,
        activeFilters: payments.activeFilters,
        onFiltersChanged: widget.onFiltersChanged,
      ),
      isDismissible: false,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildTabItem(
            title: widget.firstTabTitle,
            viewType: PaymentsViewType.schedule,
            isSelected: widget.currentViewType == PaymentsViewType.schedule,
          ),
          _buildTabItem(
            title: widget.secondTabTitle,
            viewType: PaymentsViewType.transactions,
            isSelected: widget.currentViewType == PaymentsViewType.transactions,
          ),
          _ToggleFilter(
            currentViewType: widget.currentViewType,
            state: widget.state,
            onShowFilterModal: _showFilterModal,
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
        onTap: () => widget.onViewTypeChanged(viewType),
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
  final Function(PaymentsLoaded) onShowFilterModal;

  const _ToggleFilter({
    required this.currentViewType,
    required this.state,
    required this.onShowFilterModal,
  });

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
              onPressed: () => onShowFilterModal(payments),
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
