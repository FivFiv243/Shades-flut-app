import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:huui/features/bloc/news_bloc/news_bloc.dart';
import 'package:huui/features/news_info/News_getter.dart';
import 'package:huui/features/news_info/News_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  List<News>? _NewsList;

  final List<String> hui = ['меню', 'чаты', 'настройки', 'новости','заметки'];
  final List<IconData> bobik = [Icons.menu, Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  final _NewsBloc = NewsBloc(GetIt.I<ParsedNewsTable>(),);
  final List<News> NewsConst = [];
  late List<String>? _NewsNames= [];
  late List<String>? _TexteList=[];
  late List<String>? _CrumbNames=[];


//first action need to be getting last news to separated lists   ||   action : 1
//getting part of action : 1
Future<List<String>?> _GetNames()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("NewsNamesList").toString());
 if(preferences.getStringList("NewsNamesList")!=null){
  return preferences.getStringList("NewsNamesList");
 }
 else{
  return [];
 }
}

Future<List<String>?> _GetTextes()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("NewsTextesList").toString());
 if(preferences.getStringList("NewsTextesList")!=null){
  return preferences.getStringList("NewsTextesList");
 }
 else{
  return [];
 }
}

Future<List<String>?> _GetCrumbs()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("CrumbNamesList").toString());
 if(preferences.getStringList("CrumbNamesList")!=null){
  return preferences.getStringList("CrumbNamesList");
 }
 else{
  return [];
 }
}



// initialing part of action : 1  (USE THIS ONE)
Future _initNames()async{
  _NewsNames = (await _GetNames())!;
  setState(() {});
}

Future _initTextes()async{
  _TexteList = (await _GetTextes())!;
  setState(() {});
}

Future _initCrumbs()async{
  _CrumbNames = (await _GetCrumbs())!;
  setState(() {});
}



//that part adds data to separated lists; this part adds News from first news List (_NewsList) to separated Lists   ||   action : 2
void SeparatingNewsNames(){
  if(_NewsList!= null){
    for(int i = 0; i< _NewsList!.length; i++){
        _NewsNames?.add(_NewsList![i].Name);
    }
  }
}

void SeparatingTexterList(){
  if(_NewsList!= null){
    for(int i = 0; i< _NewsList!.length; i++){
        _TexteList?.add(_NewsList![i].Texter);
      
    }
  }
}

void SeparatingCrumbNames(){
  if(_NewsList!= null){
    for(int i = 0; i< _NewsList!.length; i++){
        _CrumbNames?.add(_NewsList![i].Imagen);
    }
  }
}




//saving action thats saves separated lists to preferences   ||   action : 3

Future _AllSeparatorsSetter()async{
  final preferences = await SharedPreferences.getInstance();
  if((Names.isNotEmpty && Texte.isNotEmpty  && Crumb.isNotEmpty)){
    preferences.setStringList("NewsNamesList", Names);
    preferences.setStringList("NewsTextesList", Texte);
    preferences.setStringList("CrumbNamesList", Crumb);
  }
}

Future _setNames() async{
    var preferences = await SharedPreferences.getInstance();
    debugPrint(_NewsNames.toString());
    preferences.setStringList("NewsNamesList", _NewsNames!);
}

Future _setTexte() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("NewsTextesList", _TexteList!);
}

Future _setCrumb() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("CrumbNamesList", _CrumbNames!);
}


//News constructor (Constructing to NewsConst) this part constracts News from Crumb Names and Texter Lists    ||   action : 4
void ConstructingNewsLine(){
  if(_NewsNames != []){
    for(int i = 0; i < _NewsNames!.length; i++){
      if(NewsConst.contains(News(Imagen: _CrumbNames?[i], Name: _NewsNames?[i], Texter: _TexteList?[i])) == false){
        NewsConst.add(News(Imagen: _CrumbNames?[i], Name: _NewsNames?[i], Texter: _TexteList?[i]));
      }
    }
  }
}
// rewriting data 
late List<String> Names=[];
late List<String> Texte=[];
late List<String> Crumb=[];

void reWriter(){
  Names=[];
  Texte=[];
   Crumb=[];
  for(int i = 0; i < NewsConst.length;i++ ){
    Names.add(_NewsNames![i]);
    Texte.add(_TexteList![i]);
    Crumb.add(_CrumbNames![i]);
  }
}


//if preferences in trash use this   ||   action : Preferences Rebooter
Future _PreferencesRemover()async{
  var preferences = await SharedPreferences.getInstance();
  preferences.remove('NewsNamesList');
  preferences.remove('NewsTextesList');
  preferences.remove('CrumbNamesList');
}




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _NewsBloc.add(ListLoadingEvent());
    _initNames();
    _initTextes();
    _initCrumbs();
    SeparatingNewsNames();
    SeparatingTexterList();
    SeparatingCrumbNames();
    reWriter();
    _AllSeparatorsSetter();
    ConstructingNewsLine();
    _NewsBloc.add(ListLoadingEvent());
    Timer(Duration(milliseconds: 1), () {
      if(mounted){
      _initNames();
      _initTextes();
      _initCrumbs();
      SeparatingNewsNames();
      SeparatingTexterList();
      SeparatingCrumbNames();
      reWriter();
      _AllSeparatorsSetter();
      ConstructingNewsLine();
      _NewsBloc.add(ListLoadingEvent());
    }
     });
    Timer.periodic(Duration(seconds: 5), (timer) {
    if(mounted){
      _initNames();
      _initTextes();
      _initCrumbs();
      SeparatingNewsNames();
      SeparatingTexterList();
      SeparatingCrumbNames();
      reWriter();
      _AllSeparatorsSetter();
      ConstructingNewsLine();
      _NewsBloc.add(ListLoadingEvent());
    }
    });
  }
  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.bodyLarge?.color;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('news'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        bloc: _NewsBloc,
        builder: (context, state) {
          if(state is NewsListLoaded){
            _NewsList = state.newsList;
            return ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: NewsConst.length,
                  separatorBuilder: ((context, index) => const SizedBox(height: 25,)),
                  itemBuilder:(context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).dividerColor,
                        )
                      ),
                      width: 700,
                      child: Column(
                          children: [
                            Text(NewsConst[index].Name,style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontFamily: 'Times New Roman', fontSize: 14,) ,textAlign: TextAlign.center,)
                            ,SizedBox(height:5),
                            Text(NewsConst[index].Texter, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontFamily: 'Times New Roman', fontSize: 12), textAlign: TextAlign.center,)
                            ,SizedBox(height: 2.5,),
                            Text('  '+NewsConst[index].Imagen +'                                                                                                                   ' , 
                            style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color,fontFamily: 'Times New Roman', fontSize: 12))
                          ],
                        )
                    );
                  } )
              ]
            );
          }
           if(state is ListLoadingFailed){return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text("Something went wrong",style: TextStyle(color: txtTheme,fontSize: 16),),
            Text("Please try again later",style: TextStyle(color:txtTheme, fontSize: 12),),
            SizedBox(height: 30,),
            TextButton(onPressed: ()async{
              _NewsBloc.add(ListLoadingEvent());
              }, child: Text('try again'),),
          ],
          )
          )
        ;}
            return const Center(child:  CircularProgressIndicator());
        },
      )
    );
  }
}