import "package:cubit_wslc_statemanagement/CounterApp_with_Cubit_State/Cubit/countercubit.dart";
import "package:cubit_wslc_statemanagement/CounterApp_with_Cubit_State/Cubit/counterstates.dart";
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
        return CounterNotesCubit();
      },
      child: MaterialApp(
        title: "CounterApp using Cubit",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.grey,
            centerTitle: true,
          ),
        ),
        home: const CounterStateApp(),
      ),
    );
  }
}

class CounterStateApp extends StatefulWidget {
  const CounterStateApp({super.key});

  @override
  State<CounterStateApp> createState() {
    return CounterStateAppState();
  }
}

class CounterStateAppState extends State<CounterStateApp> {
  @override
  Widget build(BuildContext context) {
    print("Build Method Called...");
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes App using Cubit",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterNotesCubit>().increment();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white, size: 30.0),
      ),
      body: BlocBuilder<CounterNotesCubit, CounterState>(
        builder: (context, state) {
          print("Builder is Called...");
          return Center(
            child: Text(
              state.countvalue.toString(),
              style:
                  const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
