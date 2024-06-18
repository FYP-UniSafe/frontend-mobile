import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import '../../../Models/police_post.dart';
import '../../../Models/report_location.dart';
import '../../../Providers/locationProvider.dart';
import 'custom_police_marker.dart';
import 'custom_report_marker.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  static const LatLng _initialPosition =
      LatLng(-6.777016562561085, 39.20485746524962);
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    locationProvider.fetchReportLocations();
    locationProvider.fetchPolicePosts();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    final bool showReports = locationProvider.showReports;

    Future<Set<Marker>> _buildHeatmapMarkers(
        LocationProvider locationProvider) async {
      Set<Marker> heatmapMarkers = {};

      await Future.wait(locationProvider.reportLocations.map((report) async {
        if (report.cases > 0) {
          double radius = report.cases.toDouble() * 100;
          final Uint8List markerIcon =
              await createCustomMarkerBitmapWithReportCount(
                  report.cases.toString(), radius);

          heatmapMarkers.add(
            Marker(
              markerId: MarkerId(report.name),
              position: LatLng(report.latitude, report.longitude),
              icon: BitmapDescriptor.fromBytes(markerIcon),
              infoWindow: InfoWindow(
                title: report.name,
                snippet:
                    '${report.cases} ${report.cases == 1 ? "case" : "cases"}',
              ),
            ),
          );
        }
      }).toList());

      // for (ReportLocation report in locationProvider.reportLocations) {
      //   if (report.cases > 0) {
      //     double radius = report.cases.toDouble() * 100;
      //     final Uint8List markerIcon =
      //         await createCustomMarkerBitmapWithReportCount(
      //             report.cases.toString(), radius);
      //
      //     heatmapMarkers.add(
      //       Marker(
      //         markerId: MarkerId(report.name),
      //         position: LatLng(report.latitude, report.longitude),
      //         icon: BitmapDescriptor.fromBytes(markerIcon),
      //         infoWindow: InfoWindow(
      //           title: report.name,
      //           snippet:
      //               '${report.cases} ${report.cases == 1 ? "case" : "cases"}',
      //         ),
      //       ),
      //     );
      //   }
      // }

      return heatmapMarkers;
    }

    Future<Set<Marker>> _buildPoliceMarkers(
        LocationProvider locationProvider) async {
      Set<Marker> markers = {};

      await Future.wait(locationProvider.policePosts.map((post) async {
        final Uint8List markerIcon =
            await createCustomMarkerBitmapWithText(post.name);
        markers.add(
          Marker(
            markerId: MarkerId(post.name),
            position: LatLng(post.latitude, post.longitude),
            icon: BitmapDescriptor.fromBytes(markerIcon),
          ),
        );
      }).toList());

      // for (PolicePost post in locationProvider.policePosts) {
      //   final Uint8List markerIcon =
      //       await createCustomMarkerBitmapWithText(post.name);
      //   markers.add(
      //     Marker(
      //       markerId: MarkerId(post.name),
      //       position: LatLng(post.latitude, post.longitude),
      //       icon: BitmapDescriptor.fromBytes(markerIcon),
      //     ),
      //   );
      // }

      return markers;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Safety Map',
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            FutureBuilder<Set<Marker>>(
              future: showReports
                  ? _buildHeatmapMarkers(locationProvider)
                  : _buildPoliceMarkers(locationProvider),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: LoadingIndicator(
                        indicatorType: Indicator.ballPulseRise,
                        colors: [Color.fromRGBO(8, 100, 175, 1.0)],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading markers'));
                } else {
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 16,
                    ),
                    mapType: MapType.satellite,
                    markers: snapshot.data!,
                    circles: {},
                    onMapCreated: (GoogleMapController controller) {
                      try {
                        _controller.complete(controller);
                      } catch (e) {}
                    },
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: FloatingActionButton(
                      heroTag: 'btn 1',
                      onPressed: () {
                        locationProvider.toggleMarkers(true);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      backgroundColor: showReports
                          ? Color.fromRGBO(8, 100, 175, 1.0)
                          : Color.fromRGBO(8, 100, 175, 0.5),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Reports',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Icon(
                              Icons.report,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: FloatingActionButton(
                      heroTag: 'btn 2',
                      onPressed: () {
                        locationProvider.toggleMarkers(false);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      backgroundColor: !showReports
                          ? Color.fromRGBO(8, 100, 175, 1.0)
                          : Color.fromRGBO(8, 100, 175, 0.5),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Police Posts',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                            Icon(
                              Icons.local_police,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
