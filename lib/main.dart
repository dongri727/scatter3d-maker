import 'package:flutter/material.dart';
import 'page/top_page.dart';
import 'widget/snackbar.dart';
import 'package:provider/provider.dart';
import 'providers/project_provider.dart';
import 'database/sembast_database.dart';
import 'utils/log_control.dart';
import 'package:logging/logging.dart';
LogControl logControl = LogControl.getInstance();
Logger log = Logger('main');


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // データベースの初期化を待つ
  final database = await SembastDatabase().database;
  logControl.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scatter3D Maker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TopPage(),
      scaffoldMessengerKey: SuccessSnackBar.messengerKey,
    );
  }
}


