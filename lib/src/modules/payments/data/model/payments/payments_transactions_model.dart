import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsTransactionsModel extends PaymentsTransactionsEntity {
  const PaymentsTransactionsModel({
    required super.key,
    required super.actualPaymentPostDate,
    required super.processDate,
    required super.actualPaymentAmount,
    required super.actualPrincipalPaymentAmount,
    required super.actualInterestPaymentAmount,
    required super.outstandingPrincipalBalance,
    required super.outstandingLoanBalance,
    required super.actualFee,
    required super.paymentType,
    required super.type,
  });

  factory PaymentsTransactionsModel.fromJson(Map<String, dynamic> map) {
    return PaymentsTransactionsModel(
      key: map['key'] ?? "",
      actualPaymentPostDate: DateTime.parse(map['actualPaymentPostDate']),
      processDate: DateTime.parse(map['processDate']),
      actualPaymentAmount: ConverterHelper.dynamicToDouble(
        map['actualPaymentAmount'] ?? 0.0,
      ),
      actualPrincipalPaymentAmount: ConverterHelper.dynamicToDouble(
        map['actualPrincipalPaymentAmount'] ?? 0.0,
      ),
      actualInterestPaymentAmount: ConverterHelper.dynamicToDouble(
        map['actualInterestPaymentAmount'] ?? 0.0,
      ),
      outstandingPrincipalBalance: ConverterHelper.dynamicToDouble(
        map['outstandingPrincipalBalance'] ?? 0.0,
      ),
      outstandingLoanBalance: ConverterHelper.dynamicToDouble(
        map['outstandingLoanBalance'] ?? 0.0,
      ),
      actualFee: ConverterHelper.dynamicToDouble(map['actualFee'] ?? 0.0),
      paymentType: map['paymentType'] ?? "",
      type: map['type'] ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'actualPaymentPostDate': ConverterHelper.stringNullableToMMDDYYYY(
        actualPaymentPostDate.toIso8601String(),
      ),
      'processDate': ConverterHelper.stringNullableToMMDDYYYY(
        processDate.toIso8601String(),
      ),
      'actualPaymentAmount': ConverterHelper.currencyFormatter(
        actualPaymentAmount,
        "--",
      ),
      'actualPrincipalPaymentAmount': ConverterHelper.currencyFormatter(
        actualPrincipalPaymentAmount,
        "--",
      ),
      'actualInterestPaymentAmount': ConverterHelper.currencyFormatter(
        actualInterestPaymentAmount,
        "--",
      ),
      'outstandingPrincipalBalance': ConverterHelper.currencyFormatter(
        outstandingPrincipalBalance,
        "--",
      ),
      'outstandingLoanBalance': ConverterHelper.currencyFormatter(
        outstandingLoanBalance,
        "--",
      ),
      'actualFee': ConverterHelper.currencyFormatter(actualFee, "--"),
      'paymentType': paymentType,
      'type': type,
    };
  }

  @override
  String getValueByLabel(String label) {
    switch (label) {
      case 'Process Date':
        return ConverterHelper.stringNullableToMMDDYYYY(
          processDate.toIso8601String(),
        );
      case 'Amount':
        return ConverterHelper.currencyFormatter(actualPaymentAmount);
      case 'Type':
        return paymentType;
      case 'Principal':
        return ConverterHelper.currencyFormatter(actualPrincipalPaymentAmount);
      case 'Interest':
        return ConverterHelper.currencyFormatter(actualInterestPaymentAmount);
      case 'Late Fee':
        return ConverterHelper.currencyFormatter(actualFee);
      case 'Post Date':
        return ConverterHelper.stringNullableToMMDDYYYY(
          actualPaymentPostDate.toIso8601String(),
        );
      case 'Principal Balance':
        return ConverterHelper.currencyFormatter(outstandingPrincipalBalance);
      default:
        return '';
    }
  }
}
