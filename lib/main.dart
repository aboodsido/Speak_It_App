import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'model_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModelTheme(),
      child: Consumer<ModelTheme>(
          builder: (context, ModelTheme themeNotifier, child) {
        return MaterialApp(
          title: 'Speak It App',
          theme: themeNotifier.isDark
              ? ThemeData(brightness: Brightness.dark)
              : ThemeData(brightness: Brightness.light),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          home: const SpeakIt(),
        );
      }),
    );
  }
}
