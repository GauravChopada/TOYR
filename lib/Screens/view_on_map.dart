import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_routes/google_maps_routes.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Models/directions_model.dart';
import '../Models/directions_repository.dart';
import '../Models/place.dart';

class viewOnMap extends StatefulWidget {
  const viewOnMap({Key? key}) : super(key: key);
  static const Routename = './viewOnMap';

  @override
  State<viewOnMap> createState() => _viewOnMapState();
}

class _viewOnMapState extends State<viewOnMap> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  late GoogleMapController controller;

  List<LatLng> latlngSegment1 = List<LatLng>.empty(growable: true);
  static LatLng _lat1 = LatLng(21.08550199445179, 72.70920026024869);
  static LatLng _lat2 = LatLng(21.188843384298124, 72.82977588559417);
  static LatLng _lat3 = LatLng(21.11963199889238, 72.73610719750813);
  static LatLng _lat4 = LatLng(21.149423900440055, 72.75761512430374);

  LatLng _lastMapPosition = _lat1;

  List<place> _places = List<place>.empty(growable: true);
  final List<place> places = [
    place(
        id: "p1",
        name: "Dumas",
        city: 'Surat',
        pos: LatLng(21.08550199445179, 72.70920026024869),
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipMz9P5BrDQATamw27O9h08B9yt0l71m3v4IWzwj=w1080-k-no"),
    place(
        id: "p2",
        name: "Gopi talav",
        city: 'Surat',
        pos: LatLng(21.188843384298124, 72.82977588559417),
        imgUrl:
            "http://touristinformationcenter.net/wp-content/uploads/2021/09/gopi-4.jpg"),
    place(
        id: "p3",
        name: "Woop",
        city: 'Surat',
        pos: LatLng(21.11963199889238, 72.73610719750813),
        imgUrl:
            "https://i.pinimg.com/736x/fe/8c/4b/fe8c4b4f17d110af461affb6f880f00a.jpg"),
    place(
        id: "p4",
        name: "VR Mall",
        city: 'Surat',
        pos: LatLng(21.149423900440055, 72.75761512430374),
        imgUrl:
            "https://pcbodiwala.com/storage/work_experience/5fc5dc150256a1606802453.jpeg"),
    // place(
    //     id: "p5",
    //     name: "Amazia Water Park",
    //     imgUrl:
    //         "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/eb/f6/9b/wave-pool.jpg?w=1200&h=1200&s=1")
  ];

  @override
  void initState() {
    super.initState();
    //line segment 1
    // latlngSegment1.add(_lat1);
    // latlngSegment1.add(_lat2);
    // latlngSegment1.add(_lat3);
    // latlngSegment1.add(_lat4);
    // latlngSegment1.add(LatLng(21.08550199445179, 72.70920026024869));
    // print(latlngSegment1);
  }

  List<int> data = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1];

  static Future<void> openMap(double lat, double long) async {
    String gMapUrl =
        "https://www.google.com/maps/search/?api=1&query=$lat,$long";

    await launch(gMapUrl);
    // if (await canLaunch(gMapUrl)) {
    // } else {
    //   throw 'Could not open the Map';
    // }
  }

  Widget _buildItemList(BuildContext context, int index) {
    return Container(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 2.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                ),
              ],
              color: Colors.white,
            ),
            width: 200,
            height: 280,
            // child: Center(
            //   child: Text(
            //     '${places[index].name}',
            //     style: const TextStyle(fontSize: 20.0, color: Colors.black),
            //   ),
            // ),
            child: Column(children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.network(
                        _places[index].imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 141, 90, 231),
                                  Color.fromARGB(255, 55, 5, 141),
                                  // Color.fromARGB(255, 141, 90, 231),
                                ]),
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(100)),
                        child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.map_outlined),
                            onPressed: () async {
                              openMap(_places[index].pos.latitude,
                                  _places[index].pos.longitude);
                            }),
                      ))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 80,
                child: Center(
                  child: Text(
                    _places[index].name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  bool _isLoading = true;
  bool _isFirstTimeLoaded = true;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final _listOfPlaces = arguments['listOfPlaces'] as List<dynamic>;

    if (_isFirstTimeLoaded) {
      setState(() {
        _listOfPlaces.forEach(
          (element) async {
            final document = await FirebaseFirestore.instance
                .collection('places')
                .doc(element)
                .get();

            final GeoPoint geoPoint = document.get('location');
            final LatLng _pos =
                new LatLng(geoPoint.latitude, geoPoint.longitude);

            _places.add(new place(
                id: document.id,
                name: document.get('placeName'),
                imgUrl: document.get('imgUrl'),
                city: document.get('city'),
                pos: _pos));
            if (_places.length == _listOfPlaces.length) {
              setState(() {
                _isFirstTimeLoaded = false;
                _isLoading = false;
              });
            }
          },
        );
      });
    }

    if (_isLoading)
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    return FutureBuilder(
        // future: .,
        builder: (context, snapshot) {
      return Scaffold(
        body: Container(
          child: Stack(
            children: [
              Positioned(
                // top: 0,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        //that needs a list<Polyline>
                        polylines: _polyline,
                        markers: _markers,
                        onMapCreated: _onMapCreated,
                        zoomControlsEnabled: false,
                        initialCameraPosition: CameraPosition(
                          target: _places[0].pos,
                          zoom: 14.0,
                        ),
                        mapType: MapType.normal,
                        // onLongPress: (position) {
                        //   print(position);
                        // },
                      ),
                    ),
                    // Expanded(
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height * 0.4,
                    //   ),
                    // )
                  ],
                ),
              ),
              Positioned(
                  child: ClipRRect(
                // borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    color: Colors.black26,
                    child: Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Colors.white,
                              )),
                          Text(
                            'View On Map',
                            style: GoogleFonts.lato(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                ),
              )),
              Positioned(
                right: 10,
                top: 40,
                child: IconButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      controller.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: _places[0].pos,
                          zoom: 11.0,
                          tilt: 50.0,
                        ),
                      ));
                    },
                    icon: Icon(
                      Icons.replay_circle_filled_rounded,
                      color: Colors.white,
                      size: 40,
                    )),
              ),
              Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.25,
                          color: Colors.black26,
                        )),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: Column(
                    children: [
                      Expanded(
                          child: ScrollSnapList(
                        scrollPhysics: BouncingScrollPhysics(),
                        onItemFocus: (i) {
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: _places[i].pos,
                                zoom: 14.5,
                                tilt: 50.0,
                              ),
                            ),
                          );
                          // print();
                        },
                        itemBuilder: _buildItemList,
                        itemSize: 200,
                        dynamicItemSize: true,
                        // onReachEnd: () {
                        //   print('Done!');
                        // },
                        itemCount: _places.length,
                      )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      var index = 1;
      _places.forEach((element) {
        _markers.add(Marker(
          markerId: MarkerId(element.id),
          position: element.pos,
          // icon: BitmapDescriptor.defaultMarkerWithHue(
          //     BitmapDescriptor.defaultMarker),
          infoWindow: InfoWindow(
            title: index.toString() + '. ' + element.name,
            snippet: element.city,
          ),
        ));
        index++;
        latlngSegment1.add(element.pos);
      });
      _lastMapPosition = _places[0].pos;
      _polyline.add(Polyline(
          polylineId: PolylineId('line1'),
          visible: true,
          //latlng is List<LatLng>
          points: latlngSegment1,
          width: 5,
          color: Color.fromARGB(255, 145, 95, 232),
          startCap: Cap.roundCap,
          geodesic: true,
          endCap: Cap.roundCap
          // patterns: [PatternItem.dash(10), PatternItem.gap(10)],
          ));
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _places[0].pos,
          zoom: 11.0,
          tilt: 50.0,
        ),
      ));
    });
  }
}
