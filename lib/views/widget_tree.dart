import 'package:flutter/material.dart';
import 'package:new_app/data/notifiers.dart';
import 'package:new_app/views/pages/add_to_card_page.dart';
import 'package:new_app/views/pages/card_page.dart';
import 'package:new_app/views/pages/home_page.dart';
import 'package:new_app/views/pages/profile_page.dart';
import 'package:new_app/views/pages/settings_page.dart';
import 'package:new_app/views/pages/todo_page.dart';
import 'widgets/navbar_widget.dart';

List<Widget> pages = [HomePage(),TodoPage(),CardPage(),AddToCartPage(productName: "productName", productPrice: 0.9, imageUrl: ""), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
        actions: [
          IconButton(
            onPressed: () {
              isDarkModeNotifier.value = !isDarkModeNotifier.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkModeNotifier,
              builder: (context, isDarkMode, child) {
                return Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode);
              },
            ),
          ),
          IconButton( 
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return settingsPage(title: 'Settings',);
                  },
                ),  
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return pages.elementAt(selectedPage);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
