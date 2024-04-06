import 'package:animations_example/utils/screen_size.dart';
import 'package:flutter/material.dart';

class AnimatedButtonWidget extends StatefulWidget {
  const AnimatedButtonWidget({super.key});

  @override
  State<AnimatedButtonWidget> createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _sizeController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _sizeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _scaleController.forward();
        _sizeController.forward();
      },
      onTapUp: (_) {
        _scaleController.reverse();
        _sizeController.reverse();
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 0.85).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.linear,
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: ScreenSize.height * 0.06,
              width: ScreenSize.width * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Animate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _sizeController,
              builder: (_, __) {
                return Container(
                  width: (ScreenSize.width * 0.6) * _sizeController.value,
                  height: ScreenSize.height * 0.06,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
