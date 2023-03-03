import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:lab3_mis_196023/model/termin.dart';
import 'package:lab3_mis_196023/repository/termin_repository.dart';
import '../blocs/termini_event.dart';
import '../blocs/termini_state.dart';
import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // return BlocProvider<TerminiBloc>(
    //   create: (BuildContext context) => TerminiBloc()..add(TerminiInitializedEvent()),
    //   child: MaterialApp(
    //     title: '196023 Lab3',
    //     theme: ThemeData(
    //       primarySwatch: Colors.blue,
    //     ),
    //     home: MainScreen(),
    //   ),
    // );

    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => TerminRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => TerminBloc(
        terminRepository: RepositoryProvider.of<TerminRepository>(context),
      ),
      child: Scaffold(
        key: scaffoldKey,
        body: BlocListener<TerminBloc, TerminState>(
          listener: (context, state) {
            if (state is TerminAdded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Termin added"),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: BlocBuilder<TerminBloc, TerminState>(
            builder: (context, state) {
              if (state is TerminAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TerminError) {
                return const Center(
                  child: Text("Error"),
                );
              }
              return MainScreen();
            },
          ),
        ),
      ),
    );
  }
}
