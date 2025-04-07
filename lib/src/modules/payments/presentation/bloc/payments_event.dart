import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
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

class ChangeViewType extends PaymentsEvent {
  final PaymentsViewType viewType;

  const ChangeViewType(this.viewType);

  @override
  List<Object> get props => [viewType];
}
