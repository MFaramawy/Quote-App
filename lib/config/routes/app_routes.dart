import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/injection_container.dart' as di;
import 'package:quote/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:quote/features/app/presentation/screens/splash_screen.dart';
import 'package:quote/features/quote/presentation/screens/quote_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRoute = '/randomQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return CupertinoPageRoute(builder: (context) {
          return const SplashScreen();
        });

      case Routes.randomQuoteRoute:
        return CupertinoPageRoute(builder: ((context) {
          return BlocProvider(
            create: ((context) => di.sl<QuoteCubit>()),
            child: const QuoteScreen(),
          );
        }));
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() => MaterialPageRoute(
        builder: ((context) =>
            const Scaffold(body: Center(child: Text(AppStrings.noRouteFound)))),
      );
}
