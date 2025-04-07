import 'package:base_project/src/core/infrastructure/di/injection_container.dart';
import 'package:base_project/src/modules/payments/domain/entity/entity.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/views/body_view.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/new_payment_widget.dart';
import 'package:base_project/src/modules/payments/presentation/widgets/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final bloc = getIt<PaymentsBloc>();

  @override
  void initState() {
    super.initState();
    // Carrega os dados iniciais
    bloc.add(const FetchPayments());
  }

  void _handleViewTypeChanged(PaymentsViewType viewType) {
    bloc.add(ChangeViewType(viewType));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset('assets/images/svg/question.svg'),
            ),
          ),
        ],
      ),
      body: BlocBuilder<PaymentsBloc, PaymentsState>(
        bloc: bloc,
        builder: (context, state) {
          // Determina o tipo de visualização atual com base no estado
          final viewType = _getCurrentViewType(state);

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  NewPaymentWidget(state: state),
                  TabBarWidget(
                    state: state,
                    currentViewType: viewType,
                    onViewTypeChanged: _handleViewTypeChanged,
                    firstTabTitle: 'SCHEDULE',
                    secondTabTitle: 'TRANSACTIONS',
                  ),

                  // Conteúdo baseado no tipo de visualização e estado
                  BodyView(state: state, viewType: viewType),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  // Determina o tipo de visualização atual com base no estado do bloc
  PaymentsViewType _getCurrentViewType(PaymentsState state) {
    switch (state) {
      case PaymentsLoaded():
        return state.viewType;
      case PaymentsLoading():
        return state.viewType;
      case PaymentsError():
        return state.viewType;
      default:
        return PaymentsViewType.schedule;
    }
  }
}
