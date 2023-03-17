import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/components/OCRResult/OcrResult.dart';
import 'package:eendigodemo/liveness.dart';
import 'package:eendigodemo/model/KKOCRModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class contohKamera extends StatefulWidget {
  @override
  State<contohKamera> createState() => _OcrHomepageState();
}

class _OcrHomepageState extends State<contohKamera> {
  CameraController? cameraController;
  File? _image;
  bool isLoading = false;
  bool isCamera = false;
  bool isInit = false;
  int direction = 0;

  _OcrHomepageState();

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(image!.path);
    setState(() {
      _image = pickedImageFile;
      print('Image Path $_image');
    });
  }

  @override
  Future getImagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    final pickedImageFile = File(image!.path);
    setState(() {
      _image = pickedImageFile;
      print('Image Path $_image');
    });
  }

  Future<List<Kkocr>> KtpOcrApi(File _KtpImage) async {
    List<Kkocr> data = [];

    final Url =
        'https://5236635838005115.ap-southeast-5.fc.aliyuncs.com/2016-08-15/proxy/ocr/kk/';

    var request = http.MultipartRequest('POST', Uri.parse(Url));
    // final file = File(_KtpImage.path);
    final file = File(_KtpImage.path);
    final pic = await http.MultipartFile.fromPath('img', file.path);
    request.files.add(pic);
    request.fields['key'] = 'CV-ADINS-H1@W35GHRE0ZBFIF';
    request.fields['tenant_code'] = 'FIF';

    final response = await request.send();

    if (response.statusCode == 200) {
      print('aa');
      var ujson1 = await utf8.decodeStream(response.stream);
      Map<String, dynamic> responses = json.decode(ujson1);
      var message = responses['message'];
      var date = responses['ocr_date'];
      var status = responses['status'];
      if (status == 'FAILED') {
        setState(() {
          isLoading = false;
        });
        print('failed');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } else if (status == 'SUCCESS') {
        Map<String, dynamic> read = responses['read'];
        Read reads = Read.fromJson(read);

        data.add(Kkocr(
            message: message, ocrDate: date, read: reads, status: status));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request Failed')),
      );
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage("Assets/img/background-eendigo_(1).png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            color: Color.fromARGB(136, 255, 255, 255),
            padding: const EdgeInsets.all(16),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {});
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        // ignore: prefer_const_constructors
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 89, 83, 108),
                        ),
                        fillColor: Colors.grey.shade300,
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 92, 64, 115),
                            ),
                            borderRadius: BorderRadius.circular(50.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 92, 64, 115),
                            ),
                            borderRadius: BorderRadius.circular(50.0)),
                        contentPadding:
                            const EdgeInsets.only(top: 14.0, left: 20.0),
                        hintText: 'Email Address',
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: (isCamera == false)
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isLoading = true;
                  });
                  if (_image != null) {
                    KtpOcrApi(_image!).then((value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          isLoading = false;
                        });
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => OcrResults(data: value)));
                      }
                    });
                  } else {
                    print('no images');
                  }
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.navigation),
              )
            : null,
        body: Center(child: ImageCatcher(context)),
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

  @override
  void initState() {
    initializeCamera(direction);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
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
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isCamera = true;
                          });
                          Navigator.pop(context);
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

  @override
  Widget ImageCatcher(BuildContext context) {
    return Center(
        child: (isCamera == false)
            ? (isLoading == false)
                ? Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height / 3.5,
                    child: (_image == null)
                        ? InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              imageChooser(context);
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                width: MediaQuery.of(context).size.width - 50,
                                child: DottedBorder(
                                  color: const Color.fromARGB(255, 78, 199, 30),
                                  strokeWidth: 1,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.plus),
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width - 50,
                            child: Image.file(
                              File(_image!.path),
                            )))
                : SizedBox(
                    height: 100, width: 100, child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  (isInit == true)
                      ? Stack(children: [
                          AspectRatio(
                            aspectRatio: 3 / 4,
                            child: CameraPreview(cameraController!),
                          ),
                          Positioned(
                              top: (MediaQuery.of(context).size.height -
                                      MediaQuery.of(context).size.height / 4) /
                                  4,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 400,
                                    height: 209,
                                  ),
                                ),
                              )),
                        ])
                      : AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Center(child: CircularProgressIndicator())),
                  Container(
                    child: Center(
                        child: Stack(
                      children: [
                        Positioned(
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                try {
                                  final image =
                                      await cameraController!.takePicture();

                                  if (!mounted) return;
                                  _image = File(image.path);
                                  if (_image != null) {
                                    setState(() {
                                      isCamera = false;
                                      print('asad');
                                    });
                                  }
                                } catch (e) {
                                  // If an error occurs, log the error to the console.
                                  print(e);
                                }
                              },
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
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
                          top: (MediaQuery.of(context).size.height / 4) / 8,
                          left: 20,
                          child: Align(
                            alignment: Alignment.centerLeft,
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
                                decoration: BoxDecoration(
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
                    )),
                  )
                ],
              ));
  }
}
