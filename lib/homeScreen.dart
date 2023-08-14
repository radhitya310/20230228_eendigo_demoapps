import 'package:eendigodemo/components/Facecompare/faceCompare.dart';
import 'package:eendigodemo/components/ocrChoice.dart';
import 'package:eendigodemo/components/OCR/KPTOCR.dart';
import 'package:eendigodemo/liveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/Settings/APIKey.dart/apiKeyScreen.dart';
import 'model/APIKeyModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedProduct = '';
  APIKeyModel apiKey = APIKeyModel(tenantCode: '', key: '');
  late SharedPreferences prefs;
  bool isLoading = false;
  String? tenantCode = '';
  String? key = '';

  final List<Map> Products = [
    {
      'label': 'Liveness',
      'icon': CupertinoIcons.person,
      'screen': const Liveness(),
      'color': Color.fromARGB(255, 176, 162, 191),
    },
    {
      'label': 'FaceCompare',
      'icon': CupertinoIcons.person_2,
      'screen': const FaceCompare(),
      'color': Color.fromARGB(255, 176, 162, 191),
    },
    {
      'label': 'OCR',
      'icon': CupertinoIcons.camera_viewfinder,
      'screen': const OCRchoice(),
      'color': Color.fromARGB(255, 176, 162, 191),
    },
    {
      'label': 'More To Come',
      'icon': Icons.more_horiz,
      'screen': const OCRchoice(),
      'color': Color.fromARGB(255, 176, 162, 191),
    }
  ];

  void initState() {
    isLoading = true;
    initializeSetting();
    super.initState();
  }

  void initializeSetting() async {
    prefs = await SharedPreferences.getInstance();
    tenantCode = prefs.getString('tenantCode') ?? '';
    key = prefs.getString('key') ?? '';
    apiKey.tenantCode = tenantCode!;
    apiKey.key = key!;
    isLoading = false;
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return Column(
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
          Center(
            child: Text('This may take a while'),
          ),
        ],
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/img/background-eendigo_(1).png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Container(
              padding: const EdgeInsets.all(12),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('Assets/icons/logo-eendigo-trial.png',
                        fit: BoxFit.contain),
                  ],
                ),
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Welcome, Tenant", style: TextStyle(fontSize: 30)),
                  Text("v.1.1.13", style: TextStyle(fontSize: 15)),
                  const SizedBox(height: 20),
                  Wrap(
                      runSpacing: 8,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (final Product in Products)
                          Material(
                              color: Color.fromARGB(113, 255, 255, 255),
                              borderRadius: BorderRadius.circular(16),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                width: 105,
                                height: 110,
                                child: InkWell(
                                  splashColor:
                                      Product['color'].withOpacity(0.5),
                                  highlightColor:
                                      Product['color'].withOpacity(0.2),
                                  onTap: () async {                
                                      // initializeSetting();                                     
                                      // if (apiKey.key == '' &&
                                      //     apiKey.tenantCode == '') {
                                      //   showDialog(
                                      //     context: context,
                                      //     builder: (BuildContext context) {
                                      //       return AlertDialog(
                                      //         title: Text('Incomplete Setting'),
                                      //         content: Text(
                                      //             'Please Input API Key and Tenant Code before continuing.'),
                                      //         actions: <Widget>[
                                      //           TextButton(
                                      //             child: Text('Show Me'),
                                      //             onPressed: () {
                                      //               Navigator.of(context).pop();
                                      //               Navigator.push(
                                      //                 context,
                                      //                 MaterialPageRoute(
                                      //                     builder: (context) =>
                                      //                         ApiKeyScreen()),
                                      //               );
                                      //             },
                                      //           ),
                                      //         ],
                                      //       );
                                      //     },
                                      //   );
                                      // } else {
                                      //   Navigator.of(context).push(
                                      //       MaterialPageRoute(
                                      //           builder: (context) =>
                                      //               Product['screen']));
                                      // }
                                      Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Product['screen']));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Product['color']
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                child: Icon(Product['icon'],
                                                    size: 50),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          Product['label'],
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                      ]),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

// class HomeScreen extends StatelessWidget {
//   HomeScreen({Key? key}) : super(key: key);
//   String _selectedProduct = '';
//   APIKeyModel apiKey = APIKeyModel(tenantCode: '', key: '');
//   late SharedPreferences prefs;
//   bool isLoading = false;

//   final List<Map> Products = [
//     {
//       'label': 'Liveness',
//       'icon': CupertinoIcons.person,
//       'screen': const Liveness(),
//       'color': Color.fromARGB(255, 176, 162, 191),
//     },
//     {
//       'label': 'FaceCompare',
//       'icon': CupertinoIcons.person_2,
//       'screen': const FaceCompare(),
//       'color': Color.fromARGB(255, 176, 162, 191),
//     },
//     {
//       'label': 'OCR',
//       'icon': CupertinoIcons.camera_viewfinder,
//       'screen': const OCRchoice(),
//       'color': Color.fromARGB(255, 176, 162, 191),
//     },
//     {
//       'label': 'More To Come',
//       'icon': Icons.more_horiz,
//       'screen': const OCRchoice(),
//       'color': Color.fromARGB(255, 176, 162, 191),
//     }
//   ];

//   void initState() {
//     isLoading = true;
//     initializeSetting();
//   }

//   void initializeSetting() async {
//     prefs = await SharedPreferences.getInstance();
//     String? tenantCode = prefs.getString('tenantCode') ?? '';
//     String? key = prefs.getString('key') ?? '';
//     setState(() {
//       apiKey.tenantCode = tenantCode;
//       apiKey.key = key;
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("Assets/img/background-eendigo_(1).png"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(100),
//           child: Container(
//             padding: const EdgeInsets.all(12),
//             child: SafeArea(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Image.asset('Assets/icons/logo-eendigo-trial.png',
//                       fit: BoxFit.contain),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(color: Colors.transparent),
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text("Welcome, Tenant", style: TextStyle(fontSize: 30)),
//                 const SizedBox(height: 20),
//                 Wrap(
//                     runSpacing: 8,
//                     alignment: WrapAlignment.spaceBetween,
//                     children: [
//                       for (final Product in Products)
//                         Material(
//                             color: Color.fromARGB(113, 255, 255, 255),
//                             borderRadius: BorderRadius.circular(16),
//                             clipBehavior: Clip.antiAliasWithSaveLayer,
//                             child: Container(
//                               width: 105,
//                               height: 110,
//                               child: InkWell(
//                                 splashColor: Product['color'].withOpacity(0.5),
//                                 highlightColor:
//                                     Product['color'].withOpacity(0.2),
//                                 onTap: () {
//                                   if (true) {
//                                     showDialog(
//                                       context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text('Incomplete Setting'),
//                                           content: Text(
//                                               'Please Input API Key and Tenant Code before continuing.'),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               child: Text('Show Me'),
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           ApiKeyScreen()),
//                                                 );
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   } else {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 Product['screen']));
//                                   }
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 60,
//                                         width: 60,
//                                         child: Stack(
//                                           children: [
//                                             Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Container(
//                                                 height: 50,
//                                                 width: 50,
//                                                 decoration: BoxDecoration(
//                                                   color: Product['color']
//                                                       .withOpacity(0.5),
//                                                   borderRadius:
//                                                       BorderRadius.circular(16),
//                                                 ),
//                                               ),
//                                             ),
//                                             Align(
//                                               child: Icon(Product['icon'],
//                                                   size: 50),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Text(
//                                         Product['label'],
//                                         textAlign: TextAlign.center,
//                                         softWrap: true,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             )),
//                     ]),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
