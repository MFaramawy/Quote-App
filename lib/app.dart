import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/config/themes/app_theme.dart';
import 'package:quote/config/routes/app_routes.dart';
import 'package:quote/config/locale/app_localizations_setup.dart';
import 'package:quote/features/app/presentation/cubit/app_cubit.dart';
import 'package:quote/features/quote/presentation/cubit/quote_cubit.dart';

class Quote extends StatelessWidget {
  const Quote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AppCubit>()),
        BlocProvider(create: (context) => di.sl<QuoteCubit>()..getQuote()),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme(),
            locale: state.locale,
            darkTheme: darkTheme(),
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocaleSetup.supportedLocales,
            localizationsDelegates: AppLocaleSetup.localizationsDelegates,
            localeResolutionCallback: AppLocaleSetup.localeResolutionCallback,
          );
        },
      ),
    );
  }
}
