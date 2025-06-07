import 'package:animations_example/utils/app_colors.dart';
import 'package:animations_example/utils/screen_size.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const AnimatedButton(
      {super.key, required this.onTap, required this.onLongPress});

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _sizeController;

  bool _longPressInProgress = false;
  bool _longPressAllowed = false;

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

  void _onLongPressStart(_) async {
    _longPressInProgress = true;
    _longPressAllowed = false;

    await Future.wait([
      _scaleController.forward(),
      _sizeController.forward(),
    ]);

    if (_longPressInProgress) _longPressAllowed = true;
  }

  void _onLongPressEnd() {
    _longPressInProgress = false;

    if (!_longPressAllowed) {
      _scaleController.reverse();
      _sizeController.reverse();
      return;
    }

    _scaleController.reset();
    _sizeController.reset();

    widget.onLongPress();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPressStart: _onLongPressStart,
      onLongPressEnd: (_) => _onLongPressEnd(),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1, end: 0.85).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: Curves.linear,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ScreenSize.width * 0.6,
              height: ScreenSize.height * 0.05,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Tap or Hold',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSize.width * 0.042,
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
                  height: ScreenSize.height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.12),
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
