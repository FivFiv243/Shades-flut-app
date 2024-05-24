
import 'package:dio/dio.dart';
import 'package:huui/abstractions/abstract_getter_repository.dart';
import 'shares_class.dart';

class ParsedInfoTable implements AbstractShadesRepository{

  ParsedInfoTable({
    required this.dio,
    required this.linkJson
    });
  final String linkJson;
  final Dio dio;

  @override

  Future<List<Shares>> getinfofor() async{
    final request = await dio.get(
      linkJson
    );
    final data = request.data['marketdata'];
    final findat = data['data'];
    final Namedat = request.data['securities'];
    final NameDataCall = Namedat['data'];
    final List<Shares> sharelist = [];
    for(int i = 0; i <findat.length;i++){
      sharelist.add(Shares(Name: findat[i][0], PrevPrice: findat[i][1], BoardId: findat[i][2], Secid: findat[i][3], MinStep: NameDataCall[i][2]));
    }
    return sharelist;
  } 
} // securities брать имя от туда по индексу АбрауДюрсо
