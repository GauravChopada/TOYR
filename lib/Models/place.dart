// import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class place {
  final String id;
  final String name;
  final String imgUrl;
  final LatLng pos;
  final String city;

  place(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.pos,
      required this.city});
}
