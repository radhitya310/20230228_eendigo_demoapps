// ignore_for_file: override_on_non_overriding_member, constant_identifier_names

import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:eendigodemo/components/Liveness/LivenessCapture.dart';
import 'package:eendigodemo/components/master/urlMaster.dart';
import 'package:eendigodemo/model/LivenessModel.dart';
import 'package:eendigodemo/widget/FancyButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Liveness extends StatefulWidget {
  const Liveness({Key? key}) : super(key: key);

  @override
  State<Liveness> createState() => _LivenessState();
}

class _LivenessState extends State<Liveness> {
  final _introKey = GlobalKey<IntroductionScreenState>();
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

  @override
  void initState() {
    //initializeCamera(1);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // Perform any necessary cleanup here.
    cameraController?.dispose();
    super.dispose();
  }

  Future<List<LivenessModel>> LivenessAPI(File _image) async {
    List<LivenessModel> data = [];
    String Url = UrlPath.liveness;

    final file = File(_image.path);

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    http.MultipartFile pic;
    try {
      if (defaultTargetPlatform != TargetPlatform.iOS ||
          defaultTargetPlatform != TargetPlatform.android) {
        //_imageBytes = await file.readAsBytes();
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
    request.fields['key'] = 'CV-ADINS-H1@B5476GTHDAD';
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
        var datetime = responses['datetime'];
        if (status.toString().toLowerCase() == 'failed') {
          data.add(livenessDa);
          liveScore = data[0].result[0].faceLiveness.score.toString();
          setState(() {
            isLoading = false;
            isFailed = true;
          });
          var error = responses['error'];
          errMsg = error;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Request Failed : ' + ujson1.toString())),
          );
        } else if (status == 'Success') {
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
    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 19),
        bodyPadding: EdgeInsets.all(16),
        imagePadding: EdgeInsets.only(top: 12.0));

    const pageDecorationCam = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 19),
      bodyPadding: EdgeInsets.all(0),
      titlePadding: EdgeInsets.only(top: 5, bottom: 10),
    );

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
              child: IntroPage(context)
              
            )
          )
        )
    );

    /*
    if (MediaQuery.of(context).size.width < 700) {
      // mobile layout
      return Scaffold(
        appBar: AppBar(
          title: const Text('Liveness'),
        ),
        body: Container(
          decoration: BackgroundImage(),
          child: IntroductionScreen(
            key: _introKey,
            globalBackgroundColor: Colors.transparent,
            pages: [
              PageViewModel(
                title: "Liveness",
                bodyWidget: IntroPage(context),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Posisikan wajah anda",
                bodyWidget: Container(child: ImageCatcher(context)),
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
            showDoneButton: false,
            showBackButton: false,
            isBottomSafeArea: false,
            overrideDone: TextButton(
              child: Text(''),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            freeze: false,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            back: const Icon(Icons.arrow_back),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Done'),
            dotsDecorator: const DotsDecorator(
                size: Size(0, 0),
                color: Colors.transparent,
                activeSize: Size(0, 0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)))),
          ),
        ),
      );
    } else {
      // web layout
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
              child: IntroductionScreen(
                key: _introKey,
                globalBackgroundColor: Colors.transparent,
                pages: [
                  PageViewModel(
                    title: "Liveness",
                    body:
                        "Liveness Detection adalah sistem teknologi biometrik untuk mendeteksi keaslian wajah dari seseorang.",
                    image: Image.asset("Assets/img/icon-liveness.png"),
                    footer: ElevatedButton(
                      child: Text("Start Liveness"),
                      onPressed: () async {
                        try {
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
                            Future(() => _introKey.currentState?.next());
                          });
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    title: "Posisikan wajah anda",
                    bodyWidget: Container(
                      child: ImageCatcher(context),
                    ),
                    decoration: pageDecorationCam,
                    useScrollView: false,
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
                isProgressTap: false,
                overrideDone: TextButton(
                  child: Text(''),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                freeze: false,
                scrollPhysics: const NeverScrollableScrollPhysics(),
                back: const Icon(Icons.arrow_back),
                next: const Icon(Icons.arrow_forward),
                done: const Text('Done'),
                dotsDecorator: const DotsDecorator(
                    size: Size(0, 0),
                    color: Colors.grey,
                    activeSize: Size(0, 0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
              ),
            ),
          ),
        ),
      );
      
    }*/
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
      _image = pickedImageFile;
      print('Image Path $_image');
      isLoading = true;
      LivenessAPI(_image!).then((value) {
        if (value.isNotEmpty) {
          setState(() {
            isLoading = false;
          });
        }
      });
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
          : Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              0.6, // 80% of screen width
                          height: MediaQuery.of(context).size.height *
                              0.5, // 50% of screen height
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
                                  height: 500,
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
                                  _imageBytes = await image.readAsBytes();
                                  // var img = await Image.file(_image!);
                                  // final _imageBytes = await imageToByte(_image);
                                  if (_image != null) {
                                    setState(() {
                                      isCamera = false;
                                      isLoading = true;
                                    });
                                    //_takePhoto();
                                    LivenessAPI(_image!).then((value) {
                                      if (value.isNotEmpty) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }
                                    });
                                    //dispose();
                                    Future(
                                        () => _introKey.currentState?.next());
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
              ),
            );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Widget ResultWidget(BuildContext context) {
    //Color labelColor = int.parse(liveScore) > 80 ? Colors.blue : Colors.red;
    if (isLoading == true) {
      return Column(
        children: const [
          Center(
            child: CircularProgressIndicator(),
          ),
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
                          : const Text("You are Live!"),
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: double.parse(liveScore) > 80
                                  ? Colors.blue
                                  : Colors.red,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            'Score: ' + toDoubleDigit(liveScore),
                            style: TextStyle(
                              color: double.parse(liveScore) > 80
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
                      // Text("Your Live Score is " + liveScore)
                    ],
                  ));
      } else {
        return Column(
          children: [
            Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ((defaultTargetPlatform == TargetPlatform.iOS ||
                            defaultTargetPlatform == TargetPlatform.android))
                        ? Image.file(
                            File(_image!.path),
                            fit: BoxFit.fill,
                          )
                        : Image.asset(_image!.path)),
                const SizedBox(height: 20),
                (isLive == false)
                    ? const Text("Sorry, you are spoofing.")
                    : const Text("You are Live!"),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: double.parse(liveScore) > 80
                            ? Colors.blue
                            : Colors.red,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      'Score: ' + toDoubleDigit(liveScore),
                      style: TextStyle(
                        color: double.parse(liveScore) > 80
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
                Text("Your Live Score is " + liveScore)
              ],
            ),
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
                LivenessAPI(_image!).then((value) {
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

  String toDoubleDigit(String value) {
    double numericValue = double.parse(value);
    String formattedValue = numericValue.toStringAsFixed(2);
    return formattedValue;
  }

  Widget IntroPage(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset("Assets/img/icon-liveness.png")),
          const SizedBox(height: 20),
          Text(
              "Liveness Detection adalah sistem teknologi biometrik untuk mendeteksi keaslian wajah dari seseorang.",
              style: TextStyle(fontSize: 20)),
          const SizedBox(height: 25),
          FancyButton(
            buttonText: 'Start Liveness',
            onPressed: () async {
              try {
                // if (defaultTargetPlatform == TargetPlatform.iOS ||
                //     defaultTargetPlatform == TargetPlatform.android) {
                //   // Some android/ios specific code
                //   await initializeCamera(1);
                //   if (await Permission.camera.request().isGranted) {
                //     final cameras = await availableCameras();
                //   }
                // } else {
                //   await initializeCamera(0);
                // }
                // _introKey.currentState?.next();
                setState(() {
                  // isCamera = true;
                  // cameraController?.resumePreview();
                  // Future(() => _introKey.currentState?.next());
                  Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LivenessCapture()));
                });
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
