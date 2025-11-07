
import 'package:button_instabug_sample/shared/constants/Dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';

class FabCubit extends Cubit<FabState> {
  FabCubit()
      : super(FabState(
          isVisible: true,
          targetUrl: '',
          position: const Offset(20, 100),
          isDragging: false,
          isPopupVisible: false,
        ));

  bool _hasMoved = false;
  Offset? _startPosition;

  void setEnabled() => emit(state.copyWith(isVisible: true));
  void setDisabled() => emit(state.copyWith(isVisible: false));
  void setTargetUrl(String url) => emit(state.copyWith(targetUrl: url));
  void setPosition(Offset newPosition) => emit(state.copyWith(position: newPosition));
  void setDragging(bool dragging) => emit(state.copyWith(isDragging: dragging));
  void showPopup() => emit(state.copyWith(isPopupVisible: true));
  void hidePopup() => emit(state.copyWith(isPopupVisible: false));

  void onPanStart(DragStartDetails details) {
    _hasMoved = false;
    _startPosition = details.globalPosition;
    setDragging(false);
  }

  void onPanUpdate(DragUpdateDetails details, Size screenSize) {
    if (_startPosition != null) {
      final distance = (details.globalPosition - _startPosition!).distance;
      if (distance > 10 && !_hasMoved) {
        _hasMoved = true;
        setDragging(true);
      }
    }
    if (_hasMoved) {
      final newPosition = Offset(
        (state.position.dx + details.delta.dx).clamp(0.0, screenSize.width - 56),
        (state.position.dy + details.delta.dy).clamp(50, screenSize.height - 156),
      );
      setPosition(newPosition);
    }
  }

  void onPanEnd(DragEndDetails details, Size screenSize) {
    if (_hasMoved) {
      setDragging(false);
      snapToEdge(screenSize);
    }
    _hasMoved = false;
    _startPosition = null;
  }

  void onPanCancel() {
    setDragging(false);
    _hasMoved = false;
    _startPosition = null;
  }

  void snapToEdge(Size screenSize) {
    final centerX = screenSize.width / 2;
    const buttonSize = Dimens.size56;

    final newPosition = Offset(
      state.position.dx < centerX
          ? Dimens.size16
          : screenSize.width - buttonSize - Dimens.size16,
      state.position.dy.clamp(
        Dimens.size50,
        screenSize.height - buttonSize - Dimens.size100,
      ),
    );
    emit(state.copyWith(position: newPosition));
  }
}

class FabState {
  final bool isVisible;
  final String targetUrl;
  final Offset position;
  final bool isDragging;
  final bool isPopupVisible;

  FabState({
    required this.isVisible,
    required this.targetUrl,
    required this.position,
    required this.isDragging,
    required this.isPopupVisible,
  });

  FabState copyWith({
    bool? isVisible,
    String? targetUrl,
    Offset? position,
    bool? isDragging,
    bool? isPopupVisible,
  }) {
    return FabState(
      isVisible: isVisible ?? this.isVisible,
      targetUrl: targetUrl ?? this.targetUrl,
      position: position ?? this.position,
      isDragging: isDragging ?? this.isDragging,
      isPopupVisible: isPopupVisible ?? this.isPopupVisible,
    );
  }
}
