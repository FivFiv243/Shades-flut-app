import 'package:huui/features/news_info/News_model.dart';

abstract class NewsAbstractRepo {
  Future<List<News>> getnewsfor();
}