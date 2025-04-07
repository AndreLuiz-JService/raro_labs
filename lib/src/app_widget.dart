import 'package:base_project/src/core/theme/app_theme.dart';
import 'package:base_project/src/modules/payments/presentation/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:base_project/src/core/infrastructure/di/injection_container.dart'
    as di;
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentsBloc>(
          create: (context) => di.getIt<PaymentsBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Payments',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('pt', 'BR'), // Portuguese
        ],
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primary,
            titleTextStyle: AppTextStyles.appBarTitle,
            centerTitle: true,
            toolbarHeight: 64,
          ),
          scaffoldBackgroundColor: AppColors.scaffoldBackground,
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          fontFamily: 'Lato',
        ),
        home: const PaymentsPage(),
      ),
    );
  }
}
