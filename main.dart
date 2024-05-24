import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:huui/features/info_for_main_table.dart';
import 'package:huui/features/news_info/News_getter.dart';
import 'package:huui/router/router_repo.dart';
import 'package:huui/themes/theme_classic_blue.dart';
import 'package:huui/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  GetIt.I.registerFactory(() => ParsedInfoTable(dio: Dio(), linkJson: 'https://iss.moex.com/iss/engines/stock/markets/shares/boards/TQBR/securities.json?marketdata.columns=SECID,BOARDID,LAST,LASTTOPREVPRICE,LASTCHANGEPRCNT'));
  GetIt.I.registerFactory(() => ParsedNewsTable(dio: Dio(), linkJson:  'https://www.kommersant.ru/news/newsline'));
  // change json on top
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (context)=>ThemeProvider(),

    child: const MyApp()
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState()=> _MyAppState();
}  
  // This widget is the root of your application.
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ThemeProvider>(context,listen: false).initTheme();
  }
  ThemeData Changer(){
    if(Provider.of<ThemeProvider>(context).themeData == false){
      return ClassicMode;
    }
    else{
      return DarkClassikMode;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shades TQRB',
      theme: Changer(),
      routes: routes,
      
    );
  }
}
