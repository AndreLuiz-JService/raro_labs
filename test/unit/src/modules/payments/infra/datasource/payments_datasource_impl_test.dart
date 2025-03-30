import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/infra/datasource/payments_datasource_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PaymentsDatasourceImpl datasource;

  group('PaymentsDatasourceImpl', () {
    test(
      'should return PaymentsInfoEntity when mock returns success data',
      () async {
        // Arrange
        datasource = PaymentsDatasourceImpl(MockPaymentsJsonSuccess());

        // Act
        final result = await datasource.getPaymentsInfo();

        // Assert
        expect(result, isA<PaymentsInfoEntity>());
        expect(result.paymentsScheduled, isNotEmpty);
        expect(result.summary, isNotEmpty);
        expect(result.transactionFilter, isNotEmpty);
        expect(result.transactions, isNotEmpty);
      },
    );

    test(
      'should return empty PaymentsInfoEntity when mock returns empty data',
      () async {
        // Arrange
        datasource = PaymentsDatasourceImpl(MockPaymentsJsonEmpty());

        // Act
        final result = await datasource.getPaymentsInfo();

        // Assert
        expect(result, isA<PaymentsInfoEntity>());
        expect(result.paymentsScheduled, []);
      },
    );

    test('should throw InfraError when mock returns error data', () async {
      // Arrange
      datasource = PaymentsDatasourceImpl(MockPaymentsJsonError());

      // Act & Assert
      expect(
        () => datasource.getPaymentsInfo(),
        throwsA(
          isA<InfraError>().having(
            (error) => error.code,
            'code',
            InfraCode.unexpected,
          ),
        ),
      );
    });
  });
}
