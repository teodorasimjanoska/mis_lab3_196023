import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/screens/main_screen.dart';
import 'package:lab3_mis_196023/screens/termin_details_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TerminiBloc>(
      create: (BuildContext context) => TerminiBloc()..add(TerminiInitializedEvent()),
      child: MaterialApp(
        title: '196023 Lab3',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => MainScreen(),
          TerminDetailsScreen.routeName: (ctx) => TerminDetailsScreen(),
        },
      ),
    );
  }
}