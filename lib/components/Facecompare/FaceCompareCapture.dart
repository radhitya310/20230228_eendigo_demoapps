import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:eendigodemo/components/Facecompare/FaceCompareDetail.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FaceCompareCapture extends StatefulWidget {
  const FaceCompareCapture({Key? key}) : super(key: key);

  @override
  State<FaceCompareCapture> createState() => _FaceCompareCaptureState();
}

class _FaceCompareCaptureState extends State<FaceCompareCapture> {
  CameraController? cameraController;
  File? _image;
  bool isLoading = false;
  bool isCamera = false;
  bool isLive = false;
  bool isInit = false;
  bool isFailed = false;
  String liveScore = "0";
  int direction = 0;
  String errMsg = "";
  late Uint8List _imageBytes;
  String base64Image = "";

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

  Widget ImageCatcher(BuildContext context) {
    if (isInit == true) {
      return Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                          "1. Pastikan wajah anda terlihat jelas di kamera",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
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
                                  final image =
                                      await cameraController!.takePicture();

                                  if (!mounted) return;
                                  _image = File(image.path);
                                  _imageBytes = await image.readAsBytes();
                                  if (_image != null) {
                                    setState(() {
                                      isCamera = false;
                                      isLoading = true;
                                    });
                                    // LivenessAPI(_image!).then((value) {
                                    //   if (value.isNotEmpty) {
                                    //     setState(() {
                                    //       isLoading = false;
                                    //     });
                                    //   }
                                    // });
                                    base64Image = base64Encode(_imageBytes);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FaceCompareDetail(                                                  
                                                  img1Base64: base64Image,
                                                )));
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
                                top: (MediaQuery.of(context).size.height / 16) /
                                    8,
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
}