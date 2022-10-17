import 'dart:convert';
import 'package:quote/core/error/exceptions.dart';
import 'package:quote/core/utils/app_strings.dart';
import 'package:quote/features/quote/data/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class QuoteLocalDataSource {
  Future<QuoteModel> getLastQuote();
  Future<void> cacheQuote(QuoteModel quote);
}

class QuoteLocalDataSourceImpl implements QuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel> getLastQuote() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cachedRandomQuote);
    if (jsonString != null) {
      final cacheRandomQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quote) {
    return sharedPreferences.setString(
        AppStrings.cachedRandomQuote, json.encode(quote));
  }
}
