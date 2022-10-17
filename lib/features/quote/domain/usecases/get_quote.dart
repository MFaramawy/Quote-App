import 'package:dartz/dartz.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/core/usecases/usecases.dart';
import 'package:quote/features/quote/domain/entities/quote.dart';
import 'package:quote/features/quote/domain/repositories/quote_repository.dart';

class GetQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository quoteRepository;

  GetQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call(NoParams params) =>
      quoteRepository.getQuote();
}
