import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:huui/abstractions/news_abstraction.dart';
import 'package:huui/features/news_info/News_model.dart';

class ParsedNewsTable implements NewsAbstractRepo{

  ParsedNewsTable({
    required this.dio,
    required this.linkJson
    });
  final String linkJson;
  final Dio dio;

  @override

  Future<List<News>> getnewsfor() async{
    final request = await dio.get(
      linkJson,
    );
    final data = request.data['docs'];
    final findat = data;
    debugPrint(findat.toString());
    final List<News> sharelist = [];
    for(int i = 0; i <data.length;i++){
      if(findat[i]['CrumbName']=='Рынок криптовалют'|| findat[i]['CrumbName']=='Рынок микрофинансирования'|| findat[i]['CrumbName']=='Деятельность «Газпрома»'||findat[i]['CrumbName']=='Финансы'||findat[i]['CrumbName']=='Мир')
       if(findat[i]['Subtitle']==null){
        sharelist.add(News(
        Name: findat[i]['Title'],
       Texter: '',
       Imagen: findat[i]['CrumbName']));
       }
       else{sharelist.add(News(
        Name: findat[i]['Title'],
       Texter: findat[i]['Subtitle'],
       Imagen: findat[i]['CrumbName']));
       }
    }
    return sharelist;
  } 
}