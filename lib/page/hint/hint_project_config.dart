import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class HintProjectConfig extends StatelessWidget{
  const HintProjectConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView( 
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  "入力画面で",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
                ),
              ),
              Image.asset(
                height: 400,
                  "assets/images/img_project_config.png"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: const Text(
                  "各軸の設定",
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
                ),
              ),
               Text('①項目名：軸に添える名称\n\n'
                      '②最大値：目盛りの最大値\n(データの最大値より大きく）\n\n'
                      '③最小値：目盛りの最小値。マイナスも可\n（データの最小値より小さく）\n\n'
                      '※全て必須、※最大値>最小値'
                  )
            ],
          ),
        ), 
      ),
    );
  }
}