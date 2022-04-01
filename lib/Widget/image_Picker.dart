import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AuthImagePicker extends StatefulWidget {
  AuthImagePicker(this.imgUrl, this.updateScreen, this._imageFn);
  final void Function(File image) _imageFn;
  final bool updateScreen;
  final String imgUrl;
  @override
  _AuthImagePickerState createState() =>
      _AuthImagePickerState(imgUrl, updateScreen);
}

class _AuthImagePickerState extends State<AuthImagePicker> {
  File? selectedImage;
  final bool updateScreen;
  final String imgUrl;
  _AuthImagePickerState(this.imgUrl, this.updateScreen);
  void _pickImage({required bool iscamera}) async {
    final _pickedImage = await ImagePicker.platform.pickImage(
      source: iscamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 50,
    );
    setState(() {
      selectedImage = File(_pickedImage!.path);
    });
    widget._imageFn(selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                child: Container(
                  height: MediaQuery.of(context).size.width / 2 - 10,
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  color: Colors.white,
                  child: selectedImage == null
                      // ? Image.network(
                      //     'https://images.unsplash.com/photo-1529253355930-ddbe423a2ac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bXVtYmFpfGVufDB8fDB8fA%3D%3D&w=1000&q=80',
                      //     fit: BoxFit.cover,
                      //   )
                      ? Center(
                          // child: Text("No Image Selected"),
                          child: updateScreen
                              ? Image.network(imgUrl)
                              : Text("No Image Selected"),
                        )
                      : Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton.icon(
                        onPressed: () => _pickImage(iscamera: true),
                        icon: Icon(Icons.camera),
                        label: Text('Use Camera')),
                    FlatButton.icon(
                        onPressed: () => _pickImage(iscamera: false),
                        icon: Icon(Icons.image),
                        label: Text('Use Gallery')),
                    FlatButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedImage = null;
                          });
                        },
                        icon: Icon(Icons.clear),
                        label: Text('Clear Image'))
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
