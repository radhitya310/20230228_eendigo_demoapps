import 'package:eendigodemo/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
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

  final List<Widget> tabs = <Widget>[
    HomeScreen(),
    const Text("Apa"),
    const Text("mantap"),
    const Center(child: Text("Notifikasi halamannya standar"))
  ];

  final List<IconData> bottomNavbarIcons = const [
    CupertinoIcons.home,
    CupertinoIcons.chat_bubble,
    CupertinoIcons.bell,
    CupertinoIcons.person,
  ];

  @override
  Widget build(BuildContext context) {
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
  }
}
