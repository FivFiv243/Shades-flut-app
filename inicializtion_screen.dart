import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:huui/features/bloc/init_user_bloc/init_bloc.dart';
import 'package:huui/features/info_for_main_table.dart';



class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {

final _MailController = TextEditingController();
final _PasswordController = TextEditingController();

  final List<String> hui = ['меню', 'чаты', 'настройки', 'новости','заметки','ну не ебу'];
  final List<IconData> bobik = [Icons.menu, Icons.message, Icons.settings,Icons.new_releases_rounded,Icons.note_alt_rounded,Icons.do_not_touch_sharp];
  final _InitBloc = InitBloc(GetIt.I<ParsedInfoTable>(),);
  /*add logic that works with firebase*/ 
  @override
  Widget build(BuildContext context) {
    final QueryWidth = MediaQuery.of(context).size.width;
    final QueryHight = MediaQuery.of(context).size.height;
    final txtTheme = Theme.of(context).textTheme.bodyLarge?.color;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(110, 112, 201, 228),
        centerTitle: true,
        title: const Text('Autorization'),
      ),
       body: BlocBuilder<InitBloc, InitState>(
        bloc: _InitBloc,
        builder: (context, state) {
          if(state is InitialLoaded){
            return const Center(child:  CircularProgressIndicator());
          }
          if(state is InitialFailed){
            return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Text("Something went wrong",style: TextStyle(color: txtTheme,fontSize: 16),),
            Text("Please try again later",style: TextStyle(color:txtTheme, fontSize: 12),),
            SizedBox(height: 30,),
            TextButton(onPressed: ()async{
              _InitBloc.add(ListLoadingEvent());
              }, child: Text('try again'),),
          ],
          )
          );
          }
          return Scaffold( 
                body:SafeArea(child: 
                  Column(
                    children: [
                      Container(
                        width:MediaQuery.of(context).size.width,
                        child:
                        Padding(padding: EdgeInsets.fromLTRB(0, QueryHight/7, 0, 0),),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          child: Card(
                            color: Colors.yellow,
                            elevation: 10,
                            margin: EdgeInsets.fromLTRB(0, 0, QueryWidth/1.6, QueryHight/70),
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1,color: Colors.black26),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(5)
                              )
                            ),
                            child: 
                            Text('Login',style: TextStyle(fontSize: QueryWidth/8, fontFamily: "Azgar",color: Colors.black87,letterSpacing: 12),),
                          )
                        )
                      ),
                      Container(
                        child:
                          Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.5,color: Colors.black45),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(90),bottomRight: Radius.circular(90))
                            ),
                            elevation: 5,
                            margin: EdgeInsets.fromLTRB(0, QueryHight/40, QueryWidth/4, 0),

                            child:
                            Container(
                              padding: EdgeInsets.fromLTRB(0, QueryHight/250, QueryWidth/12, QueryHight/250),
                              child:
                              Column(children: [
                              TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.mail),
                                  labelText: 'Your mail',
                                  border: OutlineInputBorder(),
                                  disabledBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width:1,
                                      style: BorderStyle.solid
                                    )
                                  ),
                                ),
                                controller: _MailController,maxLength: 254,onChanged: (value) => _MailController.text,),
                              TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: 'Your mail',
                                  border: OutlineInputBorder(),
                                  disabledBorder:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                      width:1,
                                      style: BorderStyle.solid,
                                    )
                                  ),
                                ),
                                controller: _PasswordController,maxLength: 64, onChanged: (value) => _PasswordController.text,)
                              ]
                              )
                            )
                          )
                      ),
                      TextButton(onPressed: null, child: Text('Confirm',style: TextStyle(fontSize: QueryWidth/20,fontFamily: 'Azgar', color: Colors.green),))
                    ],
                  )
                )
            );
        }
       )
    );
  }
}