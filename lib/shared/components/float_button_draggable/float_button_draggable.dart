import 'package:button_instabug_sample/shared/components/float_button_draggable/controller/fab_floating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FloatingActionButtonDrag extends StatefulWidget {
  final FabCubit controller;

  const FloatingActionButtonDrag({super.key, required this.controller});

  @override
  State<FloatingActionButtonDrag> createState() => _FloatingActionButtonDragState();
}

class _FloatingActionButtonDragState extends State<FloatingActionButtonDrag> {
  bool _hasMoved = false;
  Offset? _startPosition;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocBuilder<FabCubit, FabState>(
      bloc: widget.controller,
      builder: (context, state) {
        if (!state.isVisible) return const SizedBox.shrink();

        return Positioned(
          left: state.position.dx,
          top: state.position.dy,
          child: GestureDetector(
            onPanStart: (details) {
              _hasMoved = false;
              _startPosition = details.globalPosition;
              widget.controller.setDragging(false);
            },
            onPanUpdate: (details) {
              if (_startPosition != null) {
                final distance = (details.globalPosition - _startPosition!).distance;
                if (distance > 10 && !_hasMoved) {
                  _hasMoved = true;
                  widget.controller.setDragging(true);
                }
              }
              if (_hasMoved) {
                final newPosition = Offset(
                  (state.position.dx + details.delta.dx).clamp(0.0, screenSize.width - 56),
                  (state.position.dy + details.delta.dy).clamp(50, screenSize.height - 156),
                );
                widget.controller.setPosition(newPosition);
              }
            },
            onPanEnd: (details) {
              if (_hasMoved) {
                widget.controller.setDragging(false);
                widget.controller.snapToEdge(screenSize);
              }
              _hasMoved = false;
              _startPosition = null;
            },
            onPanCancel: () {
              widget.controller.setDragging(false);
              _hasMoved = false;
              _startPosition = null;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.identity()..scale(state.isDragging ? 1.1 : 1.0),
              child: SizedBox(
                height: 50,
                width: 50,
                child: FloatingActionButton(
                  key: const ValueKey('floatingActionButton'),
                  shape: const CircleBorder(),
                  onPressed: () {
                    // Implemente a navegação conforme necessário
                  },
                  heroTag: "immediateDragButton",
                  backgroundColor: Colors.white,
                  elevation: state.isDragging ? 12 : 6,
                  child: const Icon(Icons.chat, color: Colors.deepPurple, size: 28),
                  // child: SvgPicture.asset(
                  //   'assets/icon_report_error.svg',
                  //   height: 28,
                  //   width: 28,
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
