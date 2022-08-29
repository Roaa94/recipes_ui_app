import 'package:flutter/material.dart';
import 'package:recipes_ui/playground/animated_scroll_view/animated_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        bottom: false,
        child: AnimatedListView(),
      ),
    );
  }
}
