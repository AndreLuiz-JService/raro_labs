import 'package:base_project/src/app_widget.dart';
import 'package:base_project/src/core/infrastructure/di/injection_container.dart'
    as di;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Intl
  Intl.defaultLocale = 'en_US';

  await di.init();
  runApp(const AppWidget());
}
