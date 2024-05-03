import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Cubits/notescubit.dart';
import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Cubits/notesstates.dart';
import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Database/dbhelper.dart';
import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Models/noteModel.dart';
import 'package:cubit_wslc_statemanagement/NotesApp_with_Cubit_State/Utils/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: "NotesApp using Cubit State",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const AddDataScreen(),
      ),
    );
  }
}

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() {
    return AddDataScreenState();
  }
}

class AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Data Screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<NotesCubit, NotesStates>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiHelper.customTextFormField(
                  titleController,
                  "Enter the title",
                  Icons.title,
                ),
                UiHelper.customTextFormField(
                  descController,
                  "Enter the description",
                  Icons.description,
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                  onPressed: () {
                    context.read<NotesCubit>().addNotes(NotesModel(
                        title: titleController.text.toString(),
                        desc: descController.text.toString()));
                    titleController.clear();
                    descController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350.0, 50.0),
                    backgroundColor: Colors.blue,
                    shape: const LinearBorder(),
                  ),
                  child: const Text(
                    "Add Data",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
