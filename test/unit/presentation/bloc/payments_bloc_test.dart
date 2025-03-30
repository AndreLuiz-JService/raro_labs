import 'package:base_project/src/core/base/base.dart';
import 'package:base_project/src/modules/payments/data/model/payments/payments.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/infra/mock/mock.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPaymentsUseCase extends Mock implements GetPaymentsUseCase {}

void main() {
  late PaymentsBloc paymentsBloc;
  late MockGetPaymentsUseCase mockGetPaymentsUseCase;

  setUpAll(() {
    registerFallbackValue(NoParams());
  });

  setUp(() {
    mockGetPaymentsUseCase = MockGetPaymentsUseCase();
    paymentsBloc = PaymentsBloc(mockGetPaymentsUseCase);
  });

  tearDown(() {
    paymentsBloc.close();
  });

  test('initial state should be PaymentsInitial', () {
    expect(paymentsBloc.state, isA<PaymentsInitial>());
  });

  group('FetchPayments', () {
    blocTest<PaymentsBloc, PaymentsState>(
      'emits [PaymentsLoading, PaymentsLoaded] when FetchPayments is successful',
      build: () {
        final paymentsInfoModel = PaymentsInfoModel.fromJson(mockPaymentsJson);

        when(
          () => mockGetPaymentsUseCase(any()),
        ).thenAnswer((_) async => Right(paymentsInfoModel));
        return paymentsBloc;
      },
      act: (bloc) => bloc.add(const FetchPayments()),
      expect: () => [isA<PaymentsLoading>(), isA<PaymentsLoaded>()],
      verify: (_) {
        verify(() => mockGetPaymentsUseCase(any())).called(1);
      },
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'emits [PaymentsLoading, PaymentsError] when FetchPayments fails',
      build: () {
        when(
          () => mockGetPaymentsUseCase(any()),
        ).thenAnswer((_) async => Left(GenericFailure(error: 'Error')));
        return paymentsBloc;
      },
      act: (bloc) => bloc.add(const FetchPayments()),
      expect: () => [isA<PaymentsLoading>(), isA<PaymentsError>()],
      verify: (_) {
        verify(() => mockGetPaymentsUseCase(any())).called(1);
      },
    );
  });

  group('RefreshPayments', () {
    blocTest<PaymentsBloc, PaymentsState>(
      'calls FetchPayments when state is not PaymentsLoaded',
      build: () {
        final paymentsInfoModel = PaymentsInfoModel.fromJson(mockPaymentsJson);

        when(
          () => mockGetPaymentsUseCase(any()),
        ).thenAnswer((_) async => Right(paymentsInfoModel));

        return paymentsBloc;
      },
      act: (bloc) => bloc.add(const RefreshPayments()),
      expect: () => [isA<PaymentsLoading>(), isA<PaymentsLoaded>()],
      verify: (_) {
        verify(() => mockGetPaymentsUseCase(any())).called(1);
      },
    );
  });

  group('ToggleScheduleVisibility', () {
    final paymentsInfoModel = PaymentsInfoModel.fromJson(mockPaymentsJson);

    final initialState = PaymentsLoaded(
      paymentsInfo: paymentsInfoModel,
      visibleSchedules: const {1: false},
    );

    blocTest<PaymentsBloc, PaymentsState>(
      'updates visibility for a specific schedule',
      build: () => paymentsBloc,
      seed: () => initialState,
      act:
          (bloc) => bloc.add(
            const ToggleScheduleVisibility(scheduleId: 1, isVisible: true),
          ),
      expect:
          () => [
            isA<PaymentsLoaded>().having(
              (state) => state.visibleSchedules[1],
              'scheduleId 1 visibility',
              isTrue,
            ),
          ],
    );
  });
}
