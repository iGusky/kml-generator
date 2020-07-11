import 'package:flutter/material.dart';
import 'package:kml_generator/src/pages/options_page.dart';

class MainPage extends StatefulWidget {
  @override
  createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('KML File')),
        body: Column(children: <Widget>[
          Text(
            'Search Plot Number',
            style: TextStyle(fontSize: 18.0),
          ),
          TextField(decoration: InputDecoration(hintText: 'Name...'))
        ], crossAxisAlignment: CrossAxisAlignment.start),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              //I'm going to add options screen..
              final route =
                  MaterialPageRoute(builder: (context) => OptionsPage());
              Navigator.push(context, route);
            }));
  }
}
