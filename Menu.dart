import 'package:flutter/material.dart';



class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {


  final List<String> hui = ['меню', 'чаты', 'настройки', 'новости','заметки','ну не ебу'];
  final List<IconData> bobik = [Icons.menu, Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(110, 112, 201, 228),
        centerTitle: true,
        title: const Text('Chats'),
      ),
      body: ListView(
        children: const [
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
       Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 25),),
          Text('puki'),
          Text('pisi'),
          Text('qeweqew')
        ]
        ),
    );
  }
}