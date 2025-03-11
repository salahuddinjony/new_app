import 'package:flutter/material.dart';
import 'package:new_app/data/notifiers.dart';
import 'package:new_app/views/widget_tree.dart';
import 'package:new_app/views/widgets/navbar_widget.dart';

void main() {
  runApp(const MyApp());
}

//statefull ---> Can Refresh ✅
//stateless ---> Cannot Refresh ❌
//material app----> Cannot Refresh ❌
//scaffold --->Can Refresh ✅

// Material app
//Scaffold
//App title
//Bottom navigation bar setState

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
   return ValueListenableBuilder(
    valueListenable:  isDarkModeNotifier,
    builder: (context, isDarkMode, child) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness:isDarkMode? Brightness.dark :Brightness.light,
        ),
      ),
      home: WidgetTree(),
    );
      
    },
   );
  }
}
