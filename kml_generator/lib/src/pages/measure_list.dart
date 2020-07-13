import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:xml/xml.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class MeasureList extends StatefulWidget {
  MeasureList({Key key}) : super(key: key);
  @override
  _MeasureListState createState() => _MeasureListState();
}

class _MeasureListState extends State<MeasureList> {
  List<Widget> listAux = [];
  void loadFiles(bool flag) async {
    if (flag) {
      final Directory directory = await getExternalStorageDirectory();

      String fileName;
      String direction;
      String document;
      var description;
      String des;
      XmlDocument xml;
      int totalFiles = directory.listSync().length;

      //print(totalFiles.toString());
      for (int i = 0; i < totalFiles; i++) {
        //print(i);
        var dir = directory.listSync()[i];
        //print("Route" + dir.path);
        // File fileAux = File(dir.path);
        // document = fileAux.readAsStringSync();
        // xml = parse(document);
        // description = xml.findAllElements('description');
        // des = description.map((node) => node.text).forEach(print);
        // print(des);

        fileName = basenameWithoutExtension(dir.path);
        direction = dirname(dir.path);
        //description = fileAux.find;

        _updateState(ListTile(
          title: Text(fileName),
          leading: Icon(Icons.map),
          trailing: IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final ByteData bytes = await rootBundle.load(dir.path);
              await Share.file('esys image', 'esys.png',
                  bytes.buffer.asUint8List(), 'image/png',
                  text: 'My optional text.');
            },
          ),
        ));
      }
    }
  }

  void _updateState(ListTile listTile) {
    setState(() {
      listAux.add(listTile);
    });
  }

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    loadFiles(flag);
    flag = false;
    return Scaffold(
      appBar: AppBar(
        title: Text("Measure List"),
      ),
      body: ListView.builder(
        itemCount: listAux.length,
        itemBuilder: (context, index) {
          return listAux[index];
        },
      ),
    );
  }

  // Future<void> shareFile(String title, String path) async {
  //   await FlutterShare.shareFile(title: title, filePath: path);
  // }
}
