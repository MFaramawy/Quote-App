import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecases.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/quote/domain/entities/quote.dart';
import 'package:quote/features/quote/domain/usecases/get_quote.dart';
part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final GetQuote getQuoteUseCase;
  QuoteCubit({required this.getQuoteUseCase}) : super(QuoteInitial());

  Future<void> getQuote() async {
    emit(QuoteIsLoading());
    Either<Failure, Quote> response = await getQuoteUseCase(NoParams());
    emit(response.fold(
      (failure) => QuoteError(msg: _mapFailureToMsg(failure)),
      (quote) => QuoteLoaded(quote: quote),
    ));
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unexpectedError;
    }
  }
}
