import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class HintProjectConfig extends StatelessWidget{
  const HintProjectConfig({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.hintProjectConfig),      
      ),
      body: SingleChildScrollView( 
        child: Column(
          children: <Widget>[
            const Text(
              "画面イメージ",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
            ),
            Image.asset("assets/images/img_project_config.png"),
            const Text(
              "各軸の設定",
               style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                ),
            ),
            const ListTile(
                title: Text('①項目名：各軸の項目名を入力してください。')
            ),
            const ListTile(
                title: Text('②最大値：各軸のグラフ上の最大値を入力してください。')
            ),
            const ListTile(
                title: Text('③最小値：各軸のグラフ上の最小値を入力してください。')
            ),
            const ListTile(
                title: Text('※全て入力必須項目です。')
            ),
            const ListTile(
                title: Text('※最大値が最小値より大きくなるように設定してください。')
            ),
          ],
        ), 
      ),
    );
  }
}