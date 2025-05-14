import 'package:flutter/material.dart';
import 'page/top_page.dart';
import 'page/second_page.dart';
import 'widget/snackbar.dart';
import 'database/sembast_database.dart';
import 'package:provider/provider.dart';
import 'providers/project_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SembastDatabase().database;
  
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
      initialRoute: '/topPage',
      routes: {
        '/topPage': (context) => const TopPage(),
        '/secondPage': (context) => const SecondPage(
          parsedData: [],
          scatterData: [],
          csvFilePath: '',
        ),
      },
      scaffoldMessengerKey: SuccessSnackBar.messengerKey,
    );
  }
}


