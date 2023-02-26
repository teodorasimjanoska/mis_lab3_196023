import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/blocs/termini_state.dart';

import '../model/Termin.dart';

class TerminiBloc extends Bloc<TerminiEvent, TerminiState> {
  List<Termin> _termini = [];

  TerminiBloc() : super(TerminiInitState()) {
    on<TerminiInitializedEvent>((event, emin) {
      this._termini = [
        Termin(id: "1", predmet: "MIS", datumIVreme: DateTime(2022, 1, 1),)
      ];
      // datumIVreme: DateTime.parse("2022-07-20 20:18:04Z")
      TerminiInitState state = TerminiInitState();
      state.termini = this._termini;
      emit(state);
    });
    on<TerminAddedEvent>((event, emit) {
      this._termini.add(event.termin);
      emit(TerminiElementsState(termini: this._termini));
    });
    on<TerminDeletedEvent>((event, emit) {
      this._termini.removeWhere((element) => element.id == event.id);
      if (this._termini.length > 0) {
        emit(TerminiElementsState(termini: this._termini));
      } else {
        emit(TerminiEmptyState());
      }
    });
  }
}
