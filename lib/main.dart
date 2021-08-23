import 'package:flutter/material.dart';
import 'package:login/screens/screens.dart';
import 'package:login/services/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ProductsServices())],
        child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ecommer',
      initialRoute: 'home',
      routes: {
        'login': (context) => LoginScreen(),
        'home': (context) => HomeScreen(),
        'product': (context) => ProductScreen(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[200],
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.red, centerTitle: true),
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.red)),
    );
  }
}
