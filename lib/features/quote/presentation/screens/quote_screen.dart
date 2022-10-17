import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/utils/app_colors.dart';
import 'package:quote/config/locale/app_localizations.dart';
import 'package:quote/features/app/presentation/cubit/app_cubit.dart';
import 'package:quote/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:quote/features/quote/presentation/widgets/build_body.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final quoteCubit = BlocProvider.of<QuoteCubit>(context);
    quoteCubit.getQuote();
    return RefreshIndicator(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.translate('app_name')!),
          leading: IconButton(
            icon: Icon(
              Icons.translate_outlined,
              color: AppColors.primary,
            ),
            onPressed: () => AppLocalizations.of(context)!.isEnLocale
                ? BlocProvider.of<AppCubit>(context).toArabic()
                : BlocProvider.of<AppCubit>(context).toEnglish(),
          ),
        ),
        body: BuildBodyContent(onPress: () => quoteCubit.getQuote()),
      ),
      onRefresh: () => quoteCubit.getQuote(),
    );
  }
}
