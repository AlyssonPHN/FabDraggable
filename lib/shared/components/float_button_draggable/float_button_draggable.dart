
import 'package:button_instabug_sample/shared/components/float_button_draggable/controller/fab_floating_controller.dart';
import 'package:button_instabug_sample/shared/components/flying_letter_popup/flying_letter_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionButtonDrag extends StatelessWidget {
  final FabCubit controller;

  const FloatingActionButtonDrag({super.key, required this.controller});

  void _showPopup(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black.withOpacity(0.5),
        barrierDismissible: true,
        pageBuilder: (context, _, __) => const FlyingLetterPopup(),
      ),
    );
  }

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
            onPanUpdate: (details) =>
                controller.onPanUpdate(details, screenSize),
            onPanEnd: (details) => controller.onPanEnd(details, screenSize),
            onPanCancel: controller.onPanCancel,
            onTap: () => _showPopup(context),
            child: Hero(
              tag: 'fab-to-popup',
              child: FloatingActionButton(
                key: const ValueKey('floatingActionButton'),
                shape: const CircleBorder(),
                onPressed: null, // Gesture handled by GestureDetector
                heroTag: null, // Hero widget is handling the animation
                backgroundColor: Colors.white,
                elevation: 6,
                child: const Icon(Icons.chat, color: Colors.deepPurple, size: 28),
              ),
            ),
          ),
        );
      },
    );
  }
}
