// import 'dart:html';
import 'dart:ui';
import 'dart:io';
// import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:toyr2/Screens/home_page.dart';
import 'package:toyr2/Screens/memory_Screen.dart';
import 'package:toyr2/Screens/update_Package.dart';
import '../Widget/place_Widget.dart';
import '../Models/image.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Models/place.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'view_on_map.dart';

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
    final _pickedImages = await ImagePicker.platform.pickMultiImage(
      imageQuality: 50,
    );
    setState(() {
      _isLoading = true;
    });
    // final List<XFile>? images = await ImagePicker.platform.pickMultiImage();
    // print('1.' + listOfMemories.toString());
    for (int i = 0; i < _pickedImages!.length; i++) {
      // print(_pickedImages[i].path);
      var _ref = await FirebaseStorage.instance
          .ref()
          .child('packages/' + packageId + '/memories/')
          .child(DateTime.now().toString() + '.jpg')
          .putFile(
            File(_pickedImages[i].path),
          );
      // .whenComplete(() {});

      // final uploadTask = ref.putFile(File(_pickedImage.path));

      var url = await _ref.ref.getDownloadURL();
      // print(url);
      // var url = await (await uploadTask).ref.getDownloadURL();

      // var url = await ref.getDownloadURL();
      listOfMemories.add(url);
    }
    // _pickedImages!.forEach((_pickedImage) async {
    // });
    // print('2.' + listOfMemories.toString());
    await FirebaseFirestore.instance
        .collection('packages')
        .doc(packageId)
        .update({'memories': FieldValue.arrayUnion(listOfMemories)});

    setState(() {
      // listOfMemories.add(url);
      _isLoading = false;
    });
  }

  bool _isFavourite = false;
  bool _isFirstTimeLoaded = true;
  bool _isFavouriteLoading = false;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    packageId = arguments['id'];
    final _pageController = PageController();
    final DocumentReference _productRef =
        FirebaseFirestore.instance.doc("packages/" + packageId);
    File? profileImage;
    if (_isFirstTimeLoaded) {
      final ffi = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      ffi.then((value) {
        final list = value.get('listOfFavourites') as List<dynamic>;

        _isFirstTimeLoaded = false;
        if (list.contains(packageId)) {
          setState(() {
            _isFavourite = true;
          });
        } else {
          setState(() {
            _isFavourite = false;
          });
        }
      });
    }
    Future<void> _toggleFavourite(Function setStateFul) async {
      // final sf = await SharedPreferences.getInstance();
      setStateFul(() {
        _isFavouriteLoading = true;
      });

      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      final listOfFavourites =
          document.get('listOfFavourites') as List<dynamic>;
      if (listOfFavourites.contains(packageId)) {
        listOfFavourites.clear();
        listOfFavourites.add(packageId);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'listOfFavourites': FieldValue.arrayRemove(listOfFavourites),
        });
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser.uid)
        //     .update({
        //   'listOfFavourites': FieldValue.arrayUnion(listOfFavourites),
        // });
        setStateFul(() {
          _isFavourite = false;
          _isFavouriteLoading = false;
        });
      } else {
        listOfFavourites.add(packageId);
        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(FirebaseAuth.instance.currentUser.uid)
        //     .update({
        //   'listOfFavourites': FieldValue.arrayUnion(new List.empty()),
        // });
        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'listOfFavourites': FieldValue.arrayUnion(listOfFavourites),
        });
        setStateFul(() {
          _isFavourite = true;
          _isFavouriteLoading = false;
        });
      }
      // final listOfFavourites = sf.getStringList('listOfFavourites');
      // if (listOfMemories.contains(packageId)) {
      //   // final index = listOfMemories.indexOf(packageId);
      //   listOfMemories.removeWhere((element) => element == packageId);
      //   _isFavourite = false;
      // } else {
      //   _isFavourite = true;
      //   listOfMemories.add(packageId);
      // }
      // sf.setStringList('listOfFavourites', listOfFavourites!);
    }

    return _isLoading
        ? Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Uploading Memories . . .',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            )),
          )
        : Scaffold(
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
                  final views = document?.get('views');
                  final memoryArray =
                      document?.get('memories') as List<dynamic>;
                  if (firstTimeLoaded) {
                    memoryArray.forEach(
                        ((element) => listOfMemories.add(element.toString())));
                    firstTimeLoaded = false;
                    FirebaseFirestore.instance
                        .collection('packages')
                        .doc(packageId)
                        .update({
                      'views': views + 1,
                    });
                  }
                  // memoriesArray
                  // print(placeArray);
                  return Container(
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
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
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
                                          "                                                                                                                                           ",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
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
                              StatefulBuilder(builder: (context, setStateFul) {
                                return _isFavouriteLoading
                                    ? Positioned(
                                        top: 20,
                                        right: 24,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : Positioned(
                                        top: 10,
                                        right: 34,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 20,
                                          width: 20,
                                          child: IconButton(
                                            icon: _isFavourite
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                  ),
                                            onPressed: () {
                                              _toggleFavourite(setStateFul);
                                            },
                                          ),
                                        ));
                              }),
                            ],
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 15, bottom: 10),
                          child: Text(
                            "Quick Functions",
                            style: GoogleFonts.poppins(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, viewOnMap.Routename,
                                          arguments: {
                                            'listOfPlaces': placeArray
                                          }),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 8),
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
                                              size: 50,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey[300],
                                            ),
                                            child: Icon(
                                              Icons.location_on,
                                              size: 45,
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
                                        "View Map",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
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
                                              size: 50,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey[300],
                                            ),
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 45,
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
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
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
                                              'id': document!.id,
                                              'isPublic':
                                                  document.get('isPublic')
                                            });
                                      },
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
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
                                              size: 50,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey[300],
                                            ),
                                            child: Icon(
                                              Icons.update_sharp,
                                              size: 45,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
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
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'packages')
                                                            .doc(document!.id)
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
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
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
                                              size: 50,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Colors.grey[300],
                                            ),
                                            child: Icon(
                                              Icons.delete_forever,
                                              size: 45,
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
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
                          padding:
                              EdgeInsets.only(top: 20, left: 10, right: 10),
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
                  );
                }),
          );
  }
}
