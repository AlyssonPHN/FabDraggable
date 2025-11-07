
import 'package:flutter/material.dart';

class FlyingLetterPopup extends StatefulWidget {
  const FlyingLetterPopup({super.key});

  @override
  State<FlyingLetterPopup> createState() => _FlyingLetterPopupState();
}

class _FlyingLetterPopupState extends State<FlyingLetterPopup>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initShakeAnimation();
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
    _shakeController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _sendLetter() {
    if (_textController.text.trim().isEmpty) {
      _shakeController.forward(from: 0.0);
    } else {
      if (mounted) {
        // The pop animation will be handled by the Hero controller
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A semi-transparent barrier that closes the popup on tap
      backgroundColor: Colors.black.withOpacity(0.5),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Center(
          child: SlideTransition(
            position: _shakeAnimation,
            child: Hero(
              tag: 'fab-to-popup',
              child: _PopupCard(
                onSend: _sendLetter,
                textController: _textController,
              ),
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
    // Prevents taps inside the card from closing the popup
    return GestureDetector(
      onTap: () {},
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
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
          ),
        ),
      ),
    );
  }
}
