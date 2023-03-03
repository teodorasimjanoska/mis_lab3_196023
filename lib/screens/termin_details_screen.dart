import 'package:flutter/material.dart';
import 'package:lab3_mis_196023/model/termin.dart';

class TerminDetailsScreen extends StatelessWidget {

  static const routeName = '/termin_details';

  @override
  Widget build(BuildContext context) {
    final termin = ModalRoute.of(context)?.settings.arguments as Termin;

    return Scaffold(
      appBar: AppBar(
        title: Text(termin.predmet),
      ),
      body: Column(
        children: [
          Text(termin.predmet),
          Text("${termin.datumIVreme}"),
        ],
      ),
    );
  }
}