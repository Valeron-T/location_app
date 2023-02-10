// Login page
// ignore_for_file: prefer_const_constructors

import 'package:drone_app/main.dart';
import 'package:drone_app/settings.dart';
import 'package:drone_app/theme.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  LogInPage({Key? key, required this.title}) : super(key: key);
  final String title;

  static const p = 'user';
  final pc = TextEditingController();
  final uname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/blur-bg.jpg"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Drone',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: white),
                  ),
                  Text(
                    'Tracking',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 40,
                        color: white),
                  ),
                  Text(
                    'Made Easy',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: white),
                  ),
                  SizedBox(height: 40),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: SizedBox(
                      child: TextField(
                        controller: uname,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          fillColor: white,
                          labelStyle:
                              TextStyle(color: white, letterSpacing: 1.5),
                          hintStyle: TextStyle(color: white),
                          hoverColor: white,
                          focusColor: Colors.amber[300],
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: white,
                          ),
                          labelText: 'Username',
                          hintText: 'Enter Username',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: SizedBox(
                      child: TextField(
                        controller: pc,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          fillColor: white,
                          labelStyle:
                              TextStyle(color: white, letterSpacing: 1.5),
                          hintStyle: TextStyle(color: white),
                          hoverColor: white,
                          focusColor: Colors.amber[300],
                          prefixIcon: Icon(
                            Icons.lock,
                            color: white,
                          ),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 52),

                  // SizedBox(
                  //   height: height * 0.2,
                  // ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                          heroTag: "info",
                          onPressed: () {
                            if (pc.text == p) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return InfoPage(title: 'InfoPage');
                              }));
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(32.0))),
                                          title: const Text("Alert"),
                                          content: const Text("Wrong Password"),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(ctx).pop();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer),
                                                padding:
                                                    const EdgeInsets.all(14),
                                                child: const Text("OK",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            240,
                                                            240,
                                                            240))),
                                              ),
                                            )
                                          ]));
                            }
                          },
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          shape:
                              Theme.of(context).floatingActionButtonTheme.shape,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.arrow_forward_ios_rounded),
                        ),
                        FloatingActionButton(
                          heroTag: "settings",
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SettingPage(title: 'SettingPage');
                            }));
                          },
                          shape:
                              Theme.of(context).floatingActionButtonTheme.shape,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: white,
                          child: Icon(Icons.settings_rounded),
                        ),
                      ],
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top:48.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "First Time ?",
                                style: TextStyle(color: white),
                                textAlign: TextAlign.start,
                              ),
                              Text(
                                "Sign Up Now !",
                                style: TextStyle(color: white),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
