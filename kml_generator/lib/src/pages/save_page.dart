import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xml/xml.dart' as xml;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:toast/toast.dart';

class SavePage extends StatefulWidget {
  final List<LatLng> points;
  final double totalDistance;
  SavePage(List<LatLng> this.points, double this.totalDistance);

  @override
  _SavePageState createState() => _SavePageState(points, totalDistance);
}

class _SavePageState extends State<SavePage> {
  final List<LatLng> points;
  final double totalDistance;
  final myControllerName = TextEditingController();
  final myControllerComment = TextEditingController();
  String fileName;
  String fileComment;

  //Constructor
  _SavePageState(List<LatLng> this.points, double this.totalDistance);
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myControllerName.dispose();
    myControllerComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Save as.."),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                try {
                  _saveFile();
                  Toast.show("File saved", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  Toast.show("Error saving", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                }
              })
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Measure Name",
              style: TextStyle(fontSize: 17),
            ),
            Container(height: 10),
            TextField(
              controller: myControllerName,
              decoration: InputDecoration(border: OutlineInputBorder()),
              onChanged: (String) {
                fileName = myControllerName.text;
              },
            ),
            Container(height: 15),
            Text(
              "Comment",
              style: TextStyle(fontSize: 17),
            ),
            Container(height: 10),
            TextField(
              controller: myControllerComment,
              decoration: InputDecoration(border: OutlineInputBorder()),
              onChanged: (String) {
                fileComment = myControllerComment.text;
              },
            )
          ],
        ),
      ),
    );
  }

  void _saveFile() async {
    var builder = new xml.XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('kml', nest: () {
      builder.attribute('xmlns', 'http://www.opengis.net/kml/2.2');
      builder.element('Document', nest: () {
        builder.element('name', nest: () {
          builder.text(fileName);
        });
        builder.element('description', nest: () {
          builder.text(fileComment);
        });
        builder.element('Style', nest: () {
          builder.attribute('id', 'redline');
          builder.element('LineStyle', nest: () {
            builder.element('color', nest: () {
              builder.text("ff0000ff");
            });
            builder.element('width', nest: () {
              builder.text("6");
            });
          });
          builder.element('PolyLine', nest: () {
            builder.element('color', nest: () {
              builder.text("ff0000ff");
            });
          });
        });

        builder.element('Placemark', nest: () {
          builder.element('name', nest: () {
            builder.text('mapPolyLines');
          });
          builder.element('description', nest: () {
            builder.text("A Road from: ${fileName}");
          });
          builder.element('styeUrl', nest: () {
            builder.text("#redline");
          });
          builder.element('LineString', nest: () {
            builder.element('etrudle', nest: () {
              builder.text('1');
            });
            builder.element('tessellate', nest: () {
              builder.text('1');
            });
            builder.element('coordinates', nest: () {
              builder.text(getPoints());
            });
          });
        });
      });
    });

    final Directory directory = await getExternalStorageDirectory();
    final File file = File('${directory.path}/${fileName}.kml');
    var kml = builder.build();
    await file.writeAsString(kml.toXmlString(pretty: true, indent: '\t'));
    print(directory.listSync());
  }

  String getPoints() {
    String coordinates = "";
    for (int i = 0; i < points.length; i++) {
      coordinates += "${points[i].longitude},${points[i].latitude},0\n";
    }
    return coordinates;
  }
}
