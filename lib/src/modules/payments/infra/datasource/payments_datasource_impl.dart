import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/infra/mock/mock.dart';

class PaymentsDatasourceImpl implements PaymentsDataSource {
  late final MockPaymentsJson mockJson;

  PaymentsDatasourceImpl(this.mockJson);

  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    try {
      final response = await Future.delayed(Duration(seconds: 3), () {
        // INFO: use mockEmptyJson or mockPaymentsJson
        return mockJson; /* mockEmptyJson */
      });
      return PaymentsInfoModel.fromJson(response.value);
    } catch (e) {
      throw InfraError(InfraCode.unexpected, error: e);
    }
  }
}

abstract class MockPaymentsJson {
  Map<String, dynamic> get value;
}

class MockPaymentsJsonSuccess extends MockPaymentsJson {
  @override
  Map<String, dynamic> get value => mockPaymentsJson;
}

class MockPaymentsJsonEmpty extends MockPaymentsJson {
  @override
  Map<String, dynamic> get value => mockEmptyJson;
}

class MockPaymentsJsonError extends MockPaymentsJson {
  @override
  Map<String, dynamic> get value => throw Exception('Infra Error');
}
