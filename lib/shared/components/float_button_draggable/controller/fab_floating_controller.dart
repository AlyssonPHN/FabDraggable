
import 'package:button_instabug_sample/shared/constants/Dimens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/animation.dart' show Offset, Size;

class FabCubit extends Cubit<FabState> {
  FabCubit()
      : super(FabState(
    isVisible: true,
    targetUrl: '',
    position: const Offset(20, 100),
    isDragging: false,
  ));

  void setEnabled() => emit(state.copyWith(isVisible: true));
  void setDisabled() => emit(state.copyWith(isVisible: false));
  void setTargetUrl(String url) => emit(state.copyWith(targetUrl: url));
  void setPosition(Offset newPosition) => emit(state.copyWith(position: newPosition));
  void setDragging(bool dragging) => emit(state.copyWith(isDragging: dragging));

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

  FabState({
    required this.isVisible,
    required this.targetUrl,
    required this.position,
    required this.isDragging,
  });

  FabState copyWith({
    bool? isVisible,
    String? targetUrl,
    Offset? position,
    bool? isDragging,
  }) {
    return FabState(
      isVisible: isVisible ?? this.isVisible,
      targetUrl: targetUrl ?? this.targetUrl,
      position: position ?? this.position,
      isDragging: isDragging ?? this.isDragging,
    );
  }
}
