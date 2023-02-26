import 'package:flutter/material.dart';
import 'package:lab3_mis_196023/model/Termin.dart';
import 'package:nanoid/nanoid.dart';

class NovTermin extends StatefulWidget {
  final Function addTermin;

  NovTermin(this.addTermin);

  @override
  State<StatefulWidget> createState() => _NovTerminState();
}

class _NovTerminState extends State<NovTermin> {
  final _predmetController = TextEditingController();
  final _datumController = TextEditingController();

  late String predmet;
  DateTime datum = DateTime.now();

  void _submitData() {
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
      id: nanoid(5),
      predmet: vnesenPredmet,
      datumIVreme: DateTime(
        int.parse(lst[2]),
        int.parse(lst[1]),
        int.parse(lst[0]),
      ),
    );
    widget.addTermin(context, novTermin);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _predmetController,
            decoration: InputDecoration(labelText: "Predmet"),
            // onChanged: (val) {},
            onSubmitted: (_) => _submitData(),
          ),
          Text(
            "Datumot ne e izbran",
          ),
          TextButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );

              if (newDate == null) return;

              setState(() {
                datum = newDate;
                _datumController.text =
                    "${datum.day}.${datum.month}.${datum.year}";
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
