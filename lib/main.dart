import 'package:button_instabug_sample/shared/components/float_button_draggable/controller/fab_floating_controller.dart';
import 'package:button_instabug_sample/shared/components/float_button_draggable/float_button_draggable.dart';
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
      create: (_) => FabCubit(),
      child: MaterialApp(
        title: 'Fab Draggable',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
          ),
        builder: (context, child) {
          final fabCubit = BlocProvider.of<FabCubit>(context);
          return Stack(
            children: [
              child!,
              FloatingActionButtonDrag(controller: fabCubit),
            ],
          );
        },
        home: const MyHomePage(title: 'Fab Draggable'),

      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final fabCubit = BlocProvider.of<FabCubit>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox.shrink()

      // Stack(
      //   children: [
      //     Center(
      //       child: Text(
      //         'Fab Draggable',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
