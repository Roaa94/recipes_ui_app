import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vikings/playground/interactive_grid/interactive_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return const Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveGrid(
        horizontalAxisCount: 6,
      ),
    );
  }
}
