import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:eendigodemo/components/Liveness/LivenessResult.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/model/LivenessModel.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class LivenessCatcher extends StatefulWidget {
  final String title;

  LivenessCatcher(this.title);
  @override
  State<LivenessCatcher> createState() => _LivenessCatcherState(title);
}

class _LivenessCatcherState extends State<LivenessCatcher> {
  final String title;
  _LivenessCatcherState(this.title);
  CameraController? cameraController;
  File? _image;
  bool isLoading = false;
  bool isCamera = false;
  bool isInit = false;
  bool isFailed = false;
  String liveScore = "0";
  int camDirection = 1;
  String errMsg = "";
  late Uint8List _imageBytes;
  String base64Image = "";
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

  void initPage() async {
    if (!kIsWeb) {
      await initializeCamera(camDirection);
    } else {
      await initializeCamera(0);
    }
    // setState(() {
    //   cameraController?.resumePreview();
    // });
  }

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
                    width: MediaQuery.of(context).size.width,
                    child: ImageCatcher(context)))));
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
          isCamera = true;
          isInit = true;
          // cameraController?.pausePreview();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
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
    if (isInit) {
      return (isCamera == false)
          ? Column(
              children: [
                Padding(padding: EdgeInsets.all(16)),
                Center(
                  child: CircularProgressIndicator(),
                ),
                Padding(padding: EdgeInsets.all(16)),
                Center(
                  child: Text('This may take a while $_start'),
                )
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                          "Pastikan wajah anda terlihat jelas di kamera",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.8, // 80% of screen width
                          height: MediaQuery.of(context).size.height *
                              0.6, // 50% of screen height
                          child: CameraPreview(cameraController!),
                        ),
                      ],
                    ),
                    Padding(padding: EdgeInsets.all(16)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: !kIsWeb
                              ? Align(
                                  alignment: Alignment.topLeft,
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        if (isInit == true) {
                                          (camDirection == 0)
                                              ? camDirection = 1
                                              : camDirection = 0;
                                        }
                                        isInit = false;
                                        initializeCamera(camDirection);
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
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
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
                                  });
                                  Navigator.pop(context, image);
                                }
                              } catch (e) {}
                            },
                            child: Text('Ambil Foto'),
                          ),
                        ),
                      ],
                    ),

                    // Center(
                    //     child: Stack(
                    //   children: [
                    //     Positioned(
                    //       child: Align(
                    //         alignment: Alignment.center,
                    //         child: FancyButton(
                    //           buttonText: 'Ambil Foto',
                    //           onPressed: () async {
                    //             try {
                    //               final image =
                    //                   await cameraController!.takePicture();

                    //               if (!mounted) return;
                    //               _image = File(image.path);
                    //               _imageBytes = await image.readAsBytes();
                    //               if (_image != null) {
                    //                 Navigator.pop(context, image);
                    //               }
                    //             } catch (e) {
                    //             }
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     defaultTargetPlatform == TargetPlatform.iOS ||
                    //             defaultTargetPlatform == TargetPlatform.android
                    //         ? Positioned(
                    //             top: (MediaQuery.of(context).size.height / 16) /
                    //                 8,
                    //             left: 20,
                    //             child: Align(
                    //               alignment: Alignment.topLeft,
                    //               child: InkWell(
                    //                 onTap: () async {
                    //                   setState(() {
                    //                     if (isInit == true) {
                    //                       (direction == 0)
                    //                           ? direction = 1
                    //                           : direction = 0;
                    //                     }
                    //                     isInit = false;
                    //                     initializeCamera(direction);
                    //                   });
                    //                 },
                    //                 child: Container(
                    //                   width: 50,
                    //                   height: 50,
                    //                   decoration: const BoxDecoration(
                    //                     color: Color.fromARGB(255, 92, 64, 115),
                    //                     shape: BoxShape.circle,
                    //                   ),
                    //                   child: Icon(
                    //                     Icons.flip_camera_android,
                    //                     color: Colors.grey.shade300,
                    //                     size: 30,
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           )
                    //         : Container(),
                    //   ],
                    // ))
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
