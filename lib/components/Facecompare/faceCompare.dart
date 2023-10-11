// ignore_for_file: override_on_non_overriding_member, constant_identifier_names

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/model/LivenessCompareModel.dart';
import 'package:eendigodemo/model/LivenessModel.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_to_byte/image_to_byte.dart';

class FaceCompare extends StatefulWidget {
  const FaceCompare({Key? key}) : super(key: key);

  @override
  State<FaceCompare> createState() => _FaceCompareState();
}

class _FaceCompareState extends State<FaceCompare> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  CameraController? cameraController;
  File? _image;
  File? _image2;
  bool isLoading = false;
  bool isCamera = false;
  bool isLive = false;
  bool isInit = false;
  bool isFailed = false;
  bool isCompare = false;
  String liveScore = "0";
  String similarity = "0";
  int direction = 0;
  String errMsg = "";

  // void _takePhoto() async {
  //   try {
  //     // Convert the blob data to a Uint8List.
  //     // final reader = html.FileReader();
  //     // reader.readAsArrayBuffer(blob);
  //     // await reader.onLoad.first;
  //     // final bytes = reader.result as Uint8List;

  //     // Save the image to local storage.
  //     final directory = 'C:\\';
  //     final imagePath = '$directory/image.jpg';
  //     //final file = html.File([bytes], 'image.jpg');
  //     js.context.callMethod('saveAs', [_image, imagePath]);

  //   } catch (e) {
  //     print('Error taking photo: $e');
  //   }
  // }

  @override
  void initState() {
    initializeCamera(1);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here.
    cameraController?.dispose();
    super.dispose();
  }

  Future<List<LivenessCompareModel>> FaceCompareAPI() async {
    List<LivenessCompareModel> data = [];
    const Url =
        'https://liveness-go3voyqswq-et.a.run.app/liveness-facecompare?';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    final file = File(_image!.path);
    final pic = await http.MultipartFile.fromPath('img1', file.path);
    request.files.add(pic);
    final file2 = File(_image2!.path);
    final pic2 = await http.MultipartFile.fromPath('img2', file2.path);
    request.files.add(pic2);
    request.fields['key'] = 'CV-ADINS-H1@B5476GTHDAD';
    request.fields['tenant_code'] = 'ADINS';
    request.fields['nik'] = '3275083110990013';
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
            liveScore = livenessDa.result[0].faceLiveness.score.toString();
            similarity = livenessDa.result[0].faceCompare.similarity.toString();
            if (livenessDa.error.toLowerCase().contains('verify')) {
              isCompare = false;
            }

            if (livenessDa.error.toLowerCase().contains('selfie')) {
              isLive = false;
              isCompare = false;
            }

            if (livenessDa.error.toLowerCase().contains('image')) {
              isFailed = false;
            }
          });
          data.add(livenessDa);
        } else if (status == 'Success') {
          //var result = responses['result'];
          //List<ResultModel> resultObj = result as List<ResultModel>;

          data.add(livenessDa);

          setState(() {
            liveScore = data[0].result[0].faceLiveness.score.toString();
            if (data[0].result[0].faceLiveness.live == "True") {
              isLive = true;
            } else {
              isLive = false;
            }
            isLoading = false;
            isFailed = false;
          });
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
          SnackBar(content: Text('Request Failed : ' + errMsg)),
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
    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 19),
        bodyPadding: EdgeInsets.all(16));

    const pageDecorationCam = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 19));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liveness Check & Compare'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("Assets/img/background-eendigo_(1).png"),
          fit: BoxFit.cover,
        )),
        child: IntroductionScreen(
          key: _introKey,
          globalBackgroundColor: Colors.transparent,
          pages: [
            PageViewModel(
              title: "Liveness Check & Compare",
              bodyWidget: IntroPage(context),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Posisikan wajah anda di kamera",
              bodyWidget: SingleChildScrollView(
                child: ImageCatcher(context),
                physics: NeverScrollableScrollPhysics(),
              ),
              decoration: pageDecorationCam,
            ),
            PageViewModel(
              title: "Ambil foto KTP",
              bodyWidget: SingleChildScrollView(
                child: KtpPage(context),
                physics: NeverScrollableScrollPhysics(),
              ),
              decoration: pageDecorationCam,
            ),
            PageViewModel(
              title: "Result",
              bodyWidget: ResultWidget(context),
              decoration: pageDecoration,
            )
          ],
          onDone: () {},
          showSkipButton: false,
          showNextButton: false,
          showDoneButton: true,
          showBackButton: true,
          freeze: false,
          scrollPhysics: const NeverScrollableScrollPhysics(),
          back: const Icon(Icons.arrow_back),
          next: const Icon(Icons.arrow_forward),
          done: const Text('Done'),
          dotsDecorator: const DotsDecorator(
              size: Size(10, 10),
              color: Colors.grey,
              activeSize: Size(22, 10),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)))),
        ),
      ),
    );
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

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(image!.path);
    setState(() {
      if (_image == null) {
        _image = pickedImageFile;
      } else {
        _image2 = pickedImageFile;
      }

      if (_image2 != null) {
        isLoading = true;
        FaceCompareAPI().then((value) {
          if (value.isNotEmpty) {
            setState(() {
              isLoading = false;
            });
          }
        });
      }
    });
  }

  void imageChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Select image from",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        getImage();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.archivebox,
                            size: 50,
                          ),
                          Text("From gallery")
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCamera = true;
                        });
                        Navigator.pop(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            CupertinoIcons.camera,
                            size: 50,
                          ),
                          Text("From camera")
                        ],
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
    if (isInit == true) {
      return (isCamera == false)
          ? const SingleChildScrollView()
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 4.5 / 5,
                        child: CameraPreview(cameraController!),
                      ),
                      Positioned(
                          top: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).size.height / 1.7) /
                              4,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 400,
                                height: 209,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Center(
                      child: Stack(
                    children: [
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () async {
                              try {
                                // Ensure that the camera is initialized.
                                //await initializeCamera(1);

                                // Attempt to take a picture and get the file `image`
                                // where it was saved.
                                final image =
                                    await cameraController!.takePicture();

                                if (!mounted) return;

                                // If the picture was taken, display it on a new screen.
                                _image = File(image.path);
                                // var img = await Image.file(_image!);
                                // final _imageBytes = await imageToByte(_image);
                                if (_image != null) {
                                  setState(() {
                                    //cameraController!.dispose();
                                    //initializeCamera(0);
                                    //isCamera = false;
                                    isLoading = true;
                                  });
                                  //_takePhoto();
                                  // FaceCompareAPI(_image!).then((value) {
                                  //   if (value.isNotEmpty) {
                                  //     setState(() {
                                  //       isLoading = false;
                                  //     });
                                  //   }
                                  // });
                                  Future(() => _introKey.currentState?.next());
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
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 92, 64, 115),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey.shade300,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
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
                                // imageChooser(context);
                                // Future(() => _introKey.currentState?.next());
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
                      ),
                    ],
                  ))
                ],
              ),
            );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget KtpPage(BuildContext context) {
    if (isInit == true) {
      return (isCamera == false)
          ? const SingleChildScrollView()
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 4.5 / 5,
                        child: CameraPreview(cameraController!),
                      ),
                      Positioned(
                          top: (MediaQuery.of(context).size.height -
                                  MediaQuery.of(context).size.height / 1.7) /
                              4,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10)),
                                width: 400,
                                height: 209,
                              ),
                            ),
                          )),
                    ],
                  ),
                  Center(
                      child: Stack(
                    children: [
                      Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () async {
                              try {
                                // Ensure that the camera is initialized.
                                //await initializeCamera(direction);

                                // Attempt to take a picture and get the file `image`
                                // where it was saved.
                                final image =
                                    await cameraController!.takePicture();

                                if (!mounted) return;

                                // If the picture was taken, display it on a new screen.
                                _image2 = File(image.path);
                                // var img = await Image.file(_image!);
                                // final _imageBytes = await imageToByte(_image);
                                if (_image2 != null) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  //_takePhoto();
                                  FaceCompareAPI().then((value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                  Future(() => _introKey.currentState?.next());
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
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 92, 64, 115),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey.shade300,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.height / 16) / 8,
                        left: 20,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () async {
                              setState(() {
                                //_changeCamera();
                                if (isInit == true) {
                                  (direction == 0)
                                      ? direction = 1
                                      : direction = 0;
                                }
                                isInit = false;
                                initializeCamera(direction);
                                // imageChooser(context);
                                // Future(() => _introKey.currentState?.next());
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
                      ),
                    ],
                  ))
                ],
              ),
            );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget ResultWidget(BuildContext context) {
    if (isLoading == true) {
      return Column(
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text('This may take a while'),
          ),
        ],
      );
    } else {
      if (isFailed == false) {
        return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 50,
            child: (_image == null)
                ? Container()
                : Column(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 2,
                          child:
                              ((defaultTargetPlatform == TargetPlatform.iOS ||
                                      defaultTargetPlatform ==
                                          TargetPlatform.android))
                                  ? Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(_image!.path)),
                      const SizedBox(height: 20),
                      (isLive == false)
                          ? const Text("Sorry, you are spoofing.")
                          : const Text("You are Live,"),
                      (isCompare == false)
                          ? const Text(" and your image not match with KTP")
                          : const Text(" and matched with KTP"),
                      Text("Your Live Score is " + liveScore),
                      Text("Your face similarity with KTP is " + similarity)
                    ],
                  ));
      } else {
        return Column(
          children: [
            Center(
              child: Text('Failed to Connect to Server'),
            ),
            Center(
              child: Text('Error Message : ' + errMsg),
            ),
            FancyButton(
              buttonText: 'Retry',
              onPressed: () async {
                setState(() {
                  errMsg = "";
                  isLoading = true;
                  isFailed = false;
                });
                FaceCompareAPI().then((value) {
                  if (value.isNotEmpty) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                });
              },
            )
          ],
        );
      }
    }
  }

  Widget IntroPage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset("Assets/img/icon-liveness.png")),
          const SizedBox(height: 20),
          Text(
              "Liveness Check dan Compare adalah Product teknologi biometrik untuk mendeteksi keaslian wajah dari seseorang dan mengcompare dengan foto lain / foto KTP",
              style: TextStyle(fontSize: 16)),
          const SizedBox(height: 50),
          FancyButton(
            buttonText: 'Start Demo',
            onPressed: () async {
              try {
                direction = 1;
                await initializeCamera(direction);
                if (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android) {
                  // Some android/ios specific code
                  if (await Permission.camera.request().isGranted) {
                    final cameras = await availableCameras();
                  }
                }
                // _introKey.currentState?.next();
                setState(() {
                  isCamera = true;
                  cameraController?.resumePreview();
                });
                Future(() => _introKey.currentState?.next());
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          )
        ],
      ),
    );
  }
}
