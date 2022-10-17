import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:quote/core/api/api_consumer.dart';
import 'package:quote/core/api/dio_consumer.dart';
import 'package:quote/core/api/app_interceptors.dart';
import 'package:quote/core/network/network_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quote/features/quote/domain/usecases/get_quote.dart';
import 'package:quote/features/app/domain/usecases/change_lang.dart';
import 'package:quote/features/app/presentation/cubit/app_cubit.dart';
import 'package:quote/features/app/domain/usecases/get_saved_lang.dart';
import 'package:quote/features/quote/presentation/cubit/quote_cubit.dart';
import 'package:quote/features/app/domain/repositories/lang_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quote/features/quote/domain/repositories/quote_repository.dart';
import 'package:quote/features/app/data/repositories/lang_repository_impl.dart';
import 'package:quote/features/app/data/datasources/lang_local_data_source.dart';
import 'package:quote/features/quote/data/repositories/quote_repository_impl.dart';
import 'package:quote/features/quote/data/datasources/quote_local_data_source.dart';
import 'package:quote/features/quote/data/datasources/quote_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ! Features

  // Blocs
  sl.registerFactory<QuoteCubit>(() => QuoteCubit(getQuoteUseCase: sl()));
  sl.registerFactory<AppCubit>(
      () => AppCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  // Use cases
  sl.registerLazySingleton<GetQuote>(() => GetQuote(quoteRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
        networkInfo: sl(),
        quoteLocalDataSource: sl(),
        quoteRemoteDataSource: sl(),
      ));
  sl.registerLazySingleton<LangRepository>(
      () => LangRepositoryImpl(langLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<QuoteLocalDataSource>(
      () => QuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<QuoteRemoteDataSource>(
      () => QuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  // ! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  // ! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}
