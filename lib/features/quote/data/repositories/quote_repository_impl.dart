import 'package:dartz/dartz.dart';
import 'package:quote/core/error/failures.dart';
import 'package:quote/core/error/exceptions.dart';
import 'package:quote/core/network/network_info.dart';
import 'package:quote/features/quote/domain/entities/quote.dart';
import 'package:quote/features/quote/domain/repositories/quote_repository.dart';
import 'package:quote/features/quote/data/datasources/quote_local_data_source.dart';
import 'package:quote/features/quote/data/datasources/quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final QuoteLocalDataSource quoteLocalDataSource;
  final QuoteRemoteDataSource quoteRemoteDataSource;

  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.quoteLocalDataSource,
    required this.quoteRemoteDataSource,
  });

  @override
  Future<Either<Failure, Quote>> getQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteQuote = await quoteRemoteDataSource.getQuote();
        quoteLocalDataSource.cacheQuote(remoteQuote);
        return Right(remoteQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheQuote = await quoteLocalDataSource.getLastQuote();
        return Right(cacheQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
