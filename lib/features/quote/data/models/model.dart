import 'package:quote/features/quote/domain/entities/quote.dart';

class QuoteModel extends Quote {
  const QuoteModel({
    required int id,
    required String author,
    required String content,
    required String permalink,
  }) : super(id: id, author: author, content: content, permalink: permalink);

  factory QuoteModel.fromJson(Map<String, dynamic> json) => QuoteModel(
        id: json['id'],
        author: json['author'],
        content: json['quote'],
        permalink: json['permalink'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'quote': content,
        'permalink': permalink,
      };
}
