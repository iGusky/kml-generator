import 'package:flutter/material.dart';
import 'package:kml_generator/src/pages/distance_manual.dart';
import 'package:kml_generator/src/pages/guie_google_map_page.dart';
//import 'package:kml_generator/src/pages/map_page.dart';

class OptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _options(context),
      ),
    );
  }
}

List<Widget> _options(BuildContext context) {
  return [
    //DISTANCE
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.place), Text(' Distance')],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {
            final route =
                MaterialPageRoute(builder: (context) => DistanceManual());
            Navigator.push(context, route);
          },
          child: Text('Manual'),
        ),
        RaisedButton(
          onPressed: () {
            final route = MaterialPageRoute(builder: (context) => MapSample());
            Navigator.push(context, route);
          },
          child: Text('GPS'),
        )
      ],
    ),
    Divider(),

    //AREA
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.category), Text(' Area')],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          child: Text('Manual'),
        ),
        RaisedButton(
          onPressed: () {},
          child: Text('GPS'),
        )
      ],
    ),
    Divider(),

    //POI
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.my_location), Text(' POI')],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          child: Text('Manual'),
        ),
        RaisedButton(
          onPressed: () {},
          child: Text('GPS'),
        )
      ],
    ),
    Divider(),

    //CIRCLE
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[Icon(Icons.radio_button_unchecked), Text(' Circle')],
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          onPressed: () {},
          child: Text('Manual'),
        ),
      ],
    ),
    Divider(),
  ];
}
