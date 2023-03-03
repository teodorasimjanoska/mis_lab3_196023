import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:nanoid/nanoid.dart';

import '../blocs/termini_event.dart';
import '../model/termin.dart';
import '../service/notif_service.dart';

DateTime scheduleTime = DateTime.now();

class NovTermin extends StatefulWidget {
  final Function addTermin;

  NovTermin(this.addTermin);

  @override
  State<StatefulWidget> createState() => _NovTerminState();
}

class _NovTerminState extends State<NovTermin> {
  final _predmetController = TextEditingController();
  final _datumController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  bool vnesenDatum = false;

  late String predmet;
  DateTime datum = DateTime.now();
  String id = nanoid(5);

  void _submitData() async {
    if (_predmetController.text.isEmpty) {
      return;
    }

    final vnesenPredmet = _predmetController.text;
    final vnesenDatum = _datumController.text;

    List<String> lst = vnesenDatum.split(".");

    if (vnesenPredmet.isEmpty || vnesenDatum.isEmpty) {
      return;
    }

    final novTermin = Termin(
      id: id,
      predmet: vnesenPredmet,
      datumIVreme: DateTime(
        int.parse(lst[2]),
        int.parse(lst[1]),
        int.parse(lst[0]),
      ),
      userId: user.uid,
    );
    widget.addTermin(context, novTermin);

    NotificationService().scheduleNotification(
      body: '$scheduleTime',
      scheduledNotificationDateTime: scheduleTime,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _predmetController,
            decoration: InputDecoration(labelText: "Predmet"),
            // onChanged: (val) {},
            // onSubmitted: (_) => _submitData(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            !vnesenDatum
                ? "Datumot ne e izbran"
                : "${datum.day}.${datum.month}.${datum.year}",
          ),
          TextButton(
            onPressed: () async {
              // DateTime? newDate = await showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(1900),
              //   lastDate: DateTime(2100),
              // );
              //
              // if (newDate == null) return;
              //
              // setState(() {
              //   vnesenDatum = true;
              //   datum = newDate;
              //   _datumController.text =
              //       "${datum.day}.${datum.month}.${datum.year}";
              // });
              DateTime? newDate = await DatePicker.showDateTimePicker(
                  context,
                  showTitleActions: true,
                  onChanged: (date) => scheduleTime = date,
                  onConfirm: (date) {});

              if (newDate == null) return;

              setState(() {
                vnesenDatum = true;
                datum = newDate;
                _datumController.text = "${datum.day}.${datum.month}.${datum.year}";
              });
            },
            child: Text("Izberi datum"),
          ),
          ElevatedButton(
            onPressed: _submitData,
            child: Text("Dodadi"),
          ),
        ],
      ),
    );
  }
}
