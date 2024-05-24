import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:huui/features/info_for_main_table.dart';
import 'package:huui/features/shares_class.dart';
import 'package:shared_preferences/shared_preferences.dart';



class FavoriteShadesScreen extends StatefulWidget {
  const FavoriteShadesScreen({super.key});
  @override
  State<FavoriteShadesScreen> createState() => _FavoriteShadesScreenState();
}

class _FavoriteShadesScreenState extends State<FavoriteShadesScreen> {

Color? PainterSecid(dynamic Secid, Color? txtTheme){
  if(Secid>0){
    return Colors.green;
  }
  if (Secid<0){
    return Colors.red;
  }
  else{
    return txtTheme;
  }
}
   
  List<Shares>? _shalist; 

  Future _setFavorite(List<String> _getter) async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("FavoriteList", _getter);
}

  void gettin()async{
      _shalist = await GetIt.I<ParsedInfoTable>().getinfofor();
      debugPrint(_shalist?[1].Secid.toString());
      if(!mounted) return; 
        setState(() {});
      _searchingShades();
  }
  void AssignationListCall()async{
    _shalist = await GetIt.I<ParsedInfoTable>().getinfofor();
    if(!mounted) return; 
        setState(() {});
        _searchingShades();
  }
  

    var _PreLastListFav = <Shares>[];
    var _filterShades = <Shares>[];

  final _searchController = TextEditingController();
  void _searchingShades(){

    final query = _searchController.text;
    if(query.isEmpty){
      _filterShades = _PreLastListFav.toSet().toList();

    }
    else if(query.isNotEmpty){
      _filterShades = _PreLastListFav.where((Shares share) {
        return share.MinStep.toUpperCase().contains(query.toUpperCase());
      }).toList();

    }
}
  void adder(List<String> _GetterOfIndexes){
    if( _shalist != null){
        for(int i=0; i<_GetterOfIndexes.length;i++){
          for(int j = 0;j<_shalist!.length; j ++){
        if(_GetterOfIndexes[i] == _shalist![j].Name){
          _PreLastListFav.add(_shalist![j]);
          _PreLastListFav[i] = _shalist![j];
          _PreLastListFav = _PreLastListFav.toSet().toList();
        }
      }
    }
    }
  }



  
  @override
  void initState() {
    super.initState();
      AssignationListCall();
      Timer.periodic(Duration(seconds: 30), (timer) { gettin();});
      _searchController.addListener(_searchingShades);
      setState(() {gettin();});
  }
  final List<IconData> bobik = [Icons.menu, Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme.bodyLarge?.color;
      final _GetterOfIndexes = ModalRoute.of(context)?.settings.arguments as List<String>;
      debugPrint(_GetterOfIndexes.toString());
      if(_PreLastListFav.length > _GetterOfIndexes.length){_PreLastListFav.clear();
      }
      adder(_GetterOfIndexes.toSet().toList());
      _setFavorite(_GetterOfIndexes);
    final theme =Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('favorite_shades'),
      ),
      body: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 5)),
          Container(
          decoration: BoxDecoration(
            color: Theme.of(context).inputDecorationTheme.fillColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextFormField(
            maxLength: 16,
            controller: _searchController,//add listner to list
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor)
              ),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).dividerColor)),
              hintText: 'Enter a search term',
              hintStyle: TextStyle(
                color: txtTheme
              )
            ),
        ),
      ),
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),),
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
                    style: TextStyle(fontSize: 13,
                    color: txtTheme,
                    ),
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
                    style: TextStyle(fontSize: 13,
                    color: txtTheme,),
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
                    style: TextStyle(fontSize: 13,
                    color: txtTheme,),
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
                    style: TextStyle(fontSize: 13,
                    color: txtTheme,),
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
                    style: TextStyle(fontSize: 13,
                    color: txtTheme,),
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
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 3,
              child: 
              
              ColoredBox(color: Colors.white24),
            ),
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                  child:
                  Column( 
                  children:[
                  Row(
                  children: [Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Container(
                  
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5) ,bottomLeft: Radius.circular(5)),
                  color: Theme.of(context).cardTheme.color,),
                  height: 50,
                  width:96,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), //Name Of 
                  child:Row(children:[InkWell(child: Icon(Icons.close),
                  onTap:(){
                  _GetterOfIndexes.remove(_filterShades[index].Name);
                  _filterShades.remove(_filterShades[index]);
                  setState(() {});
                  } ,
                  ) ,Text(_filterShades[index].Name.toString(),style: TextStyle(
                    fontFamily: 'Robotic',
                    fontSize: 12,
                    color: txtTheme
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                  ]
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
                ,Column(children: [Container(
                  color: Theme.of(context).cardTheme.color,
                  height: 50,
                  width:55,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // last deal
                  child: Text(_filterShades[index].PrevPrice.toString(),style: TextStyle(
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
            )
                ,Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Container(
                  color: Theme.of(context).cardTheme.color,
                  height: 50,
                  width:105,
                  padding: EdgeInsets.fromLTRB(10, 12, 10, 2), // 
                  child: Text(_filterShades[index].MinStep.toString(),style: TextStyle(
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
                  child: Text(_filterShades[index].BoardId.toString(),style: TextStyle(
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
                    color: PainterSecid(_filterShades[index].Secid, txtTheme),
                  ),
                  textAlign: TextAlign.left,                  
                  ),
                ),
                ],)
                ],),
        ],
        ), 

        ),
              );
            },
          ),
      ),
       Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 25),),
        ]
        ),
    );
  }
}