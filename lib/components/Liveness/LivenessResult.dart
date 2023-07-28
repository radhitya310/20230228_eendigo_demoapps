import 'dart:convert';
import 'dart:io';

import 'package:eendigodemo/model/LivenessModel.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LivenessResult extends StatelessWidget {
  final List<LivenessModel> data;
  final String imgBase64;
  LivenessResult({required this.data, required this.imgBase64}) : super();
  String liveScore = "0";
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liveness'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("Assets/img/background-eendigo_(1).png"),
          fit: BoxFit.fill,
        )),
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: ResultWidget(context),
          ),
        ),
      ),
    );
  }

  Widget ResultWidget(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Column(
              children: [
                Padding(padding: EdgeInsets.all(16)),
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ((defaultTargetPlatform == TargetPlatform.iOS ||
                            defaultTargetPlatform == TargetPlatform.android))
                        ? Image.file(
                            File(_image!.path),
                            fit: BoxFit.fill,
                          )
                        : Image.memory(base64Decode(imgBase64))),
                const SizedBox(height: 20),
                (data[0].result[0].faceLiveness.live == "True")
                    ? const Text("You are Live!")
                    : const Text("Sorry, you are spoofing."),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: double.parse(data[0]
                                    .result[0]
                                    .faceLiveness
                                    .score
                                    .toString()) >
                                80
                            ? Colors.blue
                            : Colors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Score: ' +
                          toDoubleDigit(
                              data[0].result[0].faceLiveness.score.toString()),
                      style: TextStyle(
                        color: double.parse(data[0]
                                    .result[0]
                                    .faceLiveness
                                    .score
                                    .toString()) >
                                80
                            ? Colors.blue
                            : Colors.red,
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if(data[0].error.isNotEmpty)
            Center(
              child: Text('Message : ' + data[0].error),
            ),
            // Positioned(
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: FancyButton(
            //       buttonText: 'Back To Home',
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //         Navigator.of(context).pop();
            //         Navigator.of(context).pop();
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      );
  }

  String toDoubleDigit(String value) {
    double numericValue = double.parse(value);
    String formattedValue = numericValue.toStringAsFixed(2);
    return formattedValue;
  }
}
