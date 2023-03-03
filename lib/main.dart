import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/firebase_options.dart';
import 'package:lab3_mis_196023/repository/termin_repository.dart';
import 'package:lab3_mis_196023/screens/auth_page.dart';
import 'package:lab3_mis_196023/service/notif_service.dart';
import 'package:timezone/data/latest.dart' as tz;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WidgetTree(),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  tz.initializeTimeZones();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => TerminBloc(terminRepository: TerminRepository())..add(GetData()))
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab4 196023',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: AuthPage(),
    );
  }
}

// this was in lab3

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<TerminiBloc>(
//       create: (BuildContext context) => TerminiBloc()..add(TerminiInitializedEvent()),
//       child: MaterialApp(
//         title: '196023 Lab3',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (ctx) => MainScreen(),
//           TerminDetailsScreen.routeName: (ctx) => TerminDetailsScreen(),
//         },
//       ),
//     );
//   }
// }
