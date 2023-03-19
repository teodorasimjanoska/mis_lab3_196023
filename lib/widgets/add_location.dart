import 'package:flutter/material.dart';
import 'package:lab3_mis_196023/service/location_service.dart';

import '../screens/map_page.dart';

class AddLocation extends StatefulWidget {

  @override
  State<AddLocation> createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            child: Text(
              "Pokazhi mapa",
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: Text(
              "Pokazhi ruta",
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
        ],
      ),
    );
  }
}
