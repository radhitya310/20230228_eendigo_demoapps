import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http_parser/http_parser.dart';
import 'package:camera/camera.dart';
import 'package:eendigodemo/components/Facecompare/FaceCompareResult.dart';
import 'package:eendigodemo/model/LivenessCompareModel.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class FaceCompareDetail extends StatefulWidget {
  final String img1Base64;
  const FaceCompareDetail({required this.img1Base64}) : super();

  @override
  State<FaceCompareDetail> createState() =>
      _FaceCompareDetailState(img1Base64: img1Base64);
}

class _FaceCompareDetailState extends State<FaceCompareDetail> {
  final String img1Base64;
  _FaceCompareDetailState({required this.img1Base64}) : super();
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
  late Uint8List _imageBytes;
  String img2Base64 = "";
  late Timer _timer;
  int _start = 0;


  @override
  void initState() {
    initPage();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  Future<List<LivenessCompareModel>> FaceCompareAPI() async {
    List<LivenessCompareModel> data = [];
    const Url =
        'https://liveness-go3voyqswq-et.a.run.app/liveness-facecompare?';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    List<int> imageBytes1 = base64.decode(img1Base64);
    // final file = File(image1!.path);
    final pic = await http.MultipartFile.fromBytes('img1',imageBytes1,filename: 'image.png',
    contentType: MediaType('image', 'jpeg'));
    request.files.add(pic);
    List<int> imageBytes2 = base64.decode(img2Base64);
    // final file2 = File(image2!.path);
    // final pic2 = await http.MultipartFile.fromPath('img2', file2.path);
    final pic2 = await http.MultipartFile.fromBytes('img2',imageBytes2,filename: 'image2.png',
    contentType: MediaType('image2', 'jpeg'));
    request.files.add(pic2);

    request.fields['key'] = 'CV-ADINS-H1@B5476GTHDAD';
    request.fields['tenant_code'] = 'ADINS';
    String random16Digit = generateRandom16DigitNumber();
    request.fields['nik'] = random16Digit;
    final timeout = Duration(seconds: 30);
    final client = http.Client();
    try {
      final response =
          await client.send(request).timeout(timeout, onTimeout: () async {
        setState(() {
          isLoading = false;
          isFailed = true;
        });
        throw Exception('request timeout');
      });

      if (response.statusCode == 200) {
        var ujson1 = await utf8.decodeStream(response.stream);
        Map<String, dynamic> responses = json.decode(ujson1);
        LivenessCompareModel livenessDa =
            LivenessCompareModel.fromJson(responses);

        var status = responses['status'];
        var error = responses['error'];
        if (status == 'Failed') {
          setState(() {
            isLoading = false;
            isLive = true;
          });
          data.add(livenessDa);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FaceCompareResult(
                    img1Base64: img1Base64,
                    img2Base64: img2Base64,
                    data: data,
                  )));
        } else if (status == 'Success') {
          data.add(livenessDa);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FaceCompareResult(
                    img1Base64: img1Base64,
                    img2Base64: img2Base64,
                    data: data,
                  )));
        }
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
  Future<void> initializeCamera(int direction) async {
    try {
      if (cameraController != null) {
        await cameraController!.dispose();
      }
      var cameras = await availableCameras();
      cameraController =
          CameraController(cameras[direction], ResolutionPreset.high);
      cameraController!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          isInit = true;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void initPage() async {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      await initializeCamera(1);
      if (await Permission.camera.request().isGranted) {
        final cameras = await availableCameras();
      }
    } else {
      await initializeCamera(0);
    }

    setState(() {
      isCamera = true;
      cameraController?.resumePreview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Liveness & FaceCompare'),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("Assets/img/background-eendigo_(1).png"),
              fit: BoxFit.fill,
            )),
            child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ImageCatcher(context)))));
  }

    void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 100) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  Widget ImageCatcher(BuildContext context) {
    if (isInit == true) {
      return (isCamera == false)
          ? Column(
              children: [
                Padding(padding: EdgeInsets.all(16)),
                Center(
                  child: CircularProgressIndicator(),
                ),
                Center(
                  child: Text('This may take a while'),
                ),
                Text("$_start")
              ],
            )
          : Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text("2. Ambil foto pembanding",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Padding(padding: EdgeInsets.all(16)),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *
                        0.6, // 80% of screen width
                    height: MediaQuery.of(context).size.height *
                        0.5, // 50% of screen height
                    child: CameraPreview(cameraController!),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(16)),
              Center(
                  child: Stack(
                children: [
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: FancyButton(
                        buttonText: 'Ambil Foto',
                        onPressed: () async {
                          try {
                            final image = await cameraController!.takePicture();

                            if (!mounted) return;
                            image2 = File(image.path);
                            _imageBytes = await image.readAsBytes();
                            img2Base64 = base64Encode(_imageBytes);
                            if (image2 != null) {
                              setState(() {
                                startTimer();
                                isCamera = false;
                                isLoading = true;
                              });
                              FaceCompareAPI().then((value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            }
                          } catch (e) {
                            setState(() {
                              isCamera = false;
                              isLoading = false;
                              isFailed = true;
                              errMsg = e.toString();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  defaultTargetPlatform == TargetPlatform.iOS ||
                          defaultTargetPlatform == TargetPlatform.android
                      ? Positioned(
                          top: (MediaQuery.of(context).size.height / 16) / 8,
                          left: 20,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  if (isInit == true) {
                                    (direction == 0)
                                        ? direction = 1
                                        : direction = 0;
                                  }
                                  isInit = false;
                                  initializeCamera(direction);
                                });
                              },
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 92, 64, 115),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.flip_camera_android,
                                  color: Colors.grey.shade300,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ))
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  String generateRandom16DigitNumber() {
    Random random = Random();
    String number = '';

    for (int i = 0; i < 16; i++) {
      number += random.nextInt(10).toString();
    }

    return number;
  }
}
