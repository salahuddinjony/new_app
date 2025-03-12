import 'package:flutter/material.dart';
import 'package:new_app/views/pages/hero_widget.dart';
import 'package:new_app/views/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
        SizedBox(height: 100,),
         HeroWidget(),
          SizedBox(height: 60,),
          FilledButton(
          onPressed:() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (context) {
                return WidgetTree();
              },
              ),
            );
          }, 
          child: Text("Login"))
        
        ],),
      ),

    );
  }
}