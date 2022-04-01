import 'package:cloud_firestore/cloud_firestore.dart';

class TOYR {
  final String toyrId;
  final String name;
  final String imgUrl;
  final Timestamp createdAt;
  final int views;

  TOYR(
      {required this.toyrId,
      required this.name,
      required this.imgUrl,
      required this.createdAt,
      required this.views});
}
