import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/presentation/views/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterModal', () {
    late List<PaymentsTransactionFilterModel> mockFilters;
    late Map<String, bool> mockActiveFilters;
    late Function(Map<String, bool>) onFiltersChanged;

    setUp(() {
      mockFilters = [
        PaymentsTransactionFilterModel.fromJson({
          'key': 'Date',
          'isDefault': true,
          'label': 'Date',
        }),
        PaymentsTransactionFilterModel.fromJson({
          'key': 'Amount',
          'isDefault': false,
          'label': 'Amount',
        }),
        PaymentsTransactionFilterModel.fromJson({
          'key': 'Type',
          'isDefault': false,
          'label': 'Type',
        }),
      ];
      mockActiveFilters = {'Date': true, 'Amount': false, 'Type': true};
      onFiltersChanged = (filters) {};
    });

    testWidgets('should render all filter options', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterModal(
              filters: mockFilters,
              activeFilters: mockActiveFilters,
              onFiltersChanged: onFiltersChanged,
            ),
          ),
        ),
      );

      expect(find.text('Date'), findsOneWidget);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('Type'), findsOneWidget);
    });

    testWidgets('should show correct checkbox states', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterModal(
              filters: mockFilters,
              activeFilters: mockActiveFilters,
              onFiltersChanged: onFiltersChanged,
            ),
          ),
        ),
      );

      // Encontrar os contêineres que representam os checkboxes
      final dateRow =
          find
              .ancestor(of: find.text('Date'), matching: find.byType(Row))
              .first;

      final amountRow =
          find
              .ancestor(of: find.text('Amount'), matching: find.byType(Row))
              .first;

      final typeRow =
          find
              .ancestor(of: find.text('Type'), matching: find.byType(Row))
              .first;

      // Verificar ícone de check para Date (ativo)
      final dateCheckIcon = find.descendant(
        of: dateRow,
        matching: find.byIcon(Icons.check_rounded),
      );

      // Amount não deve ter ícone de check (inativo)
      final amountCheckIcon = find.descendant(
        of: amountRow,
        matching: find.byIcon(Icons.check_rounded),
      );

      // Type deve ter ícone de check (ativo)
      final typeCheckIcon = find.descendant(
        of: typeRow,
        matching: find.byIcon(Icons.check_rounded),
      );

      // Date é marcado como default e deve estar selecionado
      expect(dateCheckIcon, findsOneWidget);

      // Amount não está selecionado
      expect(amountCheckIcon, findsNothing);

      // Type está selecionado
      expect(typeCheckIcon, findsOneWidget);
    });

    testWidgets('should call onFiltersChanged when filter is tapped', (
      WidgetTester tester,
    ) async {
      var filtersChanged = false;
      onFiltersChanged = (filters) {
        filtersChanged = true;
      };

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FilterModal(
              filters: mockFilters,
              activeFilters: mockActiveFilters,
              onFiltersChanged: onFiltersChanged,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Amount'));
      await tester.pumpAndSettle();

      expect(filtersChanged, false); // Não deve chamar até fechar o modal

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();

      expect(filtersChanged, true);
    });
  });
}
