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

class LivenessCapture extends StatefulWidget {
  const LivenessCapture({Key? key}) : super(key: key);

  @override
  State<LivenessCapture> createState() => _LivenessCaptureState();
}

class _LivenessCaptureState extends State<LivenessCapture> {
  CameraController? cameraController;
  File? _image;
  bool isLoading = false;
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
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      // Some android/ios specific code
      await initializeCamera(direction);      
    } else {
      await initializeCamera(0);
    }
    if (await Permission.camera.request().isGranted) {
      final cameras = await availableCameras();
    }
    setState(() {
      cameraController?.resumePreview();
    });
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
                    width: MediaQuery.of(context).size.width / 2,
                    child: ImageCatcher(context)))));
  }

  Future<List<LivenessModel>> LivenessAPI(File _image) async {
    List<LivenessModel> data = [];
    final Url = UrlPath.liveness;
    base64Image = base64Encode(_imageBytes);
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
    //request.files.add(pic);
    request.fields['key'] = 'CV-ADINS-PROD-H1@DT476WATDADT4WA';
    request.fields['tenant_code'] = 'ADINS';

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
        LivenessModel livenessDa = LivenessModel.fromJson(responses);
        var status = responses['status'];
        var error = responses['error'];

        if (status.toString().toLowerCase() == 'failed') {
          errMsg = error;
        }

        setState(() {
            isLoading = false;
            isFailed = true;
            initPage();
            _start = 0;
            _timer.cancel();
        });

        data.add(livenessDa);
        base64Image = base64Encode(_imageBytes);
        Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LivenessResult(
                    data: data,
                    imgBase64: base64Image,
                  )));
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
          initPage();
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
        _start = 0;
        _timer.cancel();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request Failed : ' + ujson1.toString())),
        );
      }
    } catch (e) {
      setState(() {
        errMsg = e.toString();
        isLoading = false;
        isFailed = true;
        initPage();
        _start = 0;
        _timer.cancel();
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
          isCamera = true;
          isInit = true;
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
    if (isInit == true) {
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
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                          "Pastikan wajah anda terlihat jelas di kamera",
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
                        // Positioned(
                        //     top: (MediaQuery.of(context).size.height -
                        //             MediaQuery.of(context).size.height / 1.7) /
                        //         4,
                        //     left: 0,
                        //     right: 0,
                        //     child: Align(
                        //       alignment: Alignment.center,
                        //       child: Padding(
                        //         padding:
                        //             const EdgeInsets.symmetric(horizontal: 25),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               border: Border.all(color: Colors.white),
                        //               borderRadius: BorderRadius.circular(10)),
                        //           width: 400,
                        //           height: 500,
                        //         ),
                        //       ),
                        //     )),
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
                                      startTimer();
                                      isCamera = false;
                                      isLoading = true;
                                    });
                                    LivenessAPI(_image!).then((value) {
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
