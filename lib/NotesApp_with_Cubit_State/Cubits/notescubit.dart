import "dart:developer";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Cubits/notesstates.dart";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Database/dbhelper.dart";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Models/noteModel.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class NotesCubit extends Cubit<NotesStates> {
  DbHelper dbHelper;

  NotesCubit({required this.dbHelper}) : super(NotesInitialState());

  addNotes(NotesModel newnotes) async {
    emit(NotesLoadingState());
    bool check = await dbHelper.addNotes(newnotes);
    if (check) {
      var notes = await dbHelper.fetchData();
      emit(NotesLoadedState(arrNotes: notes));
      log("Data Inserted Successfully...");
    } else {
      emit(NotesErrorState(errormsg: "Data not Inserted!"));
    }
  }

  void getAllNotes() async {
    emit(NotesLoadingState());
    var notes = await dbHelper.fetchData();
    emit(NotesLoadedState(arrNotes: notes));
  }

  deleteNotes(int id) async {
    emit(NotesLoadingState());
    bool check = await dbHelper.DeleteNotes(id);
    if(check)
      {
        var notes = await dbHelper.fetchData();
        emit(NotesLoadedState(arrNotes: notes));
      }
    else
      {
        emit(NotesErrorState(errormsg: "An Error Occurred!"));
      }
  }
}
