import 'dart:convert';
import 'dart:io';

import 'package:eendigodemo/components/Facecompare/faceCompare.dart';
import 'package:eendigodemo/model/LivenessCompareModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FaceCompareResult extends StatelessWidget {
  final List<LivenessCompareModel> data;
  final String img1Base64;
  final String img2Base64;
  FaceCompareResult(
      {required this.data, required this.img1Base64, required this.img2Base64})
      : super();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liveness & Face Compare'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("Assets/img/background-eendigo_(1).png"),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            Row(children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: ((defaultTargetPlatform == TargetPlatform.iOS ||
                        defaultTargetPlatform == TargetPlatform.android))
                    ? Image.file(
                        File(_image!.path),
                        fit: BoxFit.fill,
                      )
                    : Image.memory(base64Decode(img1Base64))),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: ((defaultTargetPlatform == TargetPlatform.iOS ||
                        defaultTargetPlatform == TargetPlatform.android))
                    ? Image.file(
                        File(_image!.path),
                        fit: BoxFit.fill,
                      )
                    : Image.memory(base64Decode(img2Base64))),
            ],),    
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 2,
                child: ResultWidget(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ResultWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width - 50,
        child: Column(
          children: [        
            const SizedBox(height: 20),
            (data[0].result[0].faceLiveness.live == "True")
                ? const Text("You are Live,")
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
                  'Live Score: ' + double.parse(data[0].result[0].faceLiveness.score.toString()).toStringAsFixed(2),
                  style: TextStyle(
                    color: double.parse(data[0]
                                    .result[0]
                                    .faceLiveness
                                    .score
                                    .toString()) >
                                80
                            ? Colors.blue
                            : Colors.red,
                    fontSize: 30.0,
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
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: double.parse(data[0]
                                    .result[0]
                                    .faceCompare
                                    .similarity
                                    .toString()) >
                                80
                            ? Colors.blue
                            : Colors.red,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Similarity Score: ' +
                      double.parse(data[0].result[0].faceCompare.similarity.toString().isEmpty ? "0" :
                      data[0].result[0].faceCompare.similarity.toString()).toStringAsFixed(2),
                  style: TextStyle(
                    color: double.parse(data[0].result[0].faceCompare.similarity.toString().isEmpty ? "0" :
                      data[0].result[0].faceCompare.similarity.toString()) >
                                80
                            ? Colors.blue
                            : Colors.red,
                    fontSize: 30.0,
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
        ));
  }
}
