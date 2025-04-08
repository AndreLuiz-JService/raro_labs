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
    on<ChangeViewType>(_onChangeViewType);
  }

  Future<void> _onFetchPayments(
    FetchPayments event,
    Emitter<PaymentsState> emit,
  ) async {
    // Preserva o tipo de visualização atual se existir
    final currentViewType =
        state is PaymentsLoaded
            ? (state as PaymentsLoaded).viewType
            : PaymentsViewType.schedule;

    emit(PaymentsLoading(viewType: currentViewType));

    final result = await _getPaymentsUseCase(NoParams());

    result.fold(
      (failure) =>
          emit(PaymentsError(failure.message, viewType: currentViewType)),
      (paymentsInfo) {
        final activeFilters = Map.fromEntries(
          paymentsInfo.transactionFilter
              .where((filter) => filter.isDefault)
              .map((filter) => MapEntry(filter.label, true)),
        );

        emit(
          PaymentsLoaded(
            paymentsInfo: paymentsInfo,
            viewType: currentViewType,
            activeFilters: activeFilters,
          ),
        );
      },
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
        (failure) => emit(
          PaymentsError(failure.message, viewType: currentState.viewType),
        ),
        (paymentsInfo) {
          final activeFilters = Map.fromEntries(
            paymentsInfo.transactionFilter
                .where((filter) => filter.isDefault)
                .map((filter) => MapEntry(filter.label, true)),
          );
          emit(
            currentState.copyWith(
              paymentsInfo: paymentsInfo,
              activeFilters: activeFilters,
            ),
          );
        },
      );
    } else {
      add(const FetchPayments());
    }
  }

  void _onFilterPayments(FilterPayments event, Emitter<PaymentsState> emit) {
    if (state is PaymentsLoaded) {
      final currentState = state as PaymentsLoaded;

      // Mantém os filtros default sempre ativos
      final defaultFilters =
          currentState.paymentsInfo.transactionFilter
              .where((filter) => filter.isDefault)
              .map((filter) => filter.label)
              .toSet();

      final updatedFilters = Map<String, bool>.from(event.activeFilters);
      for (final defaultFilter in defaultFilters) {
        updatedFilters[defaultFilter] = true;
      }

      emit(currentState.copyWith(activeFilters: updatedFilters));
    }
  }

  void _onChangeViewType(ChangeViewType event, Emitter<PaymentsState> emit) {
    if (state is PaymentsInitial) {
      add(const FetchPayments());
      return;
    }

    if (state is PaymentsLoading) {
      emit(PaymentsLoading(viewType: event.viewType));
      return;
    }

    if (state is PaymentsLoaded) {
      final currentState = state as PaymentsLoaded;
      emit(currentState.copyWith(viewType: event.viewType));
      return;
    }

    if (state is PaymentsError) {
      final currentState = state as PaymentsError;
      emit(PaymentsError(currentState.message, viewType: event.viewType));
      return;
    }
  }
}
