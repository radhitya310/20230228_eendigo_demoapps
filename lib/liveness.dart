import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;

class Liveness extends StatefulWidget {
  const Liveness({Key? key}) : super(key: key);

  @override
  State<Liveness> createState() => _LivenessState();
}

class _LivenessState extends State<Liveness> {
  @override
  Widget build(BuildContext context) {
    final _introKey = GlobalKey<IntroductionScreenState>();
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 19),
      bodyPadding: EdgeInsets.all(16)
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Liveness'),),
      body: IntroductionScreen(
        key: _introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: "Liveness",
            body:
            "Liveness dapat memverifikasi user adalah orang sungguhan (bukan foto)",
            decoration: pageDecoration,
            footer: ElevatedButton(
              onPressed: () async {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StartCamera()));
                //if (await Permission.camera.request().isGranted) {
                //  final cameras = await availableCameras();
                //}
                //_introKey.currentState?.next();
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StartCamera()));
              },
              child: const Text(
                'Start Liveness'
              ),
            ),
          ),
          PageViewModel(
            title: "Liveness Result",
            bodyWidget: const StartCamera(),
            decoration: pageDecoration,
          )
        ],
        onDone: (){},
        showSkipButton: false,
        showNextButton: false,
        showDoneButton: true,
        showBackButton: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        back: const Icon(Icons.arrow_back),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done'),
        dotsDecorator: const DotsDecorator(
            size: Size(10,10),
            color: Colors.grey,
            activeSize: Size(22,10),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))
            )
        ),
      ),
    );
  }
}

class StartCamera extends StatefulWidget {
  const StartCamera({Key? key}) : super(key: key);

  @override
  State<StartCamera> createState() => _StartCameraState();
}

class _StartCameraState extends State<StartCamera> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  Future<File?> _takePicture() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return File(image.path);
  }

  Future<void> _sendPicture(XFile imageFile) async {
    final url = Uri.parse('https://your-api-endpoint.com/upload');
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('picture', imageFile.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      // handle successful response
    } else {
      // handle error response
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(cameraController.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = 1;
                  startCamera(direction);
                });
              },
              child: button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () async {
                cameraController.takePicture().then((XFile? file) async {
                  if(mounted) {
                    if(file != null) {
                      await _sendPicture(file);
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}