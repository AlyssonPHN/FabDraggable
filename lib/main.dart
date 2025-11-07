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
        title: 'Draggable FAB',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.light,
          ),
        ),
        home: const MyHomePage(title: 'Draggable FAB'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Tap the button to open the popup!'),
          ),
          FloatingActionButtonDrag(controller: context.read<FabCubit>()),
        ],
      ),
    );
  }
}
