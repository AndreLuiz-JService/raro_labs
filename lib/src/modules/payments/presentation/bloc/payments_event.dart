import 'package:equatable/equatable.dart';

abstract class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class FetchPayments extends PaymentsEvent {
  const FetchPayments();
}

class RefreshPayments extends PaymentsEvent {
  const RefreshPayments();
}

class FilterPayments extends PaymentsEvent {
  final Map<String, bool> activeFilters;

  const FilterPayments(this.activeFilters);

  @override
  List<Object> get props => [activeFilters];
}

class ToggleScheduleVisibility extends PaymentsEvent {
  final int scheduleId;
  final bool isVisible;

  const ToggleScheduleVisibility({
    required this.scheduleId,
    required this.isVisible,
  });

  @override
  List<Object> get props => [scheduleId, isVisible];
}
