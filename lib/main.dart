import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:expense_tracker/screens/expenses_screen.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(143, 114, 80, 206));
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(150, 96, 150, 231));

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then(
  //   (fn) => {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kDarkColorScheme.onSecondaryContainer,
            ),
          ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
      ),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kColorScheme.onSecondaryContainer,
            ),
          ),
    ),
    themeMode: ThemeMode.system,
    home: const ExpensesScreen(),
  ));
  //   },
  // );
}
