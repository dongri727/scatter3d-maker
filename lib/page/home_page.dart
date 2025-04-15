import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import 'second_page.dart';
import '../widget/axis_config_widget.dart';
import '../widget/text_field.dart';
import '../widget/hint_page.dart';
import '../constants/app_colors.dart';
import 'home_page_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _showValidation = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageModel>(
      create: (_) => HomePageModel(),
      child: Builder(
        builder: (context) {
          final model = Provider.of<HomePageModel>(context);


    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Upload your csv data"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HintPage(), fullscreenDialog: true),
              );
            }, 
            icon: const Icon(Icons.question_mark))
        ],
      ),
      
            body: Center(
              child: Form(
                key: _formKey,
                autovalidateMode: _showValidation
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MyTextField(
                        label: 'タイトル',
                        hintText: '散布図のタイトル名を入力してください',
                        onChanged: (value) {
                          model.setScatterTitle(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '必須項目です';
                          }
                          return null;
                        },
                      ),
                      AxisConfigWidget(
                        axisLabel: 'x',
                        legend: model.xLegend,
                        minVal: model.xMin,
                        maxVal: model.xMax,
                        onLegendChanged: (value) => model.setXLegend(value),
                        onMinValChanged: (value) => model.setXMin(value),
                        onMaxValChanged: (value) => model.setXMax(value),
                      ),
                      AxisConfigWidget(
                        axisLabel: 'y',
                        legend: model.yLegend,
                        minVal: model.yMin,
                        maxVal: model.yMax,
                        onLegendChanged: (value) => model.setYLegend(value),
                        onMinValChanged: (value) => model.setYMin(value),
                        onMaxValChanged: (value) => model.setYMax(value),
                      ),
                      AxisConfigWidget(
                        axisLabel: 'z',
                        legend: model.zLegend,
                        minVal: model.zMin,
                        maxVal: model.zMax,
                        onLegendChanged: (value) => model.setZLegend(value),
                        onMinValChanged: (value) => model.setZMin(value),
                        onMaxValChanged: (value) => model.setZMax(value),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            _showValidation = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            if (model.xMax > model.xMin &&
                                model.yMax > model.yMin &&
                                model.zMax > model.zMin) {
                            } else {
                              FailureSnackBar.show(
                                  '最大値最小値の設定に不備があります。設定内容をご確認ください。');
                            }
                          } else {
                            FailureSnackBar.show(
                                '入力内容に不備があります。エラーメッセージをご確認ください。');
                          }
                        },
                        icon: const Icon(Icons.file_upload),
                        label: const Text('Import CSV'),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Providerから集約済みのscatterDataを取得してSecondPageへ
                final scatterData = model.scatterPlotData;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(scatterData)),
                );
              },
              child: const Icon(Icons.last_page),
            ),
          );
        },
      ),
    );
  }
}