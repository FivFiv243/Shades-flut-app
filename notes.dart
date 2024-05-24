
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

//choosed Note data
  late int _ChoosedNoteIndex;


  late int NoteCounter=0;
  late List<String> _NoteListName = [];
  late List<String> _NoteListBody = [];
  Future _setLenghtNote() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setInt("NoteListLenght", NoteCounter);
}

  Future _setNoteName() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("NoteListName", _NoteListName);
}
  Future _setNoteBody() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("NoteListBody", _NoteListBody);
}

Future<List<String>?> _GetNoteName()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("NoteListName").toString());
 if(preferences.getStringList("NoteListName")!=null){
  return preferences.getStringList("NoteListName");
 }
 else{
  return [];
 } 
}

Future<List<String>?> _GetNoteBody()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getStringList("NoteListBody").toString());
 if(preferences.getStringList("NoteListBody")!=null){
  return preferences.getStringList("NoteListBody");
 }
 else{
  return [];
 }
}

Future<int?> _GetNoteLenght()async{
 var preferences = await SharedPreferences.getInstance();
 debugPrint(preferences.getInt("NoteListLenght").toString());
 if(preferences.getInt("NoteListLenght")!=null){
  return preferences.getInt("NoteListLenght");
 }
 else{
  return 0;
 }
}

Future _initNoteLenght()async{
  NoteCounter = (await _GetNoteLenght())!;
  setState(() {});
}
Future _initNoteName()async{
  _NoteListName = (await _GetNoteName())!;
  setState(() {});
}
Future _initNoteBody()async{
  _NoteListBody = (await _GetNoteBody())!;
  setState(() {});
}

String _StringWritter(String NBody){
  if(NBody.length > 20){
    return NBody.substring(0,20)+"...";
  }
  else{
    return NBody;
  }
}

String _StringWritterBody(String NBody){
  if(NBody.length > 80){
    return NBody.substring(0,90)+"...";
  }
  else{
    return NBody;
  }
}

@override
  void initState() {
    _initNoteLenght();
    _initNoteName();
    _initNoteBody();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('notes'),
        actions:<Widget>[ InkWell(child: Icon(Icons.note_add),onTap: () {
                _setLenghtNote();
                _setNoteBody();
                _setNoteName();
          NoteCounter = NoteCounter+1;
            debugPrint(NoteCounter.toString());
            setState(() {});
            _NoteListName.add("Note $NoteCounter",);
            _NoteListBody.add("Your note here");
        },),
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 20, 0))
        ]
      ),
      body: 
      
      ListView.separated(
        itemCount: NoteCounter,
        separatorBuilder:(context, index) => Padding(padding: EdgeInsets.all(5)),
        itemBuilder: (context, index) => 
        Column(children:[
          InkWell(onTap: () {
            _ChoosedNoteIndex = index;
            Navigator.of(context).pushNamed('/Notes/opened_note',arguments: [_NoteListName,_NoteListBody,_ChoosedNoteIndex]).then((value){setState(() {});});
          }, child:Card(
            color: Theme.of(context).cardTheme.color,
            child: Container(
              child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center
                ,children: [ InkWell(child: Icon(Icons.delete), onTap: () {
                _NoteListBody.removeAt(index);
                _NoteListName.removeAt(index);
                NoteCounter = NoteCounter-1;
                _setLenghtNote();
                _setNoteBody();
                _setNoteName();
                setState(() {});
              },) ,Text(_StringWritter(_NoteListName[index]),style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyLarge?.color,),textAlign: TextAlign.center,)],) ,
            Text(_StringWritterBody(_NoteListBody[index]),style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge?.color,),textAlign: TextAlign.center,)]),
            height: 100,
            width:380,
            )
          )
          )
        ]
        ),
      )
    );
  }
}