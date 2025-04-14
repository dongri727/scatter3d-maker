import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class HintCsvConfig extends StatelessWidget{
  const HintCsvConfig({super.key});

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
          const Text(
              "ここにCSV設定を入力",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
            ),
        ],
      ),
    );
  }
}