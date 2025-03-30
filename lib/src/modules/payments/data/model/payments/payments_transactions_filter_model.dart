import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsTransactionFilterModel extends PaymentsTransactionFilterEntity {
  const PaymentsTransactionFilterModel({
    required super.key,
    required super.label,
    required super.isDefault,
  });

  factory PaymentsTransactionFilterModel.fromJson(Map<String, dynamic> map) {
    return PaymentsTransactionFilterModel(
      key: map['key'] ?? "",
      label: map['label'] ?? "",
      isDefault: map['isDefault'] ?? false,
    );
  }
}
