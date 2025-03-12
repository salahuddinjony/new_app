import 'package:flutter/material.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key, required this.title});
  final String title;
  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChacked = false;
  bool isSwitch = false;
  double slideValue = 0.0;
  String? menuItem = 'e1';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                onPressed:() {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Hello"),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      ) 
                    );
                } , 
                child: Text("Onen Snackbar"),
                ),
                ElevatedButton(

                onPressed:() {
               showDialog(context: context, builder:(context) {
                 return AlertDialog(
                  
                  title: Text("Alert title"),
                  content: Text('Alert contenct'),
                  actions: [
                    FilledButton(
                      onPressed:() {
                        Navigator.pop(context);
                      },
                     child: Text("Close"))
                  ],
                 );
               },
               );
                } , 
                child: Text("Open Dialog"),
                ),
              DropdownButton(
                value: menuItem,
                items: [
                  DropdownMenuItem(value: 'e1', child: Text("Item1")),
                  DropdownMenuItem(value: 'e2', child: Text("Item2")),
                  DropdownMenuItem(value: 'e3', child: Text("Item3")),
                ],
                onChanged: (String? value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),
              TextField(
                controller: controller,
                decoration: InputDecoration(border: UnderlineInputBorder()),
                onEditingComplete: () {
                  setState(() {});
                },
              ),
              Text(controller.text),
              CheckboxListTile(
                title: Text("Click me"),
                value: isChacked,
                onChanged: (bool? value) {
                  setState(() {
                    isChacked = value;
                  });
                },
              ),
              SwitchListTile.adaptive(
                title: Text("Toggle me"),
                value: isSwitch,
                onChanged: (value) {
                  setState(() {
                    isSwitch = value;
                  });
                },
              ),
              Slider.adaptive(
                max: 10.0,
                divisions: 10,
                value: slideValue,
                onChanged: (value) {
                  setState(() {
                    slideValue = value;
                  });
                },
              ),
              InkWell(
                onTap: () {
                  print("Image seleceted!");
                },
                child: Container(
                  height: 20,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                ),
                child: Text("Click"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
