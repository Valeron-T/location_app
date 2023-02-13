// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:drone_app/config.dart';
import 'package:drone_app/login.dart';
// import 'package:drone_app/settings.dart';
import 'package:drone_app/theme.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:js';
import 'dart:math';
// import 'dart:ui';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('easyTheme');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Adds a listener which updates everytime source was updated
    currentTheme.addListener(() {
      print("State Changed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Drone Information",
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.currentTheme(),
      home: LogInPage(title: "Login"),
      // home: SettingPage(title: 'settings'),
    );
  }
}

var w = Colors.grey[300];
var b = Colors.black;
var h = 'METERS';

class MyTheme with ChangeNotifier {
  static bool _isDark = false;
  final myBox = Hive.box('easyTheme');

  MyTheme() {
    if (myBox.containsKey('CurrentTheme')) {
      _isDark = myBox.get('CurrentTheme');
    } else {
      myBox.put('CurrentTheme', _isDark);
    }
  }

  switchTheme(bool curValue) {
    notifyListeners();
    _isDark = curValue;
    print(_isDark);
    myBox.put('CurrentTheme', _isDark);
    if (_isDark == true) {
      myBox.put('MapTheme', 'dark');
    } else {
      myBox.put('MapTheme', 'light');
    }
    print(myBox.get('MapTheme'));
    print(myBox.get('CurrentTheme'));
  }

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> with WidgetsBindingObserver {
  String? _darkMapStyle;
  String? _lightMapStyle;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/light.json');
  }

  Future _setMapStyle() async {
    final controller = await _controller.future;
    final myBox = Hive.box('easyTheme');
    print(myBox.get('MapTheme'));
    if (myBox.get('MapTheme') == 'dark') {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle(_lightMapStyle);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.076090, 72.877426),
    zoom: 14.4746,
    tilt: 90,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(19.076090, 72.877426),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  static double sourceLat = 19.076090;
  static double sourceLong = 72.877426;
  static double destnLat = 19.076090 + 0.01;
  static double destnLong = 72.877426 + 0.01;

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((value) {
      currentLocation = value;
    });

    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCy1mIpoAJ42vr-nRAcBukxBUZNZqgR9J4",
      PointLatLng(sourceLat, sourceLong),
      PointLatLng(destnLat, destnLong),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        print(point.latitude);
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return currentLocation == null
        ? Center(
            child: Container(
                child: Text(
            "Loading",
            style: Theme.of(context).textTheme.displayMedium,
          )))
        : GoogleMap(
            compassEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _setMapStyle();
            },
            markers: {
              Marker(
                  markerId: MarkerId("current"),
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!)),
              Marker(
                  markerId: MarkerId("source"),
                  position: LatLng(sourceLat, sourceLong)),
              Marker(
                  markerId: MarkerId("desn"),
                  position: LatLng(destnLat, destnLong)),
            },
            polylines: {
              Polyline(
                polylineId: PolylineId("route"),
                points: polylineCoordinates,
                color: Colors.white,
              )
            },
          );
  }

}

Color bc(int b) {
  if (b >= 75) {
    return (Colors.greenAccent);
  } else if (b >= 50) {
    return (Colors.yellowAccent);
  } else if (b >= 25) {
    return (Colors.orangeAccent);
  } else {
    return (Colors.redAccent);
  }
}

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  String displayTemp(int temp) {
    final myBox = Hive.box('easyTheme');
    bool unit = true;
    String result = "";

    if (myBox.containsKey('isCelsius')) {
      unit = myBox.get('isCelsius');
    } else {
      myBox.put('isCelsius', true);
    }

    if (unit) {
      result = "${temp + 32} F";
    } else {
      result = "$temp C";
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Text(displayTemp(25));
  }
}

class InfoPage extends StatelessWidget {
  InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  static final al = Random().nextInt(100);
  static const l = [
    'NORTH',
    'EAST',
    'WEST',
    'SOUTH',
    'NORTH-EAST',
    'NORTH-WEST',
    'SOUTH-EAST',
    'SOUTH-WEST'
  ];
  static final i = Random().nextInt(l.length);
  static final face = l[i];
  static final bat = Random().nextInt(100);
  static int temperature = 36;
  static var tempUnit = "C";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: MapSample(),
        ),
        // Scaffold(
        //   backgroundColor: w,
        //   appBar: AppBar(
        //     titleTextStyle: TextStyle(color: w),
        //     title: Text("DRONE INFORMATION"),
        //     centerTitle: true,
        //     backgroundColor: b,
        //   ),
        //   body: Center(
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: <Widget>[
        //         Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: <Widget>[
        //             Container(
        //                 width: MediaQuery.of(context).size.width - 4,
        //                 height: MediaQuery.of(context).size.height - 56 - 60,
        //                 alignment: Alignment.center,
        //                 child: OpenStreetMapSearchAndPick(
        //                     center: LatLong(18.9426, 72.8311),
        //                     buttonColor: Colors.blueAccent,
        //                     buttonText: 'Drone Location',
        //                     onPicked: (pickedData) {
        //                       showDialog(
        //                           context: context,
        //                           builder: (ctx) => AlertDialog(
        //                                   title: const Text("Drone Location:"),
        //                                   content: Text(pickedData.address),
        //                                   actions: <Widget>[
        //                                     TextButton(
        //                                       onPressed: () {
        //                                         Navigator.of(ctx).pop();
        //                                       },
        //                                       child: Container(
        //                                         color: Colors.black,
        //                                         padding:
        //                                             const EdgeInsets.all(14),
        //                                         child: const Text("okay",
        //                                             style: TextStyle(
        //                                                 color: Color.fromARGB(
        //                                                     255,
        //                                                     240,
        //                                                     240,
        //                                                     240))),
        //                                       ),
        //                                     )
        //                                   ]));
        //                     })),
        //           ],
        //         ),
        //         // Column(
        //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         //   children: <Widget>[
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       color: bc(bat),
        //         //       alignment: Alignment.center,
        //         //       child: Text(
        //         //         "BATTERY: $bat %",
        //         //         style: TextStyle(fontSize: 20, color: Colors.black),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       alignment: Alignment.center,
        //         //       color: Colors.cyanAccent,
        //         //       child: Text(
        //         //         "ALTITUDE: $al $h",
        //         //         style: TextStyle(fontSize: 20, color: Colors.black),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       alignment: Alignment.center,
        //         //       color: Colors.brown,
        //         //       child: Text(
        //         //         "FACING: $face",
        //         //         style: TextStyle(fontSize: 20, color: Colors.white),
        //         //       ),
        //         //     ),
        //         //     Container(
        //         //       width: MediaQuery.of(context).size.width / 2 - 4,
        //         //       height: MediaQuery.of(context).size.height / 4 - 14 - 4,
        //         //       color: Colors.redAccent,
        //         //       alignment: Alignment.center,
        //         //       child: FloatingActionButton.extended(
        //         //         onPressed: () {
        //         //           Navigator.pushReplacement(context,
        //         //               MaterialPageRoute(builder: (context) {
        //         //             return LogInPage(title: 'LogInPage');
        //         //           }));
        //         //         },
        //         //         label: Text('Disconnect'),
        //         //         icon: Icon(Icons.cloud_off),
        //         //         backgroundColor: Colors.white,
        //         //         foregroundColor: Colors.redAccent,
        //         //       ),
        //         //     ),
        //         //   ],
        //         // ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(0, MediaQuery.of(context).viewPadding.top + 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 5.5,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 3,
                                blurRadius: 15)
                          ],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: FloatingActionButton(
                              onPressed: () => Navigator.of(context).pop(),
                              shape: Theme.of(context)
                                  .floatingActionButtonTheme
                                  .shape,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              foregroundColor: white,
                              child: Icon(Icons.arrow_back_ios_new_rounded),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Sensor Stats",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    shadowColor: Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Chip(
                                      label: Temperature(),
                                      avatar: Icon(Icons.thermostat_rounded),
                                    ),
                                  ),
                                  Card(
                                    shadowColor: Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Chip(
                                      label: Text("Strong"),
                                      avatar: Icon(Icons.wifi),
                                    ),
                                  ),
                                  Card(
                                    shadowColor: Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Chip(
                                      label: Text("20 mph"),
                                      avatar: Icon(Icons.air_rounded),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    shadowColor: Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Chip(
                                      label: Text("2 / 5"),
                                      avatar: Icon(Icons.satellite_alt_rounded),
                                    ),
                                  ),
                                  Card(
                                    shadowColor: Colors.transparent,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    child: Chip(
                                      label: Text("On"),
                                      avatar: Icon(Icons.hdr_auto_rounded),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Stack(children: [
                    Container(
                      transform: Matrix4.translationValues(0, 18.0, 0.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black54,
                                spreadRadius: 5,
                                blurRadius: 20)
                          ],
                          color: Theme.of(context).colorScheme.primaryContainer,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(69, 30),
                          )),
                      child: Stack(
                        children: [
                          Container(
                            transform: Matrix4.translationValues(0, -5.0, 0.0),
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.red,
                                  Colors.yellow,
                                  Colors.green
                                ],
                                stops: [0.1, 0.3, 0.5],
                                tileMode: TileMode.mirror,
                                transform: GradientRotation(-3.1412 / 2),
                              ).createShader(bounds),
                              child: Icon(
                                Icons.battery_4_bar_rounded,
                                size: 100,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      spreadRadius: 2,
                                      blurRadius: 10)
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                transform:
                                    Matrix4.translationValues(-25, 5.0, 0.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 3,
                                        blurRadius: 15)
                                  ],
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: SfRadialGauge(
                                  backgroundColor: Colors.transparent,
                                  // backgroundColor: Theme.of(context).colorScheme.background,
                                  enableLoadingAnimation: true,
                                  animationDuration: 3000,
                                  axes: [
                                    RadialAxis(
                                      isInversed: true,
                                      startAngle: 225,
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                          angle: 120,
                                          positionFactor: 0.5,
                                          widget: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '69',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'DIGI',
                                                  fontSize: 25,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                              Text(
                                                'mph',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'DIGI',
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            value: 69,
                                            needleStartWidth: 0.5,
                                            needleEndWidth: 3,
                                            knobStyle: KnobStyle(
                                                knobRadius: 6,
                                                sizeUnit:
                                                    GaugeSizeUnit.logicalPixel,
                                                color: Colors.red))
                                      ],
                                      majorTickStyle: MajorTickStyle(
                                        length: 0.1,
                                        lengthUnit: GaugeSizeUnit.factor,
                                        thickness: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      axisLineStyle: AxisLineStyle(
                                        color: Colors.white,
                                        cornerStyle: CornerStyle.bothCurve,
                                        gradient: SweepGradient(
                                            colors: <Color>[yellow, green, red],
                                            stops: <double>[0.0, 0.5, 0.90]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                transform: Matrix4.translationValues(
                                    MediaQuery.of(context).size.width * 0.07,
                                    5.0,
                                    0.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black54,
                                        spreadRadius: 3,
                                        blurRadius: 15)
                                  ],
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: SfRadialGauge(
                                  backgroundColor: Colors.transparent,
                                  // backgroundColor: Theme.of(context).colorScheme.background,
                                  enableLoadingAnimation: true,
                                  animationDuration: 3000,
                                  axes: [
                                    RadialAxis(
                                      maximum: 1000,
                                      startAngle: 130,
                                      endAngle: 300,
                                      annotations: <GaugeAnnotation>[
                                        GaugeAnnotation(
                                          angle: 60,
                                          positionFactor: 0.5,
                                          widget: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '150',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'DIGI',
                                                  fontSize: 25,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                              Text(
                                                'ft',
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  fontFamily: 'DIGI',
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                            value: 150,
                                            needleStartWidth: 0.5,
                                            needleEndWidth: 3,
                                            knobStyle: KnobStyle(
                                                knobRadius: 6,
                                                sizeUnit:
                                                    GaugeSizeUnit.logicalPixel,
                                                color: Colors.red))
                                      ],
                                      majorTickStyle: MajorTickStyle(
                                        length: 0.1,
                                        lengthUnit: GaugeSizeUnit.factor,
                                        thickness: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      axisLineStyle: AxisLineStyle(
                                        color: Colors.white,
                                        cornerStyle: CornerStyle.bothCurve,
                                        gradient: SweepGradient(
                                            colors: <Color>[yellow, green, red],
                                            stops: <double>[0.0, 0.5, 0.90]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
