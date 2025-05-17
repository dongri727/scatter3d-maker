import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(AppLocalizations.of(context)!.hintI),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}