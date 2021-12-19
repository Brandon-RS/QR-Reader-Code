import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_reader/providers/db_provider.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition startPoint = CameraPosition(
      target: scan.getLatLng(),
      zoom: 15,
    );

    // Markers
    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
        markerId: const MarkerId('geo-location'),
        position: scan.getLatLng(),
      ),
    );

    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Map'),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         final GoogleMapController controller = await _controller.future;
      //         controller.animateCamera(
      //           // CameraUpdate.newCameraPosition(startPoint),
      //           CameraUpdate.newCameraPosition(
      //             CameraPosition(
      //               target: scan.getLatLng(),
      //               zoom: 15,
      //             ),
      //           ),
      //         );
      //       },
      //       icon: const Icon(Icons.location_on),
      //     )
      //   ],
      // ),

      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            markers: markers,
            mapType: mapType,
            initialCameraPosition: startPoint,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: padding.top,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Positioned(
            top: padding.top,
            right: 0,
            child: IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                  CameraUpdate.newCameraPosition(startPoint),
                );
              },
              icon: Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // if (mapType == MapType.normal) {
          //   mapType = MapType.satellite;
          // } else {
          //   mapType = MapType.normal;
          // }

          mapType = mapType == MapType.normal ? MapType.hybrid : MapType.normal;

          setState(() {});
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
