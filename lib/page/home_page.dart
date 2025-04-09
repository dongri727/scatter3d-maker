import 'package:flutter/material.dart';
import 'package:scatter3d_maker/widget/snackbar.dart';
import 'second_page.dart';
import '../widget/axis_config_widget.dart';
import '../widget/text_field.dart';
import '../application/import_csv.dart';
import '../constants/app_colors.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _showValidation = false;
  String scatterTitle = '';
  String xLegend = '';
  double xMin = 0.0;
  double xMax = 0.0;
  String yLegend = '';
  double yMin = 0.0;
  double yMax = 0.0;
  String zLegend = '';
  double zMin = 0.0;
  double zMax = 0.0;

  @override
  Widget build(BuildContext context) {
    void importCSV() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ImportCsv()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Upload your csv data"),
        // actions: [
        //   IconButton(
        //     onPressed: onPressed, 
        //     icon: const Icon(Icons.question_mark))
        // ],
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
                    setState(() {
                      scatterTitle = value;
                    });
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
                  legend: xLegend,
                  minVal: xMin,
                  maxVal: xMax,
                  onLegendChanged: (value) => setState(() => xLegend = value),
                  onMinValChanged: (value) => setState(() => xMin = value),
                  onMaxValChanged: (value) => setState(() => xMax = value),
                ),
                AxisConfigWidget(
                  axisLabel: 'y',
                  legend: yLegend,
                  minVal: yMin,
                  maxVal: yMax,
                  onLegendChanged: (value) => setState(() => yLegend = value),
                  onMinValChanged: (value) => setState(() => yMin = value),
                  onMaxValChanged: (value) => setState(() => yMax = value),
                ),
                AxisConfigWidget(
                  axisLabel: 'z',
                  legend: zLegend,
                  minVal: zMin,
                  maxVal: zMax,
                  onLegendChanged: (value) => setState(() => zLegend = value),
                  onMinValChanged: (value) => setState(() => zMin = value),
                  onMaxValChanged: (value) => setState(() => zMax = value),
                ),
                ElevatedButton.icon(         
                  onPressed: () {
                    setState(() {
                      _showValidation = true;
                    });
                    if (_formKey.currentState!.validate()) {
                      if(xMax > xMin && yMax > yMin && zMax > zMin){
                        importCSV();
                      } else {
                        FailureSnackBar.show('最大値最小値の設定に不備があります。設定内容をご確認ください。');
                      }
                    } else {
                      FailureSnackBar.show('入力内容に不備があります。エラーメッセージをご確認ください。');
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
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SecondPage(scatterTitle))
          );
        },
        child: const Icon(Icons.last_page),
      ),
    );
  }
}
