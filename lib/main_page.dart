// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_take_picture/location_page.dart';
import 'dart:io';

import 'camera_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  File imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Test'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 10),
              height: 450,
              width: 300,
              color: Colors.grey[200],
              child: (imageFile != null)
                  ? Image.file(imageFile)
                  : const SizedBox(),
            ),
            RaisedButton(
              child: const Text('Take Picture'),
              onPressed: () async {
                imageFile = await Navigator.push<File>(context,
                    MaterialPageRoute(builder: (_) => const CameraPage()));
                setState(() {});
              },
            ),
            const SizedBox(
              height: 5,
            ),
            RaisedButton(
              child: const Text('User Location'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LocationPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
