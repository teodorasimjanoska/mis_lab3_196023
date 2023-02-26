import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/blocs/termini_state.dart';
import 'package:lab3_mis_196023/model/Termin.dart';
import 'package:lab3_mis_196023/widgets/nov_termin.dart';
import 'package:lab3_mis_196023/widgets/termin_tile.dart';

class MainScreen extends StatelessWidget {
  void _addItemFunction(BuildContext ct) {
    showModalBottomSheet(
        context: ct,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NovTermin(_addNewItemToList),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewItemToList(BuildContext ctx, Termin item) {
    final bloc = BlocProvider.of<TerminiBloc>(ctx);
    bloc.add(TerminAddedEvent(termin: item));
  }

  void _deleteItem(BuildContext ctx, String id) {
    final bloc = BlocProvider.of<TerminiBloc>(ctx);
    bloc.add(TerminDeletedEvent(id: id));
  }

  Widget _createBody(BuildContext context) {
    return BlocBuilder<TerminiBloc, TerminiState>(builder: (context, state) {
      return state.runtimeType == TerminiEmptyState
          ? Center(
              child: Text("Nema termini"),
            )
          : Center(
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return TerminTile(
                    (state as TerminiElementsState).termini[index],
                    _deleteItem,
                  );
                },
                itemCount: (state as TerminiElementsState).termini.length,
              ),
            );
    });
  }

  Widget _createAppBar(BuildContext context) {
    return AppBar(
      title: Text("Termini"),
      actions: <Widget>[
        IconButton(
          onPressed: () => _addItemFunction(context),
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _createAppBar(context),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _createAppBar(context)),
      body: _createBody(context),
    );
  }
}
