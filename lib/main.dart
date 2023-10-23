

import 'package:eendigodemo/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/Settings/settingScreen.dart';

void main() {
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   FlutterError.dumpErrorToConsole(details);
  //   runApp(ErrorWidgetClass(details));
  // };
  runApp(const MyApp());
}

// class ErrorWidgetClass extends StatelessWidget {
//   final FlutterErrorDetails errorDetails;
//   ErrorWidgetClass(this.errorDetails);
//   @override
//   Widget build(BuildContext context) {
//     return CustomErrorWidget(
//       errorMessage: errorDetails.exceptionAsString(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eendigo Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 24), // Apply to body text
          // Add more text styles as needed
        ), // Apply to body text
      ),
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int currentIndex = 0;

  final List<Widget> tabs = <Widget>[HomeScreen(), SettingScreen()];

  final List<IconData> bottomNavbarIcons = const [
    CupertinoIcons.home,
    CupertinoIcons.settings
  ];

  @override
  Widget build(BuildContext context) {
   return HomeScreen();
  }
}
