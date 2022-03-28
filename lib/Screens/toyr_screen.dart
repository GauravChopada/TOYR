// import 'dart:html';
import 'dart:ui';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toyr2/Screens/home_page.dart';
import 'package:toyr2/Screens/memory_Screen.dart';
import 'package:toyr2/Screens/update_Package.dart';
import '../Widget/place_Widget.dart';
import '../Models/image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Models/place.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class toyrScreen extends StatefulWidget {
  static const Routename = '/toyrScreen';

  @override
  State<toyrScreen> createState() => _toyrScreenState();
}

class _toyrScreenState extends State<toyrScreen> {
  List<String> listOfMemories = new List<String>.empty(growable: true);
  bool firstTimeLoaded = true;
  bool _isLoading = false;
  var packageId;

  void _pickImage() async {
    setState(() {
      _isLoading = true;
    });
    final _pickedImage = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    var ref = FirebaseStorage.instance
        .ref()
        .child('packages/' + packageId + '/memories/')
        .child(DateTime.now().toString() + '.jpg');
    print("you are at 1");
    print(packageId);
    print("you are at 2");
    print(packageId);
    await ref.putFile(_pickedImage).onComplete;

    var url = await ref.getDownloadURL();
    listOfMemories.add(url);
    await Firestore.instance
        .collection('packages')
        .document(packageId)
        .update({'memories': FieldValue.arrayUnion(listOfMemories)});
    
    print("you are at 3");
    print(packageId);
    setState(() {
      // listOfMemories.add(url);
      _isLoading = false;
    });
    print("you are at 4");
    print(packageId);
    print(listOfMemories);
    // setState(() {
    //   profileImage = _pickedImage;
    // });
    // widget._imageFn(profileImage!);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    packageId = arguments['id'];
    final _pageController = PageController();
    final DocumentReference _productRef =
        FirebaseFirestore.instance.doc("packages/" + packageId);
    File? profileImage;

    // final List<place> places = [
    //   place(
    //       id: "p1",
    //       name: "Iskcon Temple",
    //       imgUrl:
    //           "https://lh5.googleusercontent.com/p/AF1QipMz9P5BrDQATamw27O9h08B9yt0l71m3v4IWzwj=w1080-k-no"),
    //   place(
    //       id: "p2",
    //       name: "Gopi talav",
    //       imgUrl:
    //           "http://touristinformationcenter.net/wp-content/uploads/2021/09/gopi-4.jpg"),
    //   place(
    //       id: "p3",
    //       name: "Dumas",
    //       imgUrl:
    //           "https://i.pinimg.com/736x/fe/8c/4b/fe8c4b4f17d110af461affb6f880f00a.jpg"),
    //   place(
    //       id: "p4",
    //       name: "Woop",
    //       imgUrl:
    //           "https://pcbodiwala.com/storage/work_experience/5fc5dc150256a1606802453.jpeg"),
    //   place(
    //       id: "p5",
    //       name: "Amazia Water Park",
    //       imgUrl:
    //           "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/eb/f6/9b/wave-pool.jpg?w=1200&h=1200&s=1")
    // ];
    // final imgUrl =
    //     // "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg";
    //     "https://c0.wallpaperflare.com/preview/403/5/230/bridge-water-building-waterfront.jpg";
    // // "https://w0.peakpx.com/wallpaper/445/806/HD-wallpaper-surat-city-ab.jpg";
    return Scaffold(
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       expandedHeight: 300,
      //       pinned: true,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Container(

      //           child: BackdropFilter(
      //             child: Text("Surat"),
      //             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      //           ),
      //         ),
      //         background: Image.network(
      //           imgUrl,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //         delegate: SliverChildListDelegate([
      //       SizedBox(
      //         height: 2000,
      //       )
      //     ]))
      //   ],
      // ),
      body: FutureBuilder<DocumentSnapshot>(
          future: _productRef.get(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("loading..."),
              );
            }
            final document = snapshot.data;
            // print(document[0].get('createdAt'));
            Timestamp createdAt = document?.get('createdAt');
            String packageName = document?.get('packageName');
            String imgUrl = document?.get('imgUrl');
            String city = document?.get('city');
            // print(city);
            DateTime date = createdAt.toDate();
            // print(document[0].get('places'));
            final placeArray = document?.get('places');
            final memoryArray = document?.get('memories') as List<dynamic>;
            if (firstTimeLoaded) {
              memoryArray.forEach(
                  ((element) => listOfMemories.add(element.toString())));
              firstTimeLoaded = false;
            }
            // memoriesArray
            // print(placeArray);
            return Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Container(
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                height: 380,
                                width: double.infinity,
                                child: Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                // top: 250,
                                bottom: 50,
                                left: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.black26,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(packageName,
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 50,
                                                  color: Colors.white)),
                                          Text(
                                            "Created At: " +
                                                date.day.toString() +
                                                "/" +
                                                date.month.toString() +
                                                "/" +
                                                date.year.toString(),
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                    ),
                                  ),
                                )),
                            Positioned(
                                // top: 250,
                                bottom: 0,
                                // left: 15,
                                child: Container(
                                  // width: double.infinity,
                                  // color: Colors.white,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "                                                                                                                                                              ",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                )),
                            Positioned(
                                top: 10,
                                left: 10,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                        )))),
                            // Positioned(
                            //     top: 10,
                            //     // bottom: 10,
                            //     child: Container(
                            //       // child: Text(""),
                            //       height: 20,
                            //       width: double.infinity,
                            //       decoration: BoxDecoration(
                            //           color: Colors.red,
                            //           borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(15),
                            //               topRight: Radius.circular(15))),
                            //     )),
                            Positioned(
                                top: 10,
                                left: 14,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      // Navigator.of(context)
                                      //     .pushNamed(HomeScreen.Routename);
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      // Container(
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: Colors.black26,
                      //     ),
                      //     margin: EdgeInsets.only(top: 2, left: 10, right: 10),
                      //     padding: EdgeInsets.all(8),
                      //     height: MediaQuery.of(context).size.height * 0.21,
                      //     // decoration: BoxDecoration(color: Colors.grey[200]),
                      //     child: GridView(
                      //         physics: BouncingScrollPhysics(),
                      //         gridDelegate:
                      //             const SliverGridDelegateWithFixedCrossAxisCount(
                      //                 crossAxisCount: 2,
                      //                 childAspectRatio: 2.5,
                      //                 crossAxisSpacing: 10,
                      //                 mainAxisSpacing: 10),
                      //         children: [
                      //           Container(
                      //             alignment: Alignment.center,
                      //             // height: 100,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 color: Colors.grey[200]),
                      //             child: ListTile(
                      //               leading: Icon(Icons.add),
                      //               title: Text("Create Package"),
                      //             ),
                      //           ),
                      //           Container(
                      //             // height: 200,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 color: Colors.grey[200]),
                      //             child: ListTile(
                      //               leading: Icon(Icons.add),
                      //               title: Text("Create Package"),
                      //             ),
                      //           ),
                      //           Container(
                      //             // height: 80,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 color: Colors.grey[200]),
                      //             child: ListTile(
                      //               leading: Icon(Icons.add),
                      //               title: Text("Create Package"),
                      //             ),
                      //           ),
                      //           Container(
                      //             // height: 80,
                      //             decoration: BoxDecoration(
                      //                 borderRadius: BorderRadius.circular(15),
                      //                 color: Colors.grey[200]),
                      //             child: ListTile(
                      //               leading: Icon(Icons.add),
                      //               title: Text("Create Package"),
                      //             ),
                      //           )
                      //         ])),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Quick Functions",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3, color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.white,
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        // Icons.location_on,
                                        size: 55,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.grey[300],
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  child: Text(
                                    "View Map",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 55,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey[300],
                                        ),
                                        child: Icon(
                                          Icons.add_a_photo,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  child: Text(
                                    "add memories",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        updatePackageScreen.Routename,
                                        arguments: {
                                          'packageName': packageName,
                                          'imgUrl': imgUrl,
                                          'placeArray': placeArray,
                                          'city': city,
                                          'id': document!.id
                                        });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.location_on,
                                          size: 55,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey[300],
                                        ),
                                        child: Icon(
                                          Icons.update_sharp,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  child: Text(
                                    "Update",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: Text('Delete'),
                                            content: Text(
                                                'Are you sure you want to delete this package ?'),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () async {
                                                    await Firestore.instance
                                                        .collection('packages')
                                                        .document(document!.id)
                                                        .delete();
                                                    Navigator.of(context)
                                                        .pushNamed('/');
                                                  },
                                                  child: Text('Delete')),
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text('Cancel'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 55,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: Colors.grey[300],
                                        ),
                                        child: Icon(
                                          Icons.delete_forever,
                                          size: 50,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Container(
                                  child: Text(
                                    "Delete",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Divider(
                            color: Colors.black45,
                            thickness: 1,
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Places",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        // height: MediaQuery.of(context).size.height * 0.565 < 395
                        //     ? MediaQuery.of(context).size.height * 0.5
                        //     : 390,
                        height: 230,
                        // width: MediaQuery.of(context).size.width,
                        // width: 400,
                        child: PageView.builder(
                          itemBuilder: (ctx, i) => Container(
                            // width: 10,
                            // child: PlaceWidget(
                            //     placeName: places[i].name,
                            //     city: "Surat",
                            //     imgUrl: places[i].imgUrl),
                            child: PlaceWidget(
                              id: placeArray![i],
                            ),
                          ),

                          itemCount: placeArray!.length,
                          controller: _pageController,
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          clipBehavior: Clip.hardEdge,
                          // padEnds: false,
                          // allowImplicitScrolling: true,
                        ),
                      ),
                      Center(
                        child: Container(
                          // padding: EdgeInsets.only(left: 20),
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: placeArray.length,
                            effect: ExpandingDotsEffect(
                                activeDotColor: Colors.black,
                                dotHeight: 4.8,
                                dotWidth: 6),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15, bottom: 20),
                        child: Text(
                          "Memories",
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            // boxShadow: [
                            //background color of box
                            //   BoxShadow(
                            //     color: Colors.black,
                            //     blurRadius: 15.0, // soften the shadow
                            //     spreadRadius: 3.0, //extend the shadow
                            //     offset: Offset(
                            //       0, // Move to right 10  horizontally
                            //       15.0, // Move to bottom 10 Vertically
                            //     ),
                            //   )
                            // ],
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                        width: MediaQuery.of(context).size.width,
                        // height: 630,
                        height: listOfMemories.length <= 2 ? 220 : 420,
                        child: listOfMemories.isEmpty
                            ? Center(
                                child: Text(
                                  "No Memories Added Yet!!!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: listOfMemories.length < 4
                                    ? listOfMemories.length
                                    : 4,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    // decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(15),
                                    // border: Border.all(width: 2)),
                                    // boxShadow: [
                                    //   new BoxShadow(
                                    //     color: Colors.black,
                                    //     blurRadius: 20.0,
                                    //   ),
                                    // ]),
                                    // height: 200,

                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        child: Image.network(
                                          listOfMemories[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                      ),
                      if (listOfMemories.isNotEmpty)
                        Container(
                          color: Colors.grey[300],
                          child: TextButton(
                              child: Text(
                                "View all",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    memoryScreen.Routename,
                                    arguments: {'memories': listOfMemories});
                              }),
                        ),
                      // Container(child: StaggeredGrid.count(crossAxisCount: crossAxisCount),),
                      Container(
                        height: 50,
                        color: Colors.grey[300],
                      )
                    ],
                  ),
                ),
                if (_isLoading == true)
                  Positioned(
                      child: Center(
                    child: Container(
                      // padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Uploading...",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      height: 150,
                      width: 150,
                    ),
                  ))
              ],
            );
          }),
    );
  }
}
