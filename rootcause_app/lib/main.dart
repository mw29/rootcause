import 'package:flutter/material.dart';
import 'package:rootcause_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: Colors.black,
          secondary: Colors.white,
          tertiary: Color.fromRGBO(49, 87, 44, 1),
        ),
      ).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.black,
          tertiary: Color.fromRGBO(49, 87, 44, 1),
        ),
      ).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
