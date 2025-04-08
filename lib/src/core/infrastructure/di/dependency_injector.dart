import 'package:get_it/get_it.dart';
import 'package:base_project/src/modules/payments/data/datasource/payments_datasource.dart';
import 'package:base_project/src/modules/payments/infra/datasource/payments_datasource_impl.dart';
import 'package:base_project/src/modules/payments/domain/repository/payment_repository.dart';
import 'package:base_project/src/modules/payments/data/repository/payment_repository_impl.dart';
import 'package:base_project/src/modules/payments/domain/usecase/get_payments_use_case.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  // Bloc
  getIt.registerFactory(() => PaymentsBloc(getIt()));

  // Use cases
  getIt.registerLazySingleton<GetPaymentsUseCase>(
    () => GetPaymentsUseCase(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<PaymentsRepository>(
    () => PaymentsRepositoryImpl(getIt()),
  );

  // Data sources
  getIt.registerLazySingleton<PaymentsDataSource>(
    () => PaymentsDatasourceImpl(getIt()),
  );

  // Mock
  getIt.registerLazySingleton<MockPaymentsJson>(() => MockPaymentsJsonEmpty());
}
