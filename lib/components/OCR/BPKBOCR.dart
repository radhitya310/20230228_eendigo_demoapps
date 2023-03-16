import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:eendigodemo/CameraController/CameraContorller.dart';
import 'package:eendigodemo/components/OCRResult/BPKBResults.dart';
import 'package:eendigodemo/model/BPKBModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:simple_gradient_text/simple_gradient_text.dart';

class BPKBOCR extends StatefulWidget {
  final List<Bpkbocr> data = [];
  final String title;

  BPKBOCR(this.title);

  @override
  State<BPKBOCR> createState() => _OcrHomepageState(title);
}

class _OcrHomepageState extends State<BPKBOCR> {
  File? _image;
  File? _image2;
  bool isLoading = false;
  final String title;

  _OcrHomepageState(this.title);

  Future getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  @override
  Future getImagecamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  Future getImage2() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image2 = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  @override
  Future getImagecamera2() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final pickedImageFile = File(image.path);
      setState(() {
        _image2 = pickedImageFile;
        print('Image Path $_image');
      });
    }
  }

  Future<List<Bpkbocr>> KtpOcrApi(File? _BPKBImage, File? _BPKBImage2) async {
    List<Bpkbocr> data = [];

    final Url =
        'https://5236635838005115.ap-southeast-5.fc.aliyuncs.com/2016-08-15/proxy/ocr/bpkb/';

    var request = http.MultipartRequest('POST', Uri.parse(Url));

    final file = File('');
    final file2 = File('');

    if (_BPKBImage != null && _BPKBImage2 != null) {
      final file = File(_BPKBImage.path);
      final file2 = File(_BPKBImage2.path);
      final pic = await http.MultipartFile.fromPath('halaman2', file.path);
      request.files.add(pic);
      final pic2 = await http.MultipartFile.fromPath('halaman3', file2.path);
      request.files.add(pic2);
    } else if (_BPKBImage != null && _BPKBImage2 == null) {
      final file = File(_BPKBImage.path);
      final pic = await http.MultipartFile.fromPath('halaman2', file.path);
      // final pic2 = await http.MultipartFile.fromPath('halaman3', '');
      request.files.add(pic);
      // request.files.add(pic2);
    } else {
      final file2 = File(_BPKBImage2!.path);
      final pic2 = await http.MultipartFile.fromPath('halaman3', file2.path);
      request.files.add(pic2);
    }
    request.fields['key'] = 'CV-ADINS-H1@W35GHRE0ZBFIF';
    request.fields['tenant_code'] = 'FIF';

    final timeout = Duration(seconds: 30);
    final client = http.Client();
    final response =
        await client.send(request).timeout(timeout, onTimeout: () async {
      // client.close();
      print('request timeout');
      throw Exception('request timeout');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request Timeout')),
      );
    });

    if (response.statusCode == 200) {
      print('aa');
      var ujson1 = await utf8.decodeStream(response.stream);
      Map<String, dynamic> responses = json.decode(ujson1);
      var message = responses['message'];
      var date = responses['ocr_date'];
      var status = responses['status'];
      var num_of_pages = responses['num_of_pages'];
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

        data.add(Bpkbocr(
            ocrDate: date,
            message: message,
            read: reads,
            status: status,
            numOfPages: num_of_pages));
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('failed');
      print(response.statusCode);
      print(response.request);
      // print(await utf8.decodeStream(response.stream));
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
          floatingActionButton: (isLoading == false)
              ? FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    if (_image != null || _image2 != null) {
                      KtpOcrApi(_image, _image2).then((value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            isLoading = false;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BPKBRESULTS(data: value)));
                        }
                      });
                    } else {
                      print('no images');
                    }
                  },
                  backgroundColor: Color.fromARGB(255, 190, 126, 174),
                  child: const Icon(Icons.send),
                )
              : null,
          body: (isLoading == false)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GradientText(title,
                            style: (TextStyle(
                                fontSize: 60, fontWeight: FontWeight.bold)),
                            colors: [
                              Color.fromARGB(255, 37, 162, 220),
                              Color.fromARGB(255, 28, 115, 185),
                              Color.fromARGB(255, 59, 67, 127),
                            ])),
                    Column(
                      children: [
                        Center(child: ImageCatcher(context)),
                        Center(child: ImageCatcher2(context)),
                      ],
                    )
                  ],
                )
              : Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(child: CircularProgressIndicator())),
                )),
    );
  }

  void imageChooser(BuildContext context, int flag) {
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
                          if (flag == 0) {
                            getImage();
                          } else {
                            getImage2();
                          }
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
                          Navigator.pop(context);
                          if (flag == 0) {
                            getImagecamera();
                          } else {
                            getImagecamera2();
                          }
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => CameraConts()));
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
  Widget ImageCatcher(BuildContext contex) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 3.5,
            child: (_image == null)
                ? InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      imageChooser(context, 0);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DottedBorder(
                          color: const Color.fromARGB(255, 78, 199, 30),
                          strokeWidth: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.plus),
                              ],
                            ),
                          ),
                        )),
                  )
                : Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Image.file(
                            File(_image!.path),
                          )),
                      Positioned(
                        right: 20,
                        top: 0,
                        child: Container(
                          color: Color.fromARGB(255, 219, 218, 218),
                          width: 40,
                          height: 40,
                          child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _image = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ))),
                        ),
                      )
                    ],
                  )));
  }

  @override
  Widget ImageCatcher2(BuildContext contex) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: MediaQuery.of(context).size.height / 3.5,
            child: (_image2 == null)
                ? InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      imageChooser(context, 1);
                    },
                    child: Container(
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width - 50,
                        child: DottedBorder(
                          color: const Color.fromARGB(255, 78, 199, 30),
                          strokeWidth: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.plus),
                              ],
                            ),
                          ),
                        )),
                  )
                : Stack(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width - 50,
                          child: Image.file(
                            File(_image2!.path),
                          )),
                      Positioned(
                        right: 20,
                        top: 0,
                        child: Container(
                          color: Color.fromARGB(255, 219, 218, 218),
                          width: 40,
                          height: 40,
                          child: Center(
                              child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _image2 = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ))),
                        ),
                      )
                    ],
                  )));
  }
}
