import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

import '../model/termin.dart';

@immutable
abstract class TerminState extends Equatable{}

// class TerminiInitState extends TerminiElementsState {
//   TerminiInitState() : super(termini: []) {
//     this.termini = [];
//   }
// }
//
// class TerminiEmptyState extends TerminState {
//   @override
//   List<Object?> get props => [];
// }
//
// class TerminiElementsState extends TerminiState {
//   List<Termin> termini;
//   TerminiElementsState({required this.termini});
// }
//
// class TerminiError extends TerminiState {
//   final error;
//   TerminiError({this.error});
// }

class TerminInitState extends TerminState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class TerminAdding extends TerminState {
  @override
  List<Object?> get props => [];
}

class TerminAdded extends TerminState {
  @override
  List<Object?> get props => [];
}

class TerminError extends TerminState {
  final String error;
  TerminError(this.error);
  @override
  List<Object?> get props => [error];
}

class TerminLoading extends TerminState {
  @override
  List<Object?> get props => [];
}

class TerminLoaded extends TerminState {
  List<Termin> mydata;
  TerminLoaded(this.mydata);
  @override
  List<Object?> get props => [mydata];
}