import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenedNoteScreen extends StatefulWidget{
  const OpenedNoteScreen({super.key});

  @override
  State<OpenedNoteScreen> createState() => _OpenedNoteScreenState();
}

class _OpenedNoteScreenState extends State<OpenedNoteScreen> {

 Future _setNoteName() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("NoteListName", _GetetedNoteName[0]);
}
  Future _setNoteBody() async{
    var preferences = await SharedPreferences.getInstance();
    preferences.setStringList("NoteListBody", _GetetedNoteName[1]);
}

late List<dynamic> _GetetedNoteName;
final _NameController = TextEditingController();
final _BodyEditingController = TextEditingController();
@override
  void initState() {
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
    _GetetedNoteName = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: TextField(controller:_NameController..text = _GetetedNoteName[0][_GetetedNoteName[2]],minLines: 1,maxLines: 5000,onChanged: (value) {_GetetedNoteName[0][_GetetedNoteName[2]]= _NameController.text ;_setNoteName(); }),
      ),
      body:ListView(children: [
        TextField(controller: _BodyEditingController..text=_GetetedNoteName[1][_GetetedNoteName[2]],minLines: 1,maxLines: 5000,onChanged: (value) {_GetetedNoteName[1][_GetetedNoteName[2]]= _BodyEditingController.text;_setNoteBody();}),
      ])
    );
  }
}