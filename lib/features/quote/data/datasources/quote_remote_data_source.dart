import 'package:quote/core/api/end_points.dart';
import 'package:quote/core/api/api_consumer.dart';
import 'package:quote/features/quote/data/models/model.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getQuote();
}

class QuoteRemoteDataSourceImpl implements QuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  QuoteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getQuote() async {
    final response = await apiConsumer.get(EndPoints.randomQuote);
    return QuoteModel.fromJson(response);
  }
}
