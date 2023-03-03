import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '';

class CameraCompoent extends StatefulWidget {
  const CameraCompoent({key});

  @override
  State<CameraCompoent> createState() => _CameraCompoentState();
}

class _CameraCompoentState extends State<CameraCompoent> {
  CameraController? cameraController;

  @override
  Future<void> initializeCamera() async {
    var cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await cameraController!.initialize();
  } 
  
  @override
  void dispose() { 
    super.dispose();
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -  MediaQuery.of(context).size.height / 4 ;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/img/background-eendigo_(1).png"),
            fit: BoxFit.cover,)),
            child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: initializeCamera(),
          builder: ((context, snapshot) =>
            (snapshot.connectionState == ConnectionState.done) ? 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: CameraPreview(cameraController!),
                        ),
                        Positioned(
                          top: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 4 ) / 4,
                          left: 0,
                          right: 0,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(padding: EdgeInsets.symmetric(horizontal: 25), 
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)
                                ), 
                                width: 400,
                                height: 209,
                              ),),
                          ) 
                        )
                      ],
                     ),
                     Container(
                      child: Center(
                        child: InkWell(
                        onTap: () async {
                          XFile image = await cameraController!.takePicture();
                          File picture = File(image.path);
                          
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      )),
                     )
                  
                ],
              ) : 
              Center(child: Text('no data'),)
          ),
        )
      ),
    );
  }

  Widget CameraPriview() {
    if (cameraController == null || cameraController!.value.isInitialized == false) {
      return CircularProgressIndicator();
    } return AspectRatio(
      aspectRatio: cameraController!.value.aspectRatio,
      child: CameraPreview(cameraController!),
      );
  }
}