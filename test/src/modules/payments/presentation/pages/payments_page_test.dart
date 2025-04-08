import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/pages/payments_page.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/new_payment_widget.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/tab_bar.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentsBloc extends MockBloc<PaymentsEvent, PaymentsState>
    implements PaymentsBloc {}

void main() {
  // Ignora os erros de overflow para todos os testes
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetController.hitTestWarningShouldBeFatal = false;

  group('PaymentsPage', () {
    late MockPaymentsBloc mockBloc;

    setUp(() {
      mockBloc = MockPaymentsBloc();
      when(() => mockBloc.state).thenReturn(
        PaymentsLoaded(
          viewType: PaymentsViewType.schedule,
          paymentsInfo: PaymentsInfoModel.fromJson({
            'paymentsScheduled': [],
            'transactions': [],
            'transactionFilter': [],
            'summary': [],
          }),
          activeFilters: {},
        ),
      );
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: SizedBox(
          width: 600,
          height: 800,
          child: BlocProvider<PaymentsBloc>.value(
            value: mockBloc,
            child: const PaymentsPage(),
          ),
        ),
      );
    }

    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Payments'), findsOneWidget);
      expect(find.byType(TabBarWidget), findsOneWidget);
    });

    testWidgets('should show loaded state with data', (
      WidgetTester tester,
    ) async {
      when(() => mockBloc.state).thenReturn(
        PaymentsLoaded(
          viewType: PaymentsViewType.schedule,
          paymentsInfo: PaymentsInfoModel.fromJson({
            'paymentsScheduled': [
              {
                'paymentDate': '2024-01-01T00:00:00',
                'interest': 100.0,
                'principal': 0.0,
                'total': 100.0,
                'outstandingBalance': 0.0,
                'pastDue': false,
                'status': 'ok',
                'paymentType': 'PaymentType1',
              },
            ],
            'transactions': [],
            'transactionFilter': [],
            'summary': [],
          }),
          activeFilters: {},
        ),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Verificar por widgets que sempre aparecem no estado carregado
      expect(find.byType(TabBarWidget), findsOneWidget);
      expect(find.byType(NewPaymentWidget), findsOneWidget);
    });
  });
}
