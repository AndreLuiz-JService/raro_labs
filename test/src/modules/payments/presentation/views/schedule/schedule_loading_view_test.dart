import 'package:base_project/src/modules/payments/presentation/views/schedule/schedule_loading_view.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/scroll_indicator_place_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ScheduleLoadingView', () {
    testWidgets('should render loading skeleton items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: const ScheduleLoadingView())),
      );

      expect(find.byType(SkeletonItem), findsNWidgets(3));
      expect(find.byType(ScrollIndicatorPlaceholder), findsOneWidget);
    });
  });
}
