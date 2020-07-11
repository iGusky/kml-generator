import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:gpx/gpx.dart';
import 'package:xml/xml.dart';

class DistanceManual extends StatefulWidget {
  @override
  State<DistanceManual> createState() => DistanceManualState();
}

class DistanceManualState extends State<DistanceManual> {
  GoogleMapController _mapController;

  Set<Polyline> _polylines = HashSet<Polyline>();
  List<LatLng> polyLineLatLngs = List<LatLng>();
  double _totalDistance = 0.0;
  int first, second;
  int id = 0;
  Gpx gpx = Gpx();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        initialCameraPosition:
            CameraPosition(target: LatLng(32.574411, -97.012823), zoom: 2.0),
        polylines: _polylines,
        onTap: (cordinate) {
          //_mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
          _setPolylines(cordinate);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Distance: " + _distance()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.undo),
                  iconSize: 35.0,
                  onPressed: () {
                    polyLineLatLngs.removeLast();
                    _updatePolylines();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  iconSize: 45.0,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  iconSize: 35.0,
                  onPressed: () {
                    polyLineLatLngs.clear();
                    _totalDistance = 0.0;
                    _updatePolylines();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _setPolylines(LatLng cordinate) {
    polyLineLatLngs.add(cordinate);
    print(polyLineLatLngs.length);
    _updatePolylines();
    if (polyLineLatLngs.length >= 2) {
      second = polyLineLatLngs.length - 2;

      _totalDistance += _coordinateDistance(
          cordinate.latitude,
          cordinate.longitude,
          polyLineLatLngs[second].latitude,
          polyLineLatLngs[second].longitude);
    }
  }

  void _updatePolylines() {
    setState(() {
      _polylines.add(Polyline(
          polylineId: PolylineId(id.toString()),
          points: polyLineLatLngs,
          width: 2,
          color: Colors.purple));
    });
  }

  String _distance() {
    if (_totalDistance >= 1.0) {
      return (_totalDistance.toStringAsFixed(2) + " km");
    } else {
      return ((_totalDistance * 1000).toStringAsFixed(2) + " m");
    }
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
