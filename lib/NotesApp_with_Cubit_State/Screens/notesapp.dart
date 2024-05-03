import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Cubits/notescubit.dart";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Cubits/notesstates.dart";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Database/dbhelper.dart";
import "package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Screens/adddatascreen.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotesCubit(dbHelper: DbHelper.dbHelper);
      },
      child: MaterialApp(
        title: "Notes App using Cubit",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const NotesApp(),
      ),
    );
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() {
    return NotesAppState();
  }
}

class NotesAppState extends State<NotesApp> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotesCubit, NotesStates>(
        builder: (context, state) {
          if (state is NotesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is NotesLoadedState) {
            return ListView.builder(
              itemCount: state.arrNotes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    title: Text(
                      state.arrNotes[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(state.arrNotes[index].desc),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<NotesCubit>()
                            .deleteNotes(state.arrNotes[index].id!.toInt());
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            );
          } else if (state is NotesErrorState) {
            return Center(
              child: Text(
                state.errormsg.toString(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const AddDataScreen();
              },
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
    );
  }
}
