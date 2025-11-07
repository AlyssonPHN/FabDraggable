
import 'package:button_instabug_sample/shared/components/float_button_draggable/controller/fab_floating_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlyingLetterPopup extends StatefulWidget {
  const FlyingLetterPopup({super.key});

  @override
  State<FlyingLetterPopup> createState() => _FlyingLetterPopupState();
}

class _FlyingLetterPopupState extends State<FlyingLetterPopup>
    with TickerProviderStateMixin {
  late AnimationController _flyController;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFlyAnimation();
    _initShakeAnimation();
  }

  void _initFlyAnimation() {
    _flyController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -2.0),
    ).animate(CurvedAnimation(
      parent: _flyController,
      curve: Curves.easeIn,
    ));

    _fadeAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _flyController,
      curve: Curves.easeIn,
    ));
  }

  void _initShakeAnimation() {
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _shakeAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: const Offset(0, 0), end: const Offset(-0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(0.05, 0), end: const Offset(-0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(0.05, 0), end: const Offset(-0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(0.05, 0), end: const Offset(-0.05, 0)), weight: 1.0),
      TweenSequenceItem(tween: Tween(begin: const Offset(-0.05, 0), end: const Offset(0, 0)), weight: 1.0),
    ]).animate(_shakeController);
  }

  @override
  void dispose() {
    _flyController.dispose();
    _shakeController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _sendLetter() {
    if (_textController.text.trim().isEmpty) {
      _shakeController.forward(from: 0.0);
    } else {
      _flyController.forward().whenComplete(() {
        context.read<FabCubit>().hidePopup();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeroControllerScope.none(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            color: Colors.transparent,
            child: Navigator(
              onGenerateRoute: (settings) {
                return PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (context, _, __) => Center(
                    child: SlideTransition(
                      position: _shakeAnimation,
                      child: _PopupCard(
                        onSend: _sendLetter,
                        textController: _textController,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PopupCard extends StatelessWidget {
  final VoidCallback onSend;
  final TextEditingController textController;

  const _PopupCard({
    required this.onSend,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Write your message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: textController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'Type something...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onSend,
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
