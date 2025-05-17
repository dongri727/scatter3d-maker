import 'package:flutter/material.dart';
import 'text_field.dart';
import '../constants/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AxisConfigWidget extends StatefulWidget{
  const AxisConfigWidget({
    super.key,
    required this.axisLabel, // x, y, zのいずれかが入力される
    required this.legend, // 各軸の項目名
    required this.minVal, // 各軸の最小値
    required this.maxVal, // 各軸の最大値
    required this.onLegendChanged,
    required this.onMinValChanged,
    required this.onMaxValChanged,
  });

  final String axisLabel;
  final String legend;
  final double minVal;
  final double maxVal;
  final Function(String) onLegendChanged;
  final Function(double) onMinValChanged;
  final Function(double) onMaxValChanged;

  static bool validateFormKey(GlobalKey<FormState> formKey) {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  State<AxisConfigWidget> createState() => _AxisConfigState();
}

class _AxisConfigState extends State<AxisConfigWidget>{
  @override
  Widget build(BuildContext content){
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        border: Border.all(color: AppColors.containerBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.axisLabel}${AppLocalizations.of(context)!.homeD}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          MyTextField( 
            label: '${widget.axisLabel}${AppLocalizations.of(context)!.homeE}',
            hintText: '${widget.axisLabel}${AppLocalizations.of(context)!.homeF}',
            initialValue: widget.legend,
            onChanged: widget.onLegendChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.alertA;
              }
              return null;
            },
          ),
          Row(
            children: [
              Flexible(
                child: MyTextField(
                  label: '${widget.axisLabel}${AppLocalizations.of(context)!.homeG}',
                  hintText: '${widget.axisLabel}${AppLocalizations.of(context)!.homeG}',
                  initialValue: widget.minVal.toString(),
                  onChanged: (value) => widget.onMinValChanged(double.tryParse(value) ?? 0.0),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.alertA;
                    }
                    if (double.tryParse(value) == null) {
                      return AppLocalizations.of(context)!.alertE;
                    }
                    return null;
                  },
                ),
              ),
              Flexible(
                child: MyTextField(
                  label: '${widget.axisLabel}${AppLocalizations.of(context)!.homeH}',
                  hintText: '${widget.axisLabel}${AppLocalizations.of(context)!.homeH}',
                  initialValue: widget.maxVal.toString(),
                  onChanged: (value) => widget.onMaxValChanged(double.tryParse(value) ?? 0.0),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.alertA;
                    }
                    if (double.tryParse(value) == null) {
                      return AppLocalizations.of(context)!.alertE;
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}