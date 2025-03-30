import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/infra/mock/mock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentsDataSource extends Mock implements PaymentsDataSource {}

void main() {
  late PaymentsRepositoryImpl repository;
  late MockPaymentsDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockPaymentsDataSource();
    repository = PaymentsRepositoryImpl(mockDataSource);
  });

  group('PaymentsRepositoryImpl', () {
    test(
      'should return Right with PaymentsInfoEntity when data source returns success',
      () async {
        // Arrange
        final mockResponse = PaymentsInfoModel.fromJson(mockPaymentsJson);
        when(
          () => mockDataSource.getPaymentsInfo(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getPayments();

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (entity) {
          expect(entity, isA<PaymentsInfoEntity>());
          expect(entity.paymentsScheduled, mockResponse.paymentsScheduled);
          expect(entity.summary, mockResponse.summary);
          expect(entity.transactionFilter, mockResponse.transactionFilter);
          expect(entity.transactions, mockResponse.transactions);
        });
        verify(() => mockDataSource.getPaymentsInfo()).called(1);
      },
    );

    test(
      'should return Right with empty PaymentsInfoEntity when data source returns empty data',
      () async {
        // Arrange
        final mockResponse = PaymentsInfoModel.fromJson(mockEmptyJson);
        when(
          () => mockDataSource.getPaymentsInfo(),
        ).thenAnswer((_) async => mockResponse);

        // Act
        final result = await repository.getPayments();

        // Assert
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (entity) {
          expect(entity, isA<PaymentsInfoEntity>());
          expect(entity.paymentsScheduled, isEmpty);
        });
        verify(() => mockDataSource.getPaymentsInfo()).called(1);
      },
    );

    test(
      'should return Left with GenericFailure when data source throws an error',
      () async {
        // Arrange
        final error = Exception('Test error');
        when(() => mockDataSource.getPaymentsInfo()).thenThrow(error);

        // Act
        final result = await repository.getPayments();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<GenericFailure>());
          expect(failure.error, error);
        }, (entity) => fail('Should not return success'));
        verify(() => mockDataSource.getPaymentsInfo()).called(1);
      },
    );
  });
}
