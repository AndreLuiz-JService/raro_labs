import 'package:equatable/equatable.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object> get props => [];
}

class PaymentsInitial extends PaymentsState {
  const PaymentsInitial();
}

class PaymentsLoading extends PaymentsState {
  final PaymentsViewType viewType;

  const PaymentsLoading({this.viewType = PaymentsViewType.schedule});

  @override
  List<Object> get props => [viewType];
}

class PaymentsLoaded extends PaymentsState {
  final PaymentsInfoEntity paymentsInfo;
  final Map<String, bool> activeFilters;
  final PaymentsViewType viewType;

  const PaymentsLoaded({
    required this.paymentsInfo,
    this.activeFilters = const {},
    this.viewType = PaymentsViewType.schedule,
  });

  PaymentsLoaded copyWith({
    PaymentsInfoEntity? paymentsInfo,
    Map<int, bool>? visibleSchedules,
    Map<String, bool>? activeFilters,
    PaymentsViewType? viewType,
  }) {
    return PaymentsLoaded(
      paymentsInfo: paymentsInfo ?? this.paymentsInfo,
      activeFilters: activeFilters ?? this.activeFilters,
      viewType: viewType ?? this.viewType,
    );
  }

  @override
  List<Object> get props => [paymentsInfo, activeFilters, viewType];
}

class PaymentsError extends PaymentsState {
  final String message;
  final PaymentsViewType viewType;

  const PaymentsError(
    this.message, {
    this.viewType = PaymentsViewType.schedule,
  });

  @override
  List<Object> get props => [message, viewType];
}
