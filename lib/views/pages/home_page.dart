import 'package:flutter/material.dart';
import 'package:new_app/views/pages/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
 
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(20.0),
    child: Column(children: [
         HeroWidget(),
    ],),
    
    );
  }
}
