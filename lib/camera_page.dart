// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController controller;

  Future<void> initializeCamera() async {
    var camera = await availableCameras();
    controller = CameraController(camera[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<File> takePicture() async {
    Directory root = await getTemporaryDirectory();
    String directoryPath = '${root.path}/Guided_Camera';
    await Directory(directoryPath).create(recursive: true);
    String filePath = '$directoryPath/${DateTime.now()}.jpg';

    try {
      await controller.takePicture(filePath);
    } catch (e) {
      return null;
    }
    return File(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: initializeCamera(),
            builder: (_, snapshot) =>
                (snapshot.connectionState == ConnectionState.done)
                    ? Stack(
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.width /
                                    controller.value.aspectRatio,
                                width: MediaQuery.of(context).size.width,
                                child: CameraPreview(controller),
                              ),
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(top: 50),
                                child: RaisedButton(
                                  onPressed: () async {
                                    if (!controller.value.isTakingPicture) {
                                      File result = await takePicture();
                                      Navigator.pop(context, result);
                                    }
                                  },
                                  shape: const CircleBorder(),
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.width /
                          //       controller.value.aspectRatio,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: Image.asset(
                          //     'assets/layer_foto.png',
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                        ],
                      )
                    : const Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        ),
                      )));
  }
}
