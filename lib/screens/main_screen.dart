import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/blocs/termini_state.dart';
import 'package:lab3_mis_196023/model/termin.dart';
import 'package:lab3_mis_196023/repository/termin_repository.dart';
import 'package:lab3_mis_196023/widgets/add_location.dart';
import 'package:lab3_mis_196023/widgets/appointments.dart';
import 'package:lab3_mis_196023/widgets/nov_termin.dart';
import 'package:lab3_mis_196023/widgets/termin_tile.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:nanoid/nanoid.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _predmetController = TextEditingController();
  final _datumController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  bool vnesenDatum = false;
  late String predmet;
  DateTime datum = DateTime.now();
  String id = nanoid(5);

  void _deleteItem(BuildContext ctx, String id) {
    final bloc = BlocProvider.of<TerminBloc>(ctx);
    bloc.add(TerminDeletedEvent(id: id));
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> _createTermin() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
            ),
            child: NovTermin(_postData),
          );
        });
  }

  void _postData(context, Termin termin) {
    BlocProvider.of<TerminBloc>(context).add(
      TerminAddedEvent(termin: termin),
    );
  }

  Widget _createBody(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
              BlocBuilder<TerminBloc, TerminState>(builder: (context, state) {
            if (state is TerminLoaded) {
              List<Termin> termini = state.mydata;
              return ListView.builder(
                itemCount: termini.length,
                itemBuilder: (_, index) {
                  return TerminTile(
                    termini[index],
                    _deleteItem,
                  );
                },
              );
            } else if (state is TerminLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(
                child: Text("Nema termini"),
              );
            }
          }),
        ),
        ElevatedButton(
          child: Text(
            "Dodadi lokacija",
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLocation(),
              ),
            );
          },
        ),
        Expanded(
          child: _createCalendar(context),
        ),
      ],
    );
  }

  Widget _createAppBar(BuildContext context) {
    return AppBar(
      title: Text("Termini"),
      actions: <Widget>[
        GestureDetector(
          onTap: signUserOut,
          child: Icon(Icons.logout_outlined),
        ),
        IconButton(
          onPressed: () => _createTermin(),
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  Widget _createCalendar(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      dataSource: MeetingDataSource(getAppointments()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TerminBloc(
        terminRepository: RepositoryProvider.of<TerminRepository>(context),
      ),
      child: Scaffold(
        // appBar: _createAppBar(context),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: _createAppBar(context)),
        body: _createBody(context),
      ),
    );
  }
}
