import 'package:flutter/material.dart';
import 'package:shop_app/widgets/analysis_grid.dart';

class Analysis extends StatelessWidget {
  const Analysis({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
        child: Image.asset(
          'images/analysis.png',
          fit: BoxFit.fill,
        ),
      ),
      AnalysisGrid(),
    ]));
  }
}
