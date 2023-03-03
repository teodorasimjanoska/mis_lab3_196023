
import 'package:flutter/material.dart';
import 'package:lab3_mis_196023/model/termin.dart';
import 'package:lab3_mis_196023/screens/termin_details_screen.dart';

class TerminTile extends StatelessWidget {
  final Termin termin;
  final Function func;

  void _showDetail(BuildContext context) {
    Navigator.of(context).pushNamed(
      TerminDetailsScreen.routeName,
      arguments: termin,
    );
  }

  TerminTile(this.termin, this.func);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 10,
      ),
      child: ListTile(
        title: Text(termin.predmet, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text("${termin.datumIVreme.day}.${termin.datumIVreme.month}.${termin.datumIVreme.year} ${termin.datumIVreme.hour}:${termin.datumIVreme.minute}"),
        onTap: () => _showDetail(context),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => func(context, termin.id),
        ),
      ),
    );
  }
}