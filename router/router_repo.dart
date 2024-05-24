

import 'package:huui/favorite_shades.dart';
import 'package:huui/inicializtion_screen.dart';
import 'package:huui/news.dart';
import 'package:huui/notes.dart';
import 'package:huui/opend_note.dart';
import 'package:huui/settings.dart';

import '../my_home_page_sceen.dart';

final routes = {
        '/':(context) => const InitScreen(),
        '/menu':(context) => const MyHomePage(title: 'Shades TQBR',),
        '/Settings':(context)=>const SettingsScreen(),
        '/News':(context) => const NewsScreen(),
        '/Notes':(context) => const NotesScreen(),
        '/Favorit':(context) => const FavoriteShadesScreen(),
        '/Notes/opened_note':(context) => const OpenedNoteScreen(),
      };