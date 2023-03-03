import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab3_mis_196023/blocs/termini_event.dart';
import 'package:lab3_mis_196023/blocs/termini_state.dart';

import '../model/termin.dart';
import '../repository/termin_repository.dart';

class TerminBloc extends Bloc<TerminEvent, TerminState> {
  List<Termin> _termini = [];
  final TerminRepository terminRepository;

  TerminBloc({required this.terminRepository}) : super(TerminInitState()) {
    // on<TerminiInitializedEvent>((event, emin) {
    //   this._termini = [];
    //   TerminInitState state = TerminInitState();
    //   state.termini = this._termini;
    //   emit(state);
    // });
    on<TerminAddedEvent>((event, emit) async {
      // this._termini.add(event.termin);
      // emit(TerminiElementsState(termini: this._termini));
      emit(TerminAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await terminRepository.create(id: event.termin.id,
            predmet: event.termin.predmet,
            datum: event.termin.datumIVreme,
            userId: event.termin.userId);
        emit(TerminAdded());
      } catch (e) {
        emit(TerminError(e.toString()));
      }
    });

    on<GetData>((event, emit) async {
      emit(TerminLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await terminRepository.get();
        emit(TerminLoaded(data));
      } catch (e) {
        emit(TerminError(e.toString()));
      }
    });
    // on<TerminDeletedEvent>((event, emit) {
    //   this._termini.removeWhere((element) => element.id == event.id);
    //   if (this._termini.length > 0) {
    //     emit(TerminiElementsState(termini: this._termini));
    //   } else {
    //     emit(TerminiEmptyState());
    //   }
    // });
  }
}
