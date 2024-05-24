import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:huui/features/bloc/my_homepage_block.dart';
import 'package:huui/features/info_for_main_table.dart';

import 'package:huui/features/shares_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  //add var,strings,ints
  final List<String> hui = [ 'чаты', 'настройки', 'новости','заметки','любимые'];
  final List<IconData> bobik = [ Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  final List<dynamic> pushesList = [ '/menu','/Settings','/News','/Notes','/Favorit'];
  late List<String> _favorite = [];


  List<Shares>? _shalist; 

final _HomepageBloc = HomepageBloc(GetIt.I<ParsedInfoTable>(),);


  var _filterShades = <Shares>[];
  final _searchController = TextEditingController();
  void _searchingShades(){
    final query = _searchController.text;
    if(query.isEmpty){
      _filterShades = _shalist!;
    }
    else if(query.isNotEmpty){
      _filterShades = _shalist!.where((Shares share) {
        return share.MinStep.toUpperCase().contains(query.toUpperCase());
      }).toList();
      
  }
}
bool FavoriteCheck(String Name){
  if(_favorite != []){
  bool j = false;
  for(int i = 0; i<_favorite.length; i++){
    if(Name == _favorite[i]){
      j = true;
      break;
    }
  }
  return j;
  }
  else{
    return false;
  }
}
Icon IconPutter(bool ChekerAnswer){
  if(ChekerAnswer == false){
    return const Icon(Icons.add);
  }
  else{
    return const Icon(Icons.close);
  }
}
dynamic FavoriteListMethod(bool Cheker,String ShareName)async{
  if(Cheker == true){
    _favorite.remove(ShareName);
  }
  else{
    _favorite.add(ShareName);
  }
  _setFavorite();
}
//disk data block
Future _setFavorite() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("FavoriteList", _favorite);
}

Future<List<String>?> _GetFavorite()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("FavoriteList").toString());
 if(preferences.getStringList("FavoriteList")!=null){
  return preferences.getStringList("FavoriteList");
 }
 else{
  return [];
 }
 
}


Future _initFavorite()async{
  _favorite = (await _GetFavorite())!;
  setState(() {});
}


Color? PainterSecid(dynamic _Secid){
  if(_Secid>0){
    return Colors.green;
  }
  if (_Secid<0){
    return Colors.red;
  }
  else{
    return Theme.of(context).textTheme.bodyLarge?.color;
  }

}


@override
  void initState() {
    super.initState();
      _initFavorite();
      _HomepageBloc.add(ListLoadingEvent());
      Timer.periodic(Duration(seconds: 7), (timer) { _HomepageBloc.add(ListLoadingEvent());
      if(_shalist!=null){
      _searchingShades();
      }
      if(!mounted)return;
      });
      _searchController.addListener(_searchingShades);
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.bodyLarge?.color;
    final List<dynamic> ArgumentPushesList = [null,null,null,null,_favorite];
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(widget.title),
        centerTitle: Theme.of(context).appBarTheme.centerTitle,
        leading: const Icon(Icons.graphic_eq),
        shape:Theme.of(context).appBarTheme.shape,
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(
        bloc: _HomepageBloc,
        builder: (context, state) {
          if(state is ShadesListLoaded){
            _shalist = state.shadesList;
            _searchingShades();
            return ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5,10,5,0),
          height: 110,
          
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 10,),
            itemBuilder: (context, index){
              return  InkWell(
                borderRadius:BorderRadius.circular(30),
                onTap:() {
                  Navigator.of(context).pushNamed(pushesList[index],arguments: ArgumentPushesList[index]).then((value) {setState(() {});});
                  },
                child : Container(
                height: 80,
                width:120,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end:Alignment.bottomRight,
                    colors: [Theme.of(context).shadowColor,Theme.of(context).indicatorColor]),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2,
                  color: Theme.of(context).dividerColor,
                  )
                  
                ),
                child:Center(child: Column(children: [ Text('\n' + hui[index]+ '',
                style:  TextStyle(fontFamily: 'Times New Roman', fontSize: 16,color: txtTheme),
                textAlign: TextAlign.center,
                ),
                 Icon(bobik[index],
                 color: Theme.of(context).iconTheme.color,
                 ) 
                 ]
                )
                )
              ),
            );
            }
          ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
       Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 25),
        child : Container(
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextFormField(
            maxLength: 16,
            controller: _searchController,
            onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor)
              ),
              hintText: 'Enter a search term',
              hintStyle: TextStyle(
                color: txtTheme
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor)
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor))
            ),
            
            
        ),
        
        ),
      ),
      Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0)),
      Card(
        color: Theme.of(context).cardTheme.color,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                  color:Theme.of(context).dividerColor,
                  width: 1,
              ),
          ),),
          height: 32,
          width: 115,
          child: Row(children: [
            Column(
              children: [
                Container(
                  width: 95,
                  child: Center(
                    child: Text('Name',
                    style: TextStyle(fontSize: 14,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 30,
                  color: Theme.of(context).dividerColor,
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 55,
                  child: Center(
                    child: Text('Board Id',
                    style: TextStyle(fontSize: 13, color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 30,
                  color: Theme.of(context).dividerColor,
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 105,
                  child: Center(
                    child: Text('Full Name',
                    style: TextStyle(fontSize: 13, color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 30,
                  color: Theme.of(context).dividerColor,
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  child: Center(
                    child: Text('Last price',
                    style: TextStyle(fontSize: 13,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 2,
                  height: 30,
                  color: Theme.of(context).dividerColor,
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 64,
                  child: Center(
                    child: Text('Last proce',
                    style: TextStyle(fontSize: 13,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),


        Container(
          height: 500,
          decoration: BoxDecoration(
            boxShadow: null,
            borderRadius: BorderRadius.circular(12),
            border: Border.fromBorderSide(
              BorderSide(
                  color:Theme.of(context).dividerColor,
                  width: 5,
              ),
          ),),
          child:
        ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filterShades.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 3,
              width: 2,
              child: ColoredBox(color: Colors.white24),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Row(
                  children: [Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5) ,bottomLeft: Radius.circular(5)),
                  color: Theme.of(context).cardTheme.color,),
                  height: 50,
                  width:96,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), //Name Of 
                  child:Row(children:[InkWell(child: IconPutter(FavoriteCheck(_filterShades[index].Name)),
                  onTap:(){
                    FavoriteCheck(_filterShades[index].Name).toString();
                    FavoriteListMethod(FavoriteCheck(_filterShades[index].Name), _filterShades[index].Name);
                  _favorite.toSet().toList();
                  setState(() {});
                  debugPrint(_favorite.toString());
                  } ,
                  ) ,
                  Text(_filterShades[index].Name,style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color:txtTheme,
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                  ]
                  )
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 47,
                  width: 2,
                  child: null,
                )
              )
              ],
            )
                ,Column(children: [Container(
                  color: Theme.of(context).cardTheme.color,
                  height: 50,
                  width:55,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // last deal
                  child: Text(_filterShades[index].PrevPrice.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme,
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 47,
                  width: 2,
                  child: null,
                )
              )
              ],
            )
                ,Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Theme.of(context).cardTheme.color,
                  height: 50,
                  width:105,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // 
                  child: Text(_filterShades[index].MinStep.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 47,
                  width: 2,
                  child: null,
                )
              )
              ],
            ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Theme.of(context).cardTheme.color,
                  height: 50,
                  width:70,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2),
                  child: Text(_filterShades[index].BoardId.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Theme.of(context).dividerColor,
                  height: 47,
                  width: 2,
                  child: null,
                )
              )
              ],
            ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(5) ,bottomRight: Radius.circular(5)),
                  color: Theme.of(context).cardTheme.color,),
                  height: 50,
                  width:67,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2),
                  child: Text(_filterShades[index].Secid.toString() + '%',style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: PainterSecid(_filterShades[index].Secid),
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],)
                ],),
              ),
              );
            },
          )
      )
      ],);

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
              _HomepageBloc.add(ListLoadingEvent());
              }, child: Text('try again'),),
          ],
          )
          )
        ;}
            return const Center(child:  CircularProgressIndicator());
        },
      )
      
      
/*      
      ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5,10,5,0),
          height: 110,
          
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(width: 10,),
            itemBuilder: (context, index){
              return  InkWell(
                borderRadius:BorderRadius.circular(30),
                onTap:() {
                  Navigator.of(context).pushNamed(pushesList[index],arguments: ArgumentPushesList[index]).then((value) {setState(() {});});
                  },
                child : Container(
                height: 80,
                width:120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end:Alignment.bottomRight,
                    colors: [Color.fromARGB(110, 112, 201, 228),Color.fromARGB(106, 67, 240, 202)]),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 2,
                  color: const Color.fromARGB(118, 195, 181, 204)
                  )
                  
                ),
                child:Center(child: Column(children: [ Text('\n' + hui[index]+ '',
                style:  TextStyle(fontFamily: 'Times New Roman', fontSize: 16,color: txtTheme),
                textAlign: TextAlign.center,
                ),
                 Icon(bobik[index],
                 color: Theme.of(context).iconTheme.color,
                 ) 
                 ]
                )
                )
              ),
            );
            }
          ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
       Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 25),
        child : Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextFormField(
            maxLength: 16,
            controller: _searchController,
            onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
              hintStyle: TextStyle(
                color: txtTheme
              )
            ),
            
        ),
        
        ),
      ),
      Padding(padding: EdgeInsets.fromLTRB(0, 7, 0, 0)),
      Card(
        color: Color.fromRGBO(255, 255, 255, 75),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                  color:Color.fromARGB(118, 195, 181, 204),
                  width: 1,
              ),
          ),),
          height: 32,
          width: 115,
          child: Row(children: [
            Column(
              children: [
                Container(
                  width: 95,
                  child: Center(
                    child: Text('Name',
                    style: TextStyle(fontSize: 14,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 3,
                  height: 30,
                  color: const Color.fromARGB(66, 195, 181, 204),
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 55,
                  child: Center(
                    child: Text('Board Id',
                    style: TextStyle(fontSize: 13, color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 3,
                  height: 30,
                  color: const Color.fromARGB(66, 195, 181, 204),
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 105,
                  child: Center(
                    child: Text('Full Name',
                    style: TextStyle(fontSize: 13, color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 3,
                  height: 30,
                  color: const Color.fromARGB(66, 195, 181, 204),
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 70,
                  child: Center(
                    child: Text('Last price',
                    style: TextStyle(fontSize: 13,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  width: 3,
                  height: 30,
                  color: const Color.fromARGB(66, 195, 181, 204),
                  child: null,
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: 64,
                  child: Center(
                    child: Text('Last proce',
                    style: TextStyle(fontSize: 13,color: txtTheme),
                    ),
                  ),
                )
              ],
            ),
          ]),
        ),
      ),

          Padding(padding: EdgeInsets.fromLTRB(0, 1, 0, 0)),
        Container(
          height: 500,
          decoration: BoxDecoration(
            boxShadow: null,
            borderRadius: BorderRadius.circular(12),
            border: Border.fromBorderSide(
              BorderSide(
                  color:Color.fromARGB(110, 195, 181, 204),
                  width: 5,
              ),
          ),),
          child:
        ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: _filterShades.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 3,
              child: ColoredBox(color: Colors.white24),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child: Row(
                  children: [Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Container(
                  color: Colors.white60,
                  height: 50,
                  width:96,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), //Name Of 
                  child:Row(children:[InkWell(child: IconPutter(FavoriteCheck(_filterShades[index].Name)),
                  onTap:(){
                    FavoriteCheck(_filterShades[index].Name).toString();
                    FavoriteListMethod(FavoriteCheck(_filterShades[index].Name), _filterShades[index].Name);
                  _favorite.toSet().toList();
                  setState(() {});
                  debugPrint(_favorite.toString());
                  } ,
                  ) ,
                  Text(_filterShades[index].Name,style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color:txtTheme,
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                  ]
                  )
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Color.fromARGB(66, 195, 181, 204),
                  height: 47,
                  width: 3,
                  child: null,
                )
              )
              ],
            )
                ,Column(children: [Container(
                  color: Colors.white60,
                  height: 50,
                  width:55,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // last deal
                  child: Text(_filterShades[index].PrevPrice.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme,
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Color.fromARGB(66, 195, 181, 204),
                  height: 47,
                  width: 3,
                  child: null,
                )
              )
              ],
            )
                ,Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Colors.white60,
                  height: 50,
                  width:103,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // 
                  child: Text(_filterShades[index].MinStep.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Color.fromARGB(66, 195, 181, 204),
                  height: 47,
                  width: 3,
                  child: null,
                )
              )
              ],
            ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Colors.white60,
                  height: 50,
                  width:73,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2),
                  child: Text(_filterShades[index].BoardId.toString(),style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],),
                 Column(
              children: [Center(
                heightFactor: 1.1,
                child:
                Container(
                  color: Color.fromARGB(66, 195, 181, 204),
                  height: 47,
                  width: 3,
                  child: null,
                )
              )
              ],
            ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Colors.white60,
                  height: 50,
                  width:62,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2),
                  child: Text(_filterShades[index].Secid.toString() + '%',style:  TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: PainterSecid(_filterShades[index].Secid),
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],)
                ],),
              ),
              );
            },
          )
      )
      ],),
      */
    );
  }
}
