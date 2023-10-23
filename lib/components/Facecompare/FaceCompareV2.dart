import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:eendigodemo/components/Liveness/LivenessCatcher.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/model/LivenessCompareModel.dart';
import 'package:eendigodemo/pageBase.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class FaceCompareV2 extends StatefulWidget {
  const FaceCompareV2({Key? key}) : super(key: key);

  @override
  State<FaceCompareV2> createState() => _FaceCompareV2State();
}

class _FaceCompareV2State extends State<FaceCompareV2> {
  String img1Base64 = "";
  File? image1;
  File? image2;
  CameraController? cameraController;
  bool isLoading = false;
  bool isCamera = false;
  bool isLive = false;
  bool isInit = false;
  bool isFailed = false;
  String liveScore = "0";
  int direction = 0;
  String errMsg = "";
  late Uint8List _image1Bytes;
  late Uint8List _image2Bytes;
  String img2Base64 = "";
  List<LivenessCompareModel> dataLivnessFaceCompare = [];


  Future<List<LivenessCompareModel>> FaceCompareAPI() async {
    List<LivenessCompareModel> data = [];
    final Url = UrlPath.faceCompare;
    final file1 = File(image1!.path);
    final file2 = File(image2!.path);

    var request = http.MultipartRequest('POST', Uri.parse(Url));

    // List<int> imageBytes1 = base64.decode(img1Base64);
    
    // final pic = await http.MultipartFile.fromBytes('img1', imageBytes1,
    //     filename: 'image.jpeg', contentType: MediaType('image', 'jpeg'));

    http.MultipartFile pic;

    if (defaultTargetPlatform != TargetPlatform.iOS ||
          defaultTargetPlatform != TargetPlatform.android) {
        pic = http.MultipartFile.fromBytes('img1', _image1Bytes,
            filename: '_image.jpg');
      } else {
        pic = await http.MultipartFile.fromPath('img1', file1.path);
      }
    request.files.add(pic);

    

    List<int> imageBytes2 = base64.decode(img2Base64);

    // final pic2 = await http.MultipartFile.fromBytes('img2', imageBytes2,
    //     filename: 'image2.jpeg', contentType: MediaType('image2', 'jpeg'));

    http.MultipartFile pic2;

    if (defaultTargetPlatform != TargetPlatform.iOS ||
          defaultTargetPlatform != TargetPlatform.android) {
        pic2 = http.MultipartFile.fromBytes('img2', _image2Bytes,
            filename: 'image2.jpg');
      } else {
        pic2 = await http.MultipartFile.fromPath('img2', file2.path);
      }

    request.files.add(pic2);

    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';
    String random16Digit = generateRandom16DigitNumber();
    request.fields['nik'] = random16Digit;
    final timeout = Duration(seconds: 30);
    final client = http.Client();
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });
      final response =
          await client.send(request).timeout(timeout, onTimeout: () async {
        setState(() {
          isLoading = false;
          isFailed = true;
        });
        throw Exception('request timeout');
      });

      Navigator.pop(context);

      if (response.statusCode == 200) {
        var ujson1 = await utf8.decodeStream(response.stream);
        Map<String, dynamic> responses = json.decode(ujson1);
        LivenessCompareModel livenessDa =
            LivenessCompareModel.fromJson(responses);

        var status = responses['status'];
        var error = responses['error'];
        setState(() {
          data.add(livenessDa);
          dataLivnessFaceCompare.add(livenessDa);
        });
      } else {
        var ujson1 = await utf8.decodeStream(response.stream);
        Map<String, dynamic> responses = json.decode(ujson1);
        try {
          var error = responses['error'];
          errMsg = error;
        } catch (e) {
          errMsg = ujson1.toString();
        }
        
        setState(() {
          isLoading = false;
          isFailed = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Failed : ' + ujson1.toString())),
        );
      }
    } catch (e) {
      setState(() {
        errMsg = e.toString();
        isLoading = false;
        isFailed = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return PageBase(
        body: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: EendigoLogo(context),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                        child: (isLoading == false)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GradientText('Liveness Face Compare',
                                          style: (TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold)),
                                          colors: [
                                            Color.fromARGB(255, 37, 162, 220),
                                            Color.fromARGB(255, 28, 115, 185),
                                            Color.fromARGB(255, 59, 67, 127),
                                          ])),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Center(child: ImageCatcher(context)),
                                  ),
                                ],
                              )
                            : Center(
                                child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  void imageChooser(BuildContext context,String image) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Select image from",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                // flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 150,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getImage(image);
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CupertinoIcons.archivebox,
                                size: 50,
                              ),
                              Text("From gallery")
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: InkWell(
                        onTap: () async {
                          Navigator.pop(context);
                          if(image == 'image1'){                            
                            final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LivenessCatcher("Liveness")));
                            image1 = File(result.path);
                            _image1Bytes = await result.readAsBytes();
                            setState(() {
                              img1Base64 = base64Encode(_image1Bytes);
                            });
                          }else{                            
                            final result = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => LivenessCatcher("KTP")));
                            image2 = File(result.path);
                            _image2Bytes = await result.readAsBytes();
                            setState(() {
                              img2Base64 = base64Encode(_image2Bytes);
                            });
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.camera,
                              size: 50,
                            ),
                            Text("From camera")
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            //height: MediaQuery.of(context).size.height / 2.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientText('Selfie',
                      style: (TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                      colors: [
                        Color.fromARGB(255, 37, 162, 220),
                        Color.fromARGB(255, 28, 115, 185),
                        Color.fromARGB(255, 59, 67, 127),
                ])),
                (img1Base64 == "")
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DottedBorder(
                          color: const Color.fromARGB(255, 78, 199, 30),
                          strokeWidth: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person,
                                  size: 100,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                )
                              ],
                            ),
                          ),
                        ))
                    : Padding(
                        padding: const EdgeInsets.all(0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width - 50,
                                child: Image.memory(
                                  base64Decode(img1Base64),
                                  width: 100,
                                  height: 100,
                                )),
                            Positioned(
                              right: 16,
                              top: 0,
                              child: Container(
                                color: Color.fromARGB(255, 219, 218, 218),
                                width: 40,
                                height: 40,
                                child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            img1Base64 = "";
                                            dataLivnessFaceCompare = [];
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          imageChooser(context, 'image1');
                        },
                        child: Text('Take Picture'),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GradientText('KTP',
                      style: (TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                      colors: [
                        Color.fromARGB(255, 37, 162, 220),
                        Color.fromARGB(255, 28, 115, 185),
                        Color.fromARGB(255, 59, 67, 127),
                ])),
                (img2Base64 == "")
                    ? Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DottedBorder(
                          color: const Color.fromARGB(255, 78, 199, 30),
                          strokeWidth: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.person,
                                  size: 100,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                )
                              ],
                            ),
                          ),
                        ))
                    : Padding(
                        padding: const EdgeInsets.all(0),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.5,
                                width: MediaQuery.of(context).size.width - 50,
                                child: Image.memory(
                                  base64Decode(img2Base64),
                                  width: 100,
                                  height: 100,
                                )),
                            Positioned(
                              right: 16,
                              top: 0,
                              child: Container(
                                color: Color.fromARGB(255, 219, 218, 218),
                                width: 40,
                                height: 40,
                                child: Center(
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            img2Base64 = "";
                                            dataLivnessFaceCompare = [];
                                          });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          imageChooser(context, 'image2');
                        },
                        child: Text('Take Picture'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: (img1Base64 == "" || img2Base64 == "")
                            ? null
                            : () {
                                FaceCompareAPI().then((value) {
                                  if (value.isNotEmpty) {}
                                });
                              },
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
                dataLivnessFaceCompare.isEmpty
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text('Status : ' + dataLivnessFaceCompare[0].status),
                            Text('Live : ' + dataLivnessFaceCompare[0].result[0].faceLiveness.live),
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: double.parse(dataLivnessFaceCompare[0]
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
                                  'Live Score: ' +
                                      double.parse(dataLivnessFaceCompare[0]
                                              .result[0]
                                              .faceLiveness
                                              .score
                                              .toString())
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: double.parse(dataLivnessFaceCompare[0]
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
                                    color: double.parse(dataLivnessFaceCompare[0]
                                                .result[0]
                                                .faceCompare
                                                .similarity
                                                .toString()) >
                                            0.8
                                        ? Colors.blue
                                        : Colors.red,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Similarity Score: ' +
                                      double.parse(dataLivnessFaceCompare[0]
                                                  .result[0]
                                                  .faceCompare
                                                  .similarity
                                                  .toString()
                                                  .isEmpty
                                              ? "0"
                                              : dataLivnessFaceCompare[0]
                                                  .result[0]
                                                  .faceCompare
                                                  .similarity
                                                  .toString())
                                          .toStringAsFixed(2),
                                  style: TextStyle(
                                    color: double.parse(dataLivnessFaceCompare[0]
                                                    .result[0]
                                                    .faceCompare
                                                    .similarity
                                                    .toString()
                                                    .isEmpty
                                                ? "0"
                                                : dataLivnessFaceCompare[0]
                                                    .result[0]
                                                    .faceCompare
                                                    .similarity
                                                    .toString()) >
                                            0.8
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
                        )),
              ],
            )));
  }

  String toDoubleDigit(String value) {
    double numericValue = double.parse(value);
    String formattedValue = numericValue.toStringAsFixed(2);
    return formattedValue;
  }

  String generateRandom16DigitNumber() {
    Random random = Random();
    String number = '';

    for (int i = 0; i < 16; i++) {
      number += random.nextInt(10).toString();
    }

    return number;
  }

  Future getImage(String imageString) async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final pickedImageFile = File(image.path);
      if(imageString == 'image1'){
          image1 = pickedImageFile;         
          _image1Bytes = await image.readAsBytes();
        }else{
          image2 = pickedImageFile;         
          _image2Bytes = await image.readAsBytes();
        }
      setState(() {
        if(imageString == 'image1'){
          img1Base64 = base64Encode(_image1Bytes);
        }else{
          img2Base64 = base64Encode(_image2Bytes); 
        }
      });
    }
  }

}
