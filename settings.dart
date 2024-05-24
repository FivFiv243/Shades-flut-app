import 'package:flutter/material.dart';
import 'package:huui/themes/theme_provider.dart';
import 'package:provider/provider.dart';



class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  bool ThemeChecker(){
    if(Provider.of<ThemeProvider>(context, listen: false).themeData == false){
      return false;
    }
    else{return true;}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  final List<IconData> bobik = [Icons.menu, Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('settings'),
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(width: 2, color: Theme.of(context).dividerColor,),color: Theme.of(context).cardTheme.color,),
            child: TextButton(onPressed: null, child: Text('Profile', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color,fontSize: 14,fontFamily: 'Times New Roman'),)),),
        Padding(padding: EdgeInsets.symmetric(vertical: 0,horizontal: 15),),
          Container(
            height: 60,
            child: Row(children: [
               Center(child: Text('   Theme number',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyLarge?.color
                
                ),),),
                Padding(padding: EdgeInsets.fromLTRB(210, 0, 0, 100)),
              Switch(value: ThemeChecker(),
               onChanged:(log) {Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
               
              Provider.of<ThemeProvider>(context,listen: false).setTheme();
              } ),

            ],) 
          ),
        ]
        ),
    );
  }
}