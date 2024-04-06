import 'package:animations_example/utils/screen_size.dart';
import 'package:animations_example/widgets/animated_button.dart';
import 'package:animations_example/widgets/animated_container.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isImplicit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        width: ScreenSize.width,
        height: ScreenSize.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTabs(),
            SizedBox(height: ScreenSize.height * 0.1),
            isImplicit
                ? const AnimatedContainerWidget()
                : const AnimatedButtonWidget(),
          ],
        ),
      ),
    );
  }

  Row _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ChoiceChip(
          label: Text(
            'Implicit Animation',
            style: TextStyle(color: isImplicit ? Colors.white : Colors.black),
          ),
          selected: isImplicit,
          onSelected: (bool value) => setState(() => isImplicit = value),
          showCheckmark: false,
          selectedColor: Colors.blue,
        ),
        ChoiceChip(
          label: Text(
            'Explicit Animation',
            style: TextStyle(color: !isImplicit ? Colors.white : Colors.black),
          ),
          selected: !isImplicit,
          onSelected: (bool value) => setState(() => isImplicit = !value),
          showCheckmark: false,
          selectedColor: Colors.blue,
        ),
      ],
    );
  }
}
