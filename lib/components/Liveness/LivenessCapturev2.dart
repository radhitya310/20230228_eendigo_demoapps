import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:animations/animations.dart';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/components/Liveness/LivenessCatcher.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/pageBase.dart';
import 'package:eendigodemo/widget/EendigoPageMethod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../model/LivenessModel.dart';

class LivenessCaptureV2 extends StatefulWidget {
  const LivenessCaptureV2({Key? key}) : super(key: key);

  @override
  State<LivenessCaptureV2> createState() => _LivenessCaptureV2State();
}

class _LivenessCaptureV2State extends State<LivenessCaptureV2> {
  bool isLoading = false;
  Uint8List? webimage;
  CameraController? cameraController;
  File? _image;
  bool isCamera = false;
  bool isLive = false;
  bool isInit = false;
  bool isFailed = false;
  String liveScore = "0";
  int direction = 1;
  String errMsg = "";
  late Uint8List _imageBytes;
  String base64Image = "";
  late Timer _timer;
  int _start = 0;
  List<LivenessModel> dataLiveness = [];

  Future getImage() async {
    var image = await FilePicker.platform.pickFiles();
    if (image != null) {
      setState(() {
        webimage = image.files.first.bytes!;
      });
    }
  }

  Future getImagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() async {
        webimage = await image.readAsBytes();
      });
    }
  }

  Future<List<LivenessModel>> LivenessAPI(File _image) async {
    List<LivenessModel> data = [];
    final Url = UrlPath.liveness;
    final file = File(_image.path);

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    http.MultipartFile pic;
    try {
      if (defaultTargetPlatform != TargetPlatform.iOS ||
          defaultTargetPlatform != TargetPlatform.android) {
        pic = http.MultipartFile.fromBytes('img1', _imageBytes,
            filename: '_image.jpg');
      } else {
        pic = await http.MultipartFile.fromPath('img1', file.path);
      }
      request.files.add(pic);
    } catch (e) {
      setState(() {
        isLoading = false;
        errMsg = e.toString();
      });
    }

    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

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
        LivenessModel livenessDa = LivenessModel.fromJson(responses);
        var status = responses['status'];
        var error = responses['error'];

        if (status.toString().toLowerCase() == 'failed') {
          errMsg = error;
        }

        // setState(() {
        //   isLoading = false;
        //   isFailed = true;
        //   _start = 0;
        //   _timer.cancel();
        // });
        setState(() {
          data.add(livenessDa);
        dataLiveness.add(livenessDa);          
        });
        
        base64Image = base64Encode(_imageBytes);
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => LivenessResult(
        //           data: data,
        //           imgBase64: base64Image,
        //         )));
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
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Liveness Failed'),
              content: Text(ujson1.toString()),
              actions: <Widget>[
                TextButton(
                  child: Text('Try Again'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        // _start = 0;
        // _timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Failed : ' + ujson1.toString())),
        );
      }
    } catch (e) {
      setState(() {
        errMsg = e.toString();
        isLoading = false;
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
                                      child: GradientText('Liveness',
                                          style: (TextStyle(
                                              fontSize: 60,
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

  void imageChooser(BuildContext context) {
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
                          getImage();
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
                        onTap: () {
                          Navigator.pop(context);
                          getImagecamera();
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
                (base64Image == "")
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
                                  base64Decode(base64Image),
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
                                            base64Image = "";
                                            dataLiveness = [];
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
                        onPressed: () async {
                          final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LivenessCatcher("Liveness")));
                          _image = File(result.path);
                          _imageBytes = await result.readAsBytes();
                          setState(() {
                            base64Image = base64Encode(_imageBytes);
                          });
                        },
                        child: Text('Take Picture'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: base64Image == ""
                            ? null
                            : () {
                                LivenessAPI(_image!).then((value) {
                                  if (value.isNotEmpty) {}
                                });
                              },
                        child: Text('Submit'),
                      ),
                    ),                    
                  ],
                ),
                dataLiveness.isEmpty ? 
                    Container() : 
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: double.parse(dataLiveness[0]
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
                              toDoubleDigit(dataLiveness[0]
                                  .result[0]
                                  .faceLiveness
                                  .score
                                  .toString()),
                          style: TextStyle(
                            color: double.parse(dataLiveness[0]
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
            )));
  }
  String toDoubleDigit(String value) {
    double numericValue = double.parse(value);
    String formattedValue = numericValue.toStringAsFixed(2);
    return formattedValue;
  }
}
