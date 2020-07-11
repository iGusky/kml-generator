import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:math' show cos, sqrt, asin;

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Polyline> _polylinesTwo = HashSet<Polyline>();
  List<LatLng> polyLineLatLngsTwo = List<LatLng>();
  Set<Circle> _circles = HashSet<Circle>();
  Location _location = Location();
  double _totalDistance = 0.0;
  int first, second;
  int id = 0;
  final List<Marker> markers = [];

  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _setPolygons();
    _setPolylines();
    _setCircle();
  }

  //Map creation
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    //SHOW THE ACTUAL LOCATION5
    // try {
    //   _location.onLocationChanged.listen((l) {
    //     _mapController.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(
    //           target: LatLng(l.latitude, l.longitude),
    //           zoom: 18.0,
    //         ),
    //       ),
    //     );
    //   });
    // } catch (e) {}
    //Map Creation
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(18.448652, -95.210974));
    polygonLatLongs.add(LatLng(18.448123, -95.211918));
    polygonLatLongs.add(LatLng(18.447288, -95.212133));
    polygonLatLongs.add(LatLng(18.44741, -95.210009));

    _polygons.add(Polygon(
      polygonId: PolygonId("0"),
      points: polygonLatLongs,
      strokeWidth: 1,
      strokeColor: Color.fromARGB(85, 200, 209, 121),
      fillColor: Color.fromARGB(85, 232, 222, 86),
    ));
  }

  void _setPolylinesTwo(LatLng cordinate) {
    polyLineLatLngsTwo.add(cordinate);
    print(polyLineLatLngsTwo.length);
    setState(() {
      _polylinesTwo.add(Polyline(
          polylineId: PolylineId(id.toString()),
          points: polyLineLatLngsTwo,
          width: 2,
          color: Colors.purple));
    });
    if (polyLineLatLngsTwo.length >= 2) {
      first = polyLineLatLngsTwo.length - 1;
      second = first - 1;

      _totalDistance += _coordinateDistance(
          cordinate.latitude,
          cordinate.longitude,
          polyLineLatLngsTwo[second].latitude,
          polyLineLatLngsTwo[second].longitude);
      if (_totalDistance >= 1.0) {
        print("${_totalDistance} km");
      } else {
        print("${_totalDistance * 1000} m");
      }
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

  void _setPolylines() {
    List<LatLng> polyLineLatLngs = List<LatLng>();
    polyLineLatLngs.add(LatLng(18.448387, -95.214021));
    polyLineLatLngs.add(LatLng(18.449772, -95.213978));
    polyLineLatLngs.add(LatLng(18.451298, -95.213099));
    polyLineLatLngs.add(LatLng(18.45138, -95.211082));

    _polylines.add(Polyline(
      polylineId: PolylineId("0"),
      points: polyLineLatLngs,
      width: 2,
      color: Colors.purple,
    ));
  }

  void _setCircle() {
    _circles.add(Circle(
      circleId: CircleId("0"),
      center: LatLng(18.4468, -95.213656),
      radius: 100,
      fillColor: Color.fromARGB(80, 177, 148, 227),
      strokeColor: Colors.black,
      strokeWidth: 1,
    ));
  }

  addMarker(cordinate) {
    setState(() {
      //ADD MARKERS
      // _markers
      //     .add(Marker(position: cordinate, markerId: MarkerId(id.toString())));
      // id++;
    });
  }

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
            CameraPosition(target: LatLng(18.448367, -95.212369), zoom: 15.0),
        markers: _markers,
        polygons: _polygons,
        polylines: _polylinesTwo,
        circles: _circles,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        onTap: (cordinate) {
          //_mapController.animateCamera(CameraUpdate.newLatLng(cordinate));
          _setPolylinesTwo(cordinate);
        },
      ),
    );
  }
}
