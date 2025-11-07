
import 'package:button_instabug_sample/shared/components/float_button_draggable/controller/fab_floating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionButtonDrag extends StatelessWidget {
  final FabCubit controller;

  const FloatingActionButtonDrag({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<FabCubit, FabState>(
      bloc: controller,
      builder: (context, state) {
        if (!state.isVisible) return const SizedBox.shrink();

        return Positioned(
          left: state.position.dx,
          top: state.position.dy,
          child: GestureDetector(
            onPanStart: controller.onPanStart,
            onPanUpdate: (details) => controller.onPanUpdate(details, screenSize),
            onPanEnd: (details) => controller.onPanEnd(details, screenSize),
            onPanCancel: controller.onPanCancel,
            onTap: controller.showPopup,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(state.isDragging ? 1.1 : 1.0),
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  key: const ValueKey('floatingActionButton'),
                  shape: const CircleBorder(),
                  onPressed: null, // Gesture handled by GestureDetector
                  heroTag: "immediateDragButton",
                  backgroundColor: Colors.white,
                  elevation: state.isDragging ? 12 : 6,
                  child: const Icon(Icons.chat, color: Colors.deepPurple, size: 28),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
