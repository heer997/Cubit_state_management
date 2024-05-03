import "package:cubit_wslc_statemanagement/CounterApp_with_Cubit_State/Cubit/counterstates.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CounterNotesCubit extends Cubit<CounterState> {
  CounterNotesCubit() : super(CounterState(countvalue: 0));

  increment() {
    emit(
      CounterState(countvalue: state.countvalue + 1),
    );
  }
}
