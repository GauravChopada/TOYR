import 'package:flutter/material.dart';

class viewOnMap extends StatefulWidget {
  const viewOnMap({Key? key}) : super(key: key);
  static const Routename = './viewOnMap';

  @override
  State<viewOnMap> createState() => _viewOnMapState();
}

class _viewOnMapState extends State<viewOnMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('View On Map')),
    );
  }
}
