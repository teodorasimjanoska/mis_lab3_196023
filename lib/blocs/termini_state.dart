import '../model/Termin.dart';

abstract class TerminiState {}

class TerminiInitState extends TerminiElementsState {
  TerminiInitState() : super(termini: []) {
    this.termini = [];
  }
}

class TerminiEmptyState extends TerminiState {}

class TerminiElementsState extends TerminiState {
  List<Termin> termini;
  TerminiElementsState({required this.termini});
}

class TerminiError extends TerminiState {
  final error;
  TerminiError({this.error});
}