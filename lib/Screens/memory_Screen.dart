import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../Models/image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class memoryScreen extends StatelessWidget {
  const memoryScreen({Key? key}) : super(key: key);
  static const Routename = './memoryScreen';
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final listOfMemories = arguments['memories'] as List<dynamic>;
    print(listOfMemories);

    return Scaffold(
      body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.13,
                // color: Colors.black,
                padding: const EdgeInsets.only(left: 15, top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            color: Colors.white,
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.arrow_back_ios_new)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Memories',
                            style: GoogleFonts.lato(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 3),
                padding: EdgeInsets.symmetric(horizontal: 8),
                height: MediaQuery.of(context).size.height * 0.85,
                child: listOfMemories.isEmpty
                    ? Center(
                        child: Text(
                          "No Memories Added Yet!!!",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: 10, left: 5, bottom: 10),
                            height: MediaQuery.of(context).size.height *
                                0.85 *
                                0.02,
                          ),
                          Container(
                            padding: EdgeInsets.all(0),
                            height: MediaQuery.of(context).size.height *
                                0.85 *
                                0.97,
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemCount: listOfMemories.length,
                                itemBuilder: (ctx, index) {
                                  return GestureDetector(
                                    onTap: () => showImageViewer(
                                        context,
                                        Image.network(listOfMemories[index])
                                            .image),
                                    // onLongPressEnd: (_) =>
                                    //     Navigator.of(context).pop(),
                                    onLongPress: () => showDialog(
                                        context: context,
                                        builder: (ctx) => Center(
                                                child: Material(
                                              type: MaterialType.transparency,
                                              child: Container(
                                                height: 300,
                                                width: 300,
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.white),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        child:
                                                            InteractiveViewer(
                                                          child: Image.network(
                                                              listOfMemories[
                                                                  index]),
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Spacer(),
                                                        InkWell(
                                                          onTap: () {
                                                            FirebaseStorage
                                                                .instance
                                                                .refFromURL(
                                                                    listOfMemories[
                                                                        index])
                                                                .delete();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 10,
                                                                    bottom: 10),
                                                            child: Row(
                                                                children: const [
                                                                  Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                  Text(
                                                                    'delete',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  )
                                                                ]),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ))),
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Container(
                                          child: Image.network(
                                            listOfMemories[index],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
              )
            ],
          )),
    );
  }
}
