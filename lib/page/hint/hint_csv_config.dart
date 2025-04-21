import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class HintCsvConfig extends StatelessWidget{
  const HintCsvConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: Image.asset(
                  height: 400,
                    "assets/images/sample.jpg",
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "ExcelやNumbersでつくったデータをCSVで書き出します。\n\n"
                    "idは各データの表示名、番号でも名前でも。\n\n"
                        "x,y,zはデータの座標、\n整数でも小数でも、プラスでもマイナスでも。\n\n"
                        "Colorはシンプルな色名を英語で、\n単色も可。\n\n"
                        "sizeは10、20, 30のいずれか。統一してもよい。\n"
                        "サンプル画像の一番小さいドットが10です。",
                      ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}