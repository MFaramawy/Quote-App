import 'package:quote/app.dart';
import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:quote/bloc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const Quote());
}
