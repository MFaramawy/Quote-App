import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/utils/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quote/core/widgets/error_widget.dart' as error_widget;
import 'package:quote/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:quote/features/quote/presentation/widgets/quote_content.dart';

class BuildBodyContent extends StatelessWidget {
  const BuildBodyContent({super.key, required this.onPress});

  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteCubit, QuoteState>(
      builder: ((context, state) {
        if (state is QuoteIsLoading) {
          return Center(child: SpinKitFadingCircle(color: AppColors.primary));
        } else if (state is QuoteError) {
          return error_widget.ErrorWidget(onPress: onPress);
        } else if (state is QuoteLoaded) {
          return Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 20),
              QuoteContent(quote: state.quote),
              InkWell(
                onTap: onPress,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary),
                  child: const Icon(
                    Icons.refresh,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(child: SpinKitFadingCircle(color: AppColors.primary));
        }
      }),
    );
  }
}
