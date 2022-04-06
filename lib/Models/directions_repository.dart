import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_gmaps/.env.dart';
// import 'package:flutter_gmaps/directions_model.dart';
import 'directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      // 'https://maps.googleapis.com/maps/api/directions/json?';
      'https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood&key=AIzaSyApLrhKxsogpBftE9vYMpKm37KVHc8PvZw';

  late Dio _dio;

  // DirectionsRepository(Dio dio) : _dio = dio ?? Dio();

  // DirectionsRepository(this._dio);

  Future<Directions> getDirections(
      // required LatLng origin,
      // required LatLng destination,
      ) async {
    _dio = Dio();
    final response = await _dio.get(
      _baseUrl,
      // queryParameters: {
      //   'origin': '${origin.latitude},${origin.longitude}',
      //   'destination': '${destination.latitude},${destination.longitude}',
      //   'key': 'AIzaSyApLrhKxsogpBftE9vYMpKm37KVHc8PvZw',
      // },
    );
    print(response);
    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return Directions.fromMap(response.data);
  }
}



  //   return Scaffold(
  //     body: FutureBuilder(
  //         // future: route.drawRoute(points, 'TOYR', Colors.deepOrange,
  //         //     'AIzaSyApLrhKxsogpBftE9vYMpKm37KVHc8PvZw',
  //         // travelMode: TravelModes.driving),
  //         builder: (context, mapSnapshot) {
  //       if (mapSnapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //       if (mapSnapshot.connectionState == ConnectionState.done) {
  //         print(route.routes);
  //         print(mapSnapshot);
  //         // return Center(
  //         //   child: Text(route.routes.toString()),
  //         // );
  //         return GoogleMap(
  //             initialCameraPosition: _kGooglePlex,
  //             onMapCreated: (GoogleMapController controller) {
  //               _controller.complete(controller);
  //             },
  //             polylines: route.routes);
  //       }
  //       return Center(child: Text('Loading...'));
  //     }),
  //   );
  // }
  // Completer<GoogleMapController> _controller = Completer();

  // List<LatLng> points = [
  //   LatLng(45.82917150748776, 14.63705454546316),
  //   LatLng(45.833828635680355, 14.636544256202207),
  //   LatLng(45.851254420031296, 14.624331708344428),
  //   LatLng(45.84794984187217, 14.605434384742317)
  // ];

  // MapsRoutes route = new MapsRoutes();
  // DistanceCalculator distanceCalculator = new DistanceCalculator();
  // String googleApiKey = 'AIzaSyApLrhKxsogpBftE9vYMpKm37KVHc8PvZw';
  // String totalDistance = 'No route';

  // @override
  // Widget build(BuildContext context) {
  // route.drawRoute(points, 'TOYR', Colors.deepPurple,googleApiKey).then((value) => ,)
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         Align(
  //           alignment: Alignment.center,
  //           child: GoogleMap(
  //             zoomControlsEnabled: false,
  //             polylines: route.routes,
  //             initialCameraPosition: const CameraPosition(
  //               zoom: 15.0,
  //               target: LatLng(45.82917150748776, 14.63705454546316),
  //             ),
  //             onMapCreated: (GoogleMapController controller) {
  //               _controller.complete(controller);
  //             },
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Align(
  //             alignment: Alignment.bottomCenter,
  //             child: Container(
  //                 width: 200,
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(15.0)),
  //                 child: Align(
  //                   alignment: Alignment.center,
  //                   child:
  //                       Text(totalDistance, style: TextStyle(fontSize: 25.0)),
  //                 )),
  //           ),
  //         )
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () async {
  //         await route.drawRoute(points, 'Test routes',
  //             Color.fromRGBO(130, 78, 210, 1.0), googleApiKey,
  //             travelMode: TravelModes.walking);
  //         setState(() {
  //           totalDistance =
  //               distanceCalculator.calculateRouteDistance(points, decimals: 1);
  //         });
  //       },
  //     ),
  //   );
  // }

  // static const _initialCameraPosition = CameraPosition(
  //   target: LatLng(21.1591857, 72.7522559),
  //   zoom: 11.5,
  // );

  // late GoogleMapController _googleMapController;
  //  GoogleMapController _googleMapController = GoogleMapController.init(id, initialCameraPosition, googleMapState);
  //  Marker _origin;

  // late Directions _info;

  // @override
  // Marker _origin = Marker(
  //   markerId: const MarkerId('origin'),
  //   infoWindow: const InfoWindow(title: 'Origin'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   position: LatLng(21.1678302, 72.7814384),
  //   //   LatLng(21.7277586, 72.9686104),
  // );
  // Marker _destination = Marker(
  //   markerId: const MarkerId('origin'),
  //   infoWindow: const InfoWindow(title: 'Origin'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //   position:
  //       // LatLng(21.1591857, 72.7522559),
  //       LatLng(21.2306235, 72.9089262),
  // );
  // void initState() async {
  //   // TODO: implement initState
  //   super.initState();

  // }

  // @override
  // void dispose() {
  //   _googleMapController.dispose();
  //   super.dispose();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<Directions>(
  //       future: DirectionsRepository().getDirections(),
  //       builder: (context, mapSnapshot) {
  //         if (mapSnapshot.connectionState == ConnectionState.waiting) {
  //           return Scaffold(
  //             body: Center(child: CircularProgressIndicator()),
  //           );
  //         }

  //         if (mapSnapshot.connectionState == ConnectionState.done) {
  //           if (mapSnapshot.data == null) {
  //             return Scaffold(
  //               body: Center(child: Text('loading')),
  //             );
  //           } else {
  //             _info = mapSnapshot.data!;
  //             print(_info.totalDistance);

  // return Scaffold(
  // appBar: AppBar(
  //   centerTitle: false,
  //   title: const Text('Google Maps'),
  //   actions: [
  //     if (_origin != null)
  //       TextButton(
  //         onPressed: () => _googleMapController.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //               target: _origin.position,
  //               zoom: 14.5,
  //               tilt: 50.0,
  //             ),
  //           ),
  //         ),
  //         style: TextButton.styleFrom(
  //           primary: Colors.green,
  //           textStyle: const TextStyle(fontWeight: FontWeight.w600),
  //         ),
  //         child: const Text('ORIGIN'),
  //       ),
  //     if (_destination != null)
  //       TextButton(
  //         onPressed: () => _googleMapController.animateCamera(
  //           CameraUpdate.newCameraPosition(
  //             CameraPosition(
  //               target: _destination.position,
  //               zoom: 14.5,
  //               tilt: 50.0,
  //             ),
  //           ),
  //         ),
  //         style: TextButton.styleFrom(
  //           primary: Colors.blue,
  //           textStyle: const TextStyle(fontWeight: FontWeight.w600),
  //         ),
  //         child: const Text('DEST'),
  //       )
  //   ],
  // ),
  // body: Stack(
  //   alignment: Alignment.center,
  //   children: [
  //     GoogleMap(
  //       myLocationButtonEnabled: false,
  //       zoomControlsEnabled: false,
  //       initialCameraPosition: _initialCameraPosition,
  //       onMapCreated: (controller) =>
  //           _googleMapController = controller,
  //       markers: {_origin, _destination},
  //       polylines: {
  //         if (_info != null)
  //           Polyline(
  //             polylineId: const PolylineId('overview_polyline'),
  //             color: Colors.red,
  //             width: 5,
  //             points: _info.polylinePoints
  //                 .map((e) => LatLng(e.latitude, e.longitude))
  //                 .toList(),
  //           ),
  //       },
  // onLongPress: _addMarker,
  // ),
  // if (_info != null)
  //   Positioned(
  //     top: 20.0,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(
  //         vertical: 6.0,
  //         horizontal: 12.0,
  //       ),
  //       decoration: BoxDecoration(
  //         color: Colors.yellowAccent,
  //         borderRadius: BorderRadius.circular(20.0),
  //         boxShadow: const [
  //           BoxShadow(
  //             color: Colors.black26,
  //             offset: Offset(0, 2),
  //             blurRadius: 6.0,
  //           )
  //         ],
  //       ),
  //       child: Text(
  //         '${_info.totalDistance}, ${_info.totalDuration}',
  //         style: const TextStyle(
  //           fontSize: 18.0,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   ),
  //           ],
  //         ),
  //         floatingActionButton: FloatingActionButton(
  //           backgroundColor: Theme.of(context).primaryColor,
  //           foregroundColor: Colors.black,
  //           // onPressed: () => _googleMapController.animateCamera(
  //           //   _info != null
  //           //       ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
  //           //       : CameraUpdate.newCameraPosition(_initialCameraPosition),
  //           // ),
  //           onPressed: () async {
  //             final directions = await DirectionsRepository()
  //                 .getDirections(
  //                     origin: _origin.position,
  //                     destination: _destination.position);
  //             setState(() => _info = directions);
  //           },
  //           child: const Icon(Icons.center_focus_strong),
  //         ),
  //       );
  //     }
  //   }
  //   return Scaffold(
  //     body: Center(child: CircularProgressIndicator()),
  //   );
  // });
  // }

  // void _addMarker(LatLng pos) async {
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     // Origin is not set OR Origin/Destination are both set
  //     // Set origin
  //     setState(() {
  //       _origin = Marker(
  //         markerId: const MarkerId('origin'),
  //         infoWindow: const InfoWindow(title: 'Origin'),
  //         icon:
  //             BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  //         position: pos,
  //       );
  //       // Reset destination
  //       _destination = new Marker(markerId: MarkerId('sdds'));

  //       // Reset info
  //       // _info = new Direc
  //     });
  //   } else {
  //     // Origin is already set
  //     // Set destination
  //     setState(() {
  //       _destination = Marker(
  //         markerId: const MarkerId('destination'),
  //         infoWindow: const InfoWindow(title: 'Destination'),
  //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //         position: pos,
  //       );
  //     });

  //     // Get directions
  //     final directions = await DirectionsRepository()
  //         .getDirections(origin: _origin.position, destination: pos);
  //     setState(() => _info = directions);
  //   }
  // }
// }

//----------------

// @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<Directions>(
  //       future: DirectionsRepository().getDirections(),
  //       builder: (context, mapSnapshot) {
  //         if (mapSnapshot.connectionState == ConnectionState.waiting) {
  //           return Scaffold(
  //             body: Center(child: CircularProgressIndicator()),
  //           );
  //         }

  //         if (mapSnapshot.connectionState == ConnectionState.done) {
  //           if (mapSnapshot.data == null) {
  //             return Scaffold(
  //               body: Center(child: Text('loading')),
  //             );
  //           } else {
  //             final _info = mapSnapshot.data!;
  //             print(_info.totalDistance);
  //             return Scaffold(
  //               body: Center(child: Text('Success')),
  //             );
  //           }
  //         }

  //         return Scaffold(
  //           body: Center(child: Text('error')),
  //         );
  //       });
  // }