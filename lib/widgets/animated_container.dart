import 'package:animations_example/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedContainerWidget extends StatefulWidget {
  const AnimatedContainerWidget({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerWidget> createState() =>
      _AnimatedContainerWidgetState();
}

class _AnimatedContainerWidgetState extends State<AnimatedContainerWidget> {
  double _radius = 10;
  double _width = 200;
  double _height = 200;
  Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildContainer(),
        const SizedBox(height: 30),
        _buildBtn(),
      ],
    );
  }

  AnimatedContainer _buildContainer() {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 40),
      duration: const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(_radius),
      ),
    );
  }

  GestureDetector _buildBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(1.0);
          _radius = math.Random().nextDouble() * 51;
          _width = math.Random().nextDouble() * 301;
          _height = math.Random().nextDouble() * 301;
        });
      },
      child: Container(
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
    );
  }
}
