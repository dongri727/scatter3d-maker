import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HintProjectConfig extends StatelessWidget{
  const HintProjectConfig({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( 
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  AppLocalizations.of(context)!.hintE,
                   style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
                ),
              ),
              Image.asset(
                height: 400,
                  AppLocalizations.of(context)!.hintF),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  AppLocalizations.of(context)!.hintG,
                   style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    ),
                ),
              ),
               Text(AppLocalizations.of(context)!.hintH),
            ],
          ),
        ), 
      ),
    );
  }
}