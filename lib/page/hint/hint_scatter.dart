import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class HintScatterPage extends StatelessWidget{
  const HintScatterPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.hintScatterImages),      
      ),
      body: Column(
        children: <Widget>[
          Image.asset("assets/images/img_scatter.png")
        ],
      ),
    );
  }
}