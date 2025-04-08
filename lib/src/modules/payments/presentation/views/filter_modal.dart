import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:base_project/src/core/theme/app_theme.dart';

class FilterModal extends StatefulWidget {
  final List<PaymentsTransactionFilterEntity> filters;
  final Map<String, bool> activeFilters;
  final Function(Map<String, bool>) onFiltersChanged;

  const FilterModal({
    super.key,
    required this.filters,
    required this.activeFilters,
    required this.onFiltersChanged,
  });

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late Map<String, bool> selectedFilters;

  @override
  void initState() {
    super.initState();
    selectedFilters = Map.from(widget.activeFilters);
  }

  void _handleFilterChange(String key, bool value, bool isDefault) {
    if (isDefault) return;

    setState(() {
      selectedFilters[key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = widget.filters;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Additional information',
                  style: AppTextStyles.titleLight,
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    widget.onFiltersChanged(selectedFilters);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = selectedFilters[filter.label] ?? false;
                final isDefault = filter.isDefault;
                final icon =
                    isSelected
                        ? Icon(
                          Icons.check_rounded,
                          size: 20,
                          color: AppColors.white,
                        )
                        : null;

                final borderColor =
                    isDefault
                        ? AppColors.grey
                        : isSelected
                        ? AppColors.successDark
                        : AppColors.textSecondary;

                final backgroundColor =
                    isDefault
                        ? AppColors.grey
                        : isSelected
                        ? AppColors.success
                        : Colors.transparent;

                return InkWell(
                  onTap: () {
                    _handleFilterChange(filter.label, !isSelected, isDefault);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: borderColor, width: 2),
                            color: backgroundColor,
                          ),
                          child: icon,
                        ),
                        const SizedBox(width: 12),
                        Text(filter.label, style: AppTextStyles.titleRegular),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
