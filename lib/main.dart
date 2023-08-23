import 'dart:io';

import 'package:eendigodemo/homeScreen.dart';
import 'package:eendigodemo/widget/CustomErrorWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

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
    if (Theme.of(context).platform == TargetPlatform.android ||
        Theme.of(context).platform == TargetPlatform.iOS) {
      return DefaultTabController(
        length: bottomNavbarIcons.length,
        child: Scaffold(
          bottomNavigationBar: Material(
            color: Colors.white38,
            child: TabBar(
              indicatorPadding: EdgeInsets.zero,
              indicator: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey),
                ),
              ),
              onTap: (index) {
                setState(() {
                  if (index != 2) {
                    currentIndex = index;
                  }
/*                else {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const NewPost(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(0.0, 1.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ));
                }*/
                });
              },
              tabs: bottomNavbarIcons
                  .asMap()
                  .map((i, e) => MapEntry(
                      i,
                      Tab(
                        icon: Icon(
                          e,
                          color: i == currentIndex ? Colors.grey : Colors.black,
                          size: 30.0,
                        ),
                      )))
                  .values
                  .toList(),
            ),
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabs,
          ),
        ),
      );
    } else {
      return HomeScreen();
    }
  }
}
