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
  const PaymentsLoading();
}

class PaymentsLoaded extends PaymentsState {
  final PaymentsInfoEntity paymentsInfo;
  final Map<int, bool> visibleSchedules;
  final Map<String, bool> activeFilters;

  const PaymentsLoaded({
    required this.paymentsInfo,
    this.visibleSchedules = const {},
    this.activeFilters = const {},
  });

  PaymentsLoaded copyWith({
    PaymentsInfoEntity? paymentsInfo,
    Map<int, bool>? visibleSchedules,
    Map<String, bool>? activeFilters,
  }) {
    return PaymentsLoaded(
      paymentsInfo: paymentsInfo ?? this.paymentsInfo,
      visibleSchedules: visibleSchedules ?? this.visibleSchedules,
      activeFilters: activeFilters ?? this.activeFilters,
    );
  }

  @override
  List<Object> get props => [paymentsInfo, visibleSchedules, activeFilters];
}

class PaymentsError extends PaymentsState {
  final String message;

  const PaymentsError(this.message);

  @override
  List<Object> get props => [message];
}
