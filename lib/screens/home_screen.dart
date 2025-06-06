import 'package:animations_example/utils/screen_size.dart';

import 'package:animations_example/widgets/animated_button.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _containerRadius = 10;
  double _containerWidth = 200;
  double _containerHeight = 200;
  Color _containerColor = Colors.blue;

  final Duration _duration = const Duration(milliseconds: 600);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: ScreenSize.width,
          height: ScreenSize.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildTitle(),
              _buildContainer(),
              _buildButton(),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildButton() {
    return Positioned(
      bottom: ScreenSize.height * 0.12,
      child: AnimatedButton(
        onTap: _randomizeContainer,
        onLongPress: () => _animateContainer(6),
      ),
    );
  }

  AnimatedContainer _buildContainer() {
    return AnimatedContainer(
      duration: _duration,
      curve: Curves.fastOutSlowIn,
      width: _containerWidth,
      height: _containerHeight,
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(_containerRadius),
      ),
    );
  }

  Future<void> _animateContainer(int times) async {
    for (int i = 0; i < times; i++) {
      _randomizeContainer();
      await Future.delayed(_duration);
    }
  }

  void _randomizeContainer() {
    setState(() {
      final random = math.Random();
      _containerColor = Color((random.nextDouble() * 0xFFFFFF).toInt())
          .withValues(alpha: 1.0);
      _containerRadius = random.nextDouble() * 51;
      _containerWidth = 100 + random.nextDouble() * 200;
      _containerHeight = 100 + random.nextDouble() * 200;
    });
  }

  Positioned _buildTitle() {
    return Positioned(
      top: ScreenSize.height * 0.15,
      child: Text(
        '✨ Flutter Animations ✨',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: ScreenSize.width * 0.07,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
          shadows: const [
            Shadow(
              blurRadius: 3,
              color: Colors.black12,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }
}
