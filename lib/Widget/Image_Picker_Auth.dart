import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AuthImagePicker extends StatefulWidget {
  AuthImagePicker(this._imageFn);
  final void Function(File image) _imageFn;
  @override
  _AuthImagePickerState createState() => _AuthImagePickerState();
}

class _AuthImagePickerState extends State<AuthImagePicker> {
  File? profileImage;
  void _pickImage({required bool iscamera}) async {
    final _pickedImage = await ImagePicker.pickImage(
      source: iscamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      profileImage = _pickedImage;
    });
    widget._imageFn(profileImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 8,
          ),
          Text(
            'Profile picture',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Container(
                  height: 200,
                  width: 200,
                  color: Colors.white,
                  child: profileImage == null
                      // ? Image.network(
                      //     'https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVtYmFpfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      //     fit: BoxFit.cover,
                      //   )
                      ? Center(
                          // child: Text("No Image Selected"),
                          child: Image.network(
                              'https://monomousumi.com/wp-content/uploads/anonymous-user-3.png'))
                      : Image.file(
                          profileImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              // CircleAvatar(
              //     radius: 35,
              //     backgroundImage: profileImage != null
              //         ? Image.file(profileImage)
              //         : Image.network(
              //             'https://monomousumi.com/wp-content/uploads/anonymous-user-3.png')),
              Column(
                children: [
                  FlatButton.icon(
                      onPressed: () => _pickImage(iscamera: true),
                      icon: Icon(Icons.camera),
                      label: Text('Choose from camera')),
                  FlatButton.icon(
                      onPressed: () => _pickImage(iscamera: false),
                      icon: Icon(Icons.image),
                      label: Text('Choose from gallery'))
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
