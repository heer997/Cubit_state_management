import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Models/noteModel.dart';

abstract class NotesStates {}

class NotesInitialState extends NotesStates {}

class NotesLoadingState extends NotesStates {}

class NotesLoadedState extends NotesStates {
  List<NotesModel> arrNotes = [];
  int? id;

  NotesLoadedState({required this.arrNotes, this.id});
}

class NotesErrorState extends NotesStates {
  String errormsg;

  NotesErrorState({required this.errormsg});
}
