import 'package:eendigodemo/components/ocrChoice.dart';
import 'package:eendigodemo/components/OCR/KPTOCR.dart';
import 'package:eendigodemo/liveness.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final List<Map> OCRs = [
    {
      'label': 'Liveness',
      'icon': CupertinoIcons.person,
      'screen': const Liveness(),
      'color': Color.fromARGB(255, 176, 162, 191),
    },
    {
      'label': 'FaceCompare',
      'icon': CupertinoIcons.person_2,
      'screen': const Liveness(),
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

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Material(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      borderRadius: BorderRadius.circular(32),
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: const [
                              Icon(Icons.search),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                'Find services, food, or place',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
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
                Wrap(
                    runSpacing: 8,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      for (final OCR in OCRs)
                        Material(
                            color: Color.fromARGB(113, 255, 255, 255),
                            borderRadius: BorderRadius.circular(16),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              width: 105,
                              height: 110,
                              child: InkWell(
                                splashColor: OCR['color'].withOpacity(0.5),
                                highlightColor: OCR['color'].withOpacity(0.2),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => OCR['screen']));
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
                                                  color: OCR['color']
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              child:
                                                  Icon(OCR['icon'], size: 50),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        OCR['label'],
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
