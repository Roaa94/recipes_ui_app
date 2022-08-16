import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vikings/playground/interactive_grid/interactive_grid_3.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: InteractiveGrid(
          maxHAxisCount: 6,
          minHAxisCount: 3,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.bottom -
              MediaQuery.of(context).padding.top,
        ),
      ),
    );
  }
}
