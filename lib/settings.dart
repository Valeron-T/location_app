// Settings page
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:drone_app/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isDarkTheme = Hive.box('easyTheme').get('CurrentTheme');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded,
              color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        shadowColor: Colors.transparent,
        title: Text("Settings"),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        alignment: Alignment.center,
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: Column(
          children: [
            // User instructions
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Theme.of(context).colorScheme.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.brush_rounded,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Personalise your experience",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 1 on settings
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1.5,
                          blurRadius: 4,
                          color: Color.fromARGB(31, 211, 211, 211))
                    ],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Dark Theme"),
                        ),
                        Center(
                          child: CupertinoSwitch(
                            value: isDarkTheme,
                            onChanged: (value) {
                              // Value is true
                              isDarkTheme = value;
                              print(isDarkTheme);
                              currentTheme.switchTheme(value);
                            },
                            trackColor: Colors.red,
                            activeColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 2
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ],
                      color: Theme.of(context).colorScheme.primary),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Distance Units"),
                        ),
                        CupertinoSwitch(
                            value: isDarkTheme,
                            onChanged: (value) {
                              // Value is true
                              // isDarkTheme = value;
                              // print(isDarkTheme);
                              // currentTheme.switchTheme(value);
                            },
                            trackColor: Colors.red,
                            activeColor: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Row 3
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 1.5,
                          blurRadius: 4,
                          color: Color.fromARGB(31, 211, 211, 211))
                    ],
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("Something else"),
                        ),
                        CupertinoSwitch(
                            value: isDarkTheme,
                            onChanged: (value) {
                              // Value is true
                              // isDarkTheme = value;
                              // print(isDarkTheme);
                              // currentTheme.switchTheme(value);
                            },
                            trackColor: Colors.red,
                            activeColor: Colors.green,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 1.5,
                            blurRadius: 4,
                            color: Color.fromARGB(31, 211, 211, 211))
                      ]),
                  child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary,
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("DONE"),
                        )),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}