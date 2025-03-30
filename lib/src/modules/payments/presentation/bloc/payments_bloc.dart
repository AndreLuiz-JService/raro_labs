import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/src/core/base/base.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final GetPaymentsUseCase _getPaymentsUseCase;

  PaymentsBloc(this._getPaymentsUseCase) : super(const PaymentsInitial()) {
    on<FetchPayments>(_onFetchPayments);
    on<RefreshPayments>(_onRefreshPayments);
    on<FilterPayments>(_onFilterPayments);
    on<ToggleScheduleVisibility>(_onToggleScheduleVisibility);
  }

  Future<void> _onFetchPayments(
    FetchPayments event,
    Emitter<PaymentsState> emit,
  ) async {
    emit(const PaymentsLoading());

    final result = await _getPaymentsUseCase(NoParams());

    result.fold(
      (failure) => emit(PaymentsError(failure.message)),
      (paymentsInfo) => emit(PaymentsLoaded(paymentsInfo: paymentsInfo)),
    );
  }

  Future<void> _onRefreshPayments(
    RefreshPayments event,
    Emitter<PaymentsState> emit,
  ) async {
    if (state is PaymentsLoaded) {
      final currentState = state as PaymentsLoaded;

      final result = await _getPaymentsUseCase(NoParams());

      result.fold(
        (failure) => emit(PaymentsError(failure.message)),
        (paymentsInfo) =>
            emit(currentState.copyWith(paymentsInfo: paymentsInfo)),
      );
    } else {
      add(const FetchPayments());
    }
  }

  void _onFilterPayments(FilterPayments event, Emitter<PaymentsState> emit) {
    if (state is PaymentsLoaded) {
      final currentState = state as PaymentsLoaded;
      emit(currentState.copyWith(activeFilters: event.activeFilters));
    }
  }

  void _onToggleScheduleVisibility(
    ToggleScheduleVisibility event,
    Emitter<PaymentsState> emit,
  ) {
    if (state is PaymentsLoaded) {
      final currentState = state as PaymentsLoaded;
      final updatedVisibility = Map<int, bool>.from(
        currentState.visibleSchedules,
      );

      updatedVisibility[event.scheduleId] = event.isVisible;

      emit(currentState.copyWith(visibleSchedules: updatedVisibility));
    }
  }
}
