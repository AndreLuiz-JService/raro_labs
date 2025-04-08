import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('_ScheduleItem', () {
    late PaymentsScheduledModel mockSchedule;

    setUp(() {
      mockSchedule = PaymentsScheduledModel.fromJson({
        'paymentDate': '2024-01-01T00:00:00',
        'interest': 100.0,
        'principal': 0.0,
        'total': 100.0,
        'outstandingBalance': 0.0,
        'pastDue': false,
        'status': 'ok',
        'paymentType': 'PaymentType1',
      });
    });

    testWidgets('should render correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleItem(schedule: mockSchedule, isNextPayment: true),
          ),
        ),
      );

      expect(find.byType(ScheduleItem), findsOneWidget);
    });

    testWidgets(
      'should show next payment indicator when isNextPayment is true',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ScheduleItem(schedule: mockSchedule, isNextPayment: true),
            ),
          ),
        );

        expect(find.text('Next'), findsOneWidget);
      },
    );

    testWidgets(
      'should not show next payment indicator when isNextPayment is false',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ScheduleItem(schedule: mockSchedule, isNextPayment: false),
            ),
          ),
        );

        expect(find.text('Next'), findsNothing);
      },
    );

    testWidgets('should show correct date format', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleItem(schedule: mockSchedule, isNextPayment: true),
          ),
        ),
      );

      expect(find.text('01/01/2024'), findsOneWidget);
    });

    testWidgets('should show correct interest amount', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScheduleItem(schedule: mockSchedule, isNextPayment: true),
          ),
        ),
      );

      expect(find.text('\$100'), findsOneWidget);
    });
  });
}
