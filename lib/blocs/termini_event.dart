import 'package:lab3_mis_196023/model/Termin.dart';

abstract class TerminiEvent {}

class TerminiInitializedEvent extends TerminiEvent {}

class TerminAddedEvent extends TerminiEvent {
  final Termin termin;
  TerminAddedEvent({required this.termin});
}

class TerminDeletedEvent extends TerminiEvent {
  final String id;
  TerminDeletedEvent({required this.id});
}