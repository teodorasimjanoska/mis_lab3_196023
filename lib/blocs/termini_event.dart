import 'package:equatable/equatable.dart';
import 'package:lab3_mis_196023/model/termin.dart';

abstract class TerminEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TerminiInitializedEvent extends TerminEvent {}

class TerminAddedEvent extends TerminEvent {
  final Termin termin;
  TerminAddedEvent({required this.termin});
}

class TerminDeletedEvent extends TerminEvent {
  final String id;
  TerminDeletedEvent({required this.id});
}

class GetData extends TerminEvent {
  GetData();
}