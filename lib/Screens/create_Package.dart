import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Screens/home_page.dart';
import 'package:toyr2/Widget/place_Widget.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../Widget/image_Picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:ui';
import '../Widget/choose_place.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../Screens/toyr_screen.dart';

class createPackageScreen extends StatefulWidget {
  const createPackageScreen({Key? key}) : super(key: key);
  static const Routename = './createPackageScreen';

  @override
  State<createPackageScreen> createState() => _createPackageScreenState();
}

class _createPackageScreenState extends State<createPackageScreen> {
  File? _pickedImage;
  String? valueChoose = null;
  String? _packageName = null;
  final GlobalKey<FormState> _formkey = GlobalKey();
  List listItem = ['Surat', 'Ahmedabad', 'Kutch'];
  List<String> listOfPlaces = new List<String>.empty(growable: true);
  List<dynamic>? finalSelectedPlaces = new List<dynamic>.empty(growable: true);
  bool _isLoading = false;
  bool _isPublic = false;
  bool _isMemoryPublic = false;
  @override
  void _ImagePicker(File? image) {
    _pickedImage = image;
  }

  void _showErrorDialog(String? msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(msg.toString()),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'))
              ],
            ));
  }

  void _saveForm() async {
    // FocusScope.of(context).unfocus();
    print(FirebaseAuth.instance.currentUser!.uid);
    if (!_formkey.currentState!.validate()) {
      return;
    }
    if (_pickedImage == null) {
      _showErrorDialog('Please select image properly');
      print('Please select image properly.');
      return;
    }
    if (valueChoose == null) {
      _showErrorDialog('Please select city.');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formkey.currentState!.save();
    // AuthResult authresult;
    try {
      var id = DateTime.now().toString();
      var ref = FirebaseStorage.instance
          .ref()
          .child('packages/' + id + '/packageDP/')
          .child(_packageName.toString() + '.jpg');

      final uploadtask = ref.putFile(_pickedImage!);
      var url = await (await uploadtask).ref.getDownloadURL();

      // var url = await ref.getDownloadURL();
      // print('isPublic' + _isPublic.toString());
      // print('user' + FirebaseAuth.instance.currentUser.email);
      print({
        'packageName': _packageName,
        'imgUrl': url,
        'city': valueChoose,
        'isPublic': _isPublic,
        '_isMemoryPublic': _isMemoryPublic,
        'createdAt': Timestamp.now(),
        'views': 0,
        'createdBy': FirebaseAuth.instance.currentUser!.email,
        'places': FieldValue.arrayUnion(finalSelectedPlaces!),
        'memories': FieldValue.arrayUnion(new List.empty())
      });
      await FirebaseFirestore.instance.collection('packages').doc(id).set({
        'packageName': _packageName,
        'imgUrl': url,
        'city': valueChoose,
        'isPublic': _isPublic,
        'isMemoryPublic': _isMemoryPublic,
        'createdAt': Timestamp.now(),
        'views': 0,
        'createdBy': FirebaseAuth.instance.currentUser!.email,
        'places': FieldValue.arrayUnion(finalSelectedPlaces!),
        'memories': FieldValue.arrayUnion(new List.empty())
      });

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushNamed(HomeScreen.Routename);
      Navigator.of(context)
          .pushNamed(toyrScreen.Routename, arguments: {'id': id});
    } on PlatformException catch (error) {
      String? errormsg = 'Some thing wrong happened!';
      if (error.message != null) {
        errormsg = error.message;
      }
      setState(() {
        _isLoading = false;
      });
      _showErrorDialog(errormsg);
    } catch (error) {
      const errormsg = 'Some thing wrong happened. Please try again later';
      setState(() {
        _isLoading = false;
      });
      print(error.toString());
      _showErrorDialog(errormsg.toString());
    }
  }

  Widget build(BuildContext context) {
    final CollectionReference _placeRef =
        FirebaseFirestore.instance.collection('places');
    return Scaffold(
      body: FutureBuilder<QuerySnapshot>(
          future: _placeRef.get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Loading",
                      style: TextStyle(fontSize: 20),
                    ),
                    AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText('...',
                          textStyle: TextStyle(fontSize: 20),
                          speed: Duration(milliseconds: 100))
                    ]),
                    Spacer(),
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Loading",
                      style: TextStyle(fontSize: 20),
                    ),
                    AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText('...',
                          textStyle: TextStyle(fontSize: 20),
                          speed: Duration(milliseconds: 100))
                    ]),
                    Spacer(),
                  ],
                ),
              );
            }
            if (snapshot.data == null) {
              return Center(
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "Loading",
                      style: TextStyle(fontSize: 20),
                    ),
                    AnimatedTextKit(animatedTexts: [
                      TyperAnimatedText('...',
                          textStyle: TextStyle(fontSize: 20),
                          speed: Duration(milliseconds: 100))
                    ]),
                    Spacer(),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                Container(
                    color: Colors.deepPurple,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
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
                            Text('Create Package',
                                style: GoogleFonts.lato(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.only(top: 20),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                                color: Colors.white),
                            child: Form(
                              key: _formkey,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.85 -
                                        20,
                                child: ListView(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    Center(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 60, 5, 156),
                                              borderRadius:
                                                  BorderRadius.circular(100)),
                                          child: SizedBox(
                                            height: 5,
                                            width: 50,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Package Name",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: TextFormField(
                                          onChanged: (value) {
                                            _packageName = value;
                                          },
                                          decoration: InputDecoration(
                                              hintText: 'add package name here',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.deepPurple,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          keyboardType: TextInputType.name,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter Package Name';
                                            }
                                            return null;
                                          },
                                          textInputAction: TextInputAction.done,
                                        )),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Choose Image",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: AuthImagePicker(
                                            '_', false, _ImagePicker)),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Choose City",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    StatefulBuilder(
                                        builder: (context, setStateFul) {
                                      final document = snapshot.data!.docs;
                                      if (valueChoose != null) {
                                        listOfPlaces =
                                            new List.empty(growable: true);
                                        for (int i = 0;
                                            i < document.length;
                                            i++) {
                                          if (valueChoose ==
                                              document[i].get('city')) {
                                            listOfPlaces.add(document[i].id);
                                          }
                                        }
                                      }

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    // color: Colors.black,
                                                    color: Colors.grey.shade400,
                                                  )),
                                              child: DropdownButton(
                                                underline: SizedBox(),
                                                hint: Text(
                                                  'Select City',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                dropdownColor: Colors.white,
                                                icon:
                                                    Icon(Icons.arrow_drop_down),
                                                iconSize: 36,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                                isExpanded: true,
                                                onChanged: (newValue) {
                                                  setStateFul(() {
                                                    valueChoose =
                                                        newValue.toString();
                                                    finalSelectedPlaces = null;
                                                  });
                                                },
                                                value: valueChoose,
                                                items:
                                                    listItem.map((valueItem) {
                                                  return DropdownMenuItem(
                                                    value: valueItem,
                                                    child: Text(valueItem),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 5),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Choose Places",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade400),
                                                  // color: Colors.grey.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 20, 10, 10),
                                              child: Column(children: [
                                                finalSelectedPlaces == null ||
                                                        finalSelectedPlaces!
                                                            .isEmpty
                                                    ? Text(
                                                        'No Places Selected Yet!!',
                                                        style: TextStyle(
                                                            fontSize: 25,
                                                            color:
                                                                Colors.black38),
                                                      )
                                                    : Container(
                                                        height: 220 *
                                                            finalSelectedPlaces!
                                                                .length
                                                                .toDouble(),
                                                        child: ListView.builder(
                                                          itemCount:
                                                              finalSelectedPlaces!
                                                                  .length,
                                                          itemBuilder:
                                                              (ctx, index) {
                                                            return PlaceWidget(
                                                                id: finalSelectedPlaces![
                                                                    index]);
                                                          },
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                FlatButton.icon(
                                                    color:
                                                        Colors.deepPurple[400],
                                                    textColor: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    onPressed: () {
                                                      setStateFul(() {
                                                        // StartAddPlaces(context);
                                                        if (valueChoose ==
                                                            null) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        'Error'),
                                                                    content: Text(
                                                                        'Please select city first'),
                                                                    actions: [
                                                                      FlatButton(
                                                                          textColor: Colors
                                                                              .deepPurple,
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(ctx).pop();
                                                                          },
                                                                          child:
                                                                              Text('Okay'))
                                                                    ],
                                                                  ));
                                                        } else {
                                                          showModalBottomSheet(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15.0)),
                                                            ),
                                                            context: context,
                                                            builder: (_) {
                                                              bool firstTime =
                                                                  true;
                                                              List<dynamic>?
                                                                  selectedPlaces =
                                                                  finalSelectedPlaces ==
                                                                          null
                                                                      ? new List<
                                                                              dynamic>.empty(
                                                                          growable:
                                                                              true)
                                                                      : finalSelectedPlaces;
                                                              return StatefulBuilder(
                                                                  builder:
                                                                      (context,
                                                                          state) {
                                                                return GestureDetector(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        Column(
                                                                            children: [
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Center(
                                                                                child: Container(
                                                                                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(100)),
                                                                                    child: SizedBox(
                                                                                      height: 5,
                                                                                      width: 50,
                                                                                    )),
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.only(left: 10, top: 10),
                                                                                alignment: Alignment.centerLeft,
                                                                                child: Text(
                                                                                  "" + valueChoose.toString() + "'s Places",
                                                                                  style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Container(
                                                                                padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                height: 360,
                                                                                child: GridView.builder(
                                                                                    physics: BouncingScrollPhysics(),
                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 10, mainAxisSpacing: 10),
                                                                                    itemCount: listOfPlaces.length,
                                                                                    itemBuilder: (ctx, index) {
                                                                                      return FutureBuilder<DocumentSnapshot>(
                                                                                          future: FirebaseFirestore.instance.doc('places/' + listOfPlaces[index]).get(),
                                                                                          builder: (context, snapshot) {
                                                                                            if (snapshot.hasError && firstTime) {
                                                                                              return Center(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Spacer(),
                                                                                                    Text(
                                                                                                      "Loading",
                                                                                                      style: TextStyle(fontSize: 20),
                                                                                                    ),
                                                                                                    AnimatedTextKit(animatedTexts: [
                                                                                                      TyperAnimatedText('...', textStyle: TextStyle(fontSize: 20), speed: Duration(milliseconds: 100))
                                                                                                    ]),
                                                                                                    Spacer(),
                                                                                                  ],
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                            if (snapshot.connectionState == ConnectionState.waiting && firstTime) {
                                                                                              return Center(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Spacer(),
                                                                                                    Text(
                                                                                                      "Loading",
                                                                                                      style: TextStyle(fontSize: 20),
                                                                                                    ),
                                                                                                    AnimatedTextKit(animatedTexts: [
                                                                                                      TyperAnimatedText('...', textStyle: TextStyle(fontSize: 20), speed: Duration(milliseconds: 100))
                                                                                                    ]),
                                                                                                    Spacer(),
                                                                                                  ],
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                            if (snapshot.data == null) {
                                                                                              return Center(
                                                                                                child: Row(
                                                                                                  children: [
                                                                                                    Spacer(),
                                                                                                    Text(
                                                                                                      "Loading",
                                                                                                      style: TextStyle(fontSize: 20),
                                                                                                    ),
                                                                                                    AnimatedTextKit(animatedTexts: [
                                                                                                      TyperAnimatedText('...', textStyle: TextStyle(fontSize: 20), speed: Duration(milliseconds: 100))
                                                                                                    ]),
                                                                                                    Spacer(),
                                                                                                  ],
                                                                                                ),
                                                                                              );
                                                                                            }
                                                                                            firstTime = false;
                                                                                            final document = snapshot.data;
                                                                                            return GestureDetector(
                                                                                              onTap: () {
                                                                                                // state(())
                                                                                                state(() {
                                                                                                  if (selectedPlaces!.contains(document!.id)) {
                                                                                                    selectedPlaces.remove(document.id);
                                                                                                    print('-------------------------------------');
                                                                                                    print(selectedPlaces);
                                                                                                  } else {
                                                                                                    selectedPlaces.add(document.id);
                                                                                                    print('-------------------------------------');
                                                                                                    print(selectedPlaces);
                                                                                                  }
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                decoration: selectedPlaces!.contains(document!.id) ? BoxDecoration(border: Border.all(color: Colors.deepPurple, width: 7), borderRadius: BorderRadius.circular(30)) : null,
                                                                                                // padding: EdgeInsets.all(10),
                                                                                                child: Stack(
                                                                                                  children: [
                                                                                                    Container(
                                                                                                        height: 200,
                                                                                                        width: MediaQuery.of(context).size.width,
                                                                                                        // width: 200,
                                                                                                        child: ClipRRect(
                                                                                                          borderRadius: BorderRadius.circular(20),
                                                                                                          child: Image.network(
                                                                                                            document.get('imgUrl'),
                                                                                                            fit: BoxFit.cover,
                                                                                                          ),
                                                                                                        )),
                                                                                                    Positioned(
                                                                                                      bottom: 0,
                                                                                                      child: Container(
                                                                                                        padding: EdgeInsets.only(left: 10, bottom: 10),
                                                                                                        child: ClipRRect(
                                                                                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8), topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                                                                                          child: Container(
                                                                                                              margin: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
                                                                                                              child: BackdropFilter(
                                                                                                                filter: ImageFilter.blur(sigmaX: 19, sigmaY: 19),
                                                                                                                child: Row(
                                                                                                                  children: [
                                                                                                                    Text(
                                                                                                                      document.get('placeName'),
                                                                                                                      style: GoogleFonts.poppins(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
                                                                                                                    ),
                                                                                                                  ],
                                                                                                                ),
                                                                                                              )),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Positioned(
                                                                                                        top: 10,
                                                                                                        right: 10,
                                                                                                        child: selectedPlaces.contains(document.id)
                                                                                                            ? CircleAvatar(
                                                                                                                radius: 13,
                                                                                                                child: Text(
                                                                                                                  "" + (selectedPlaces.indexOf(document.id) + 1).toString(),
                                                                                                                  style: TextStyle(color: Colors.white),
                                                                                                                ),
                                                                                                                backgroundColor: Colors.deepPurple,
                                                                                                              )
                                                                                                            : CircleAvatar(
                                                                                                                radius: 13,
                                                                                                                backgroundColor: Color.fromRGBO(128, 128, 128, 0.7),
                                                                                                              ))
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            );
                                                                                          });
                                                                                    }),
                                                                              ),
                                                                            ]),
                                                                        Positioned(
                                                                            bottom:
                                                                                20,
                                                                            left: MediaQuery.of(context).size.width * 0.5 -
                                                                                45,
                                                                            child:
                                                                                FlatButton(
                                                                              color: Colors.deepPurple,
                                                                              textColor: Colors.white,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Text("Select(" + selectedPlaces!.length.toString() + ")"),
                                                                              onPressed: () {
                                                                                setStateFul(() {
                                                                                  finalSelectedPlaces = selectedPlaces;
                                                                                  Navigator.of(context).pop();
                                                                                });
                                                                              },
                                                                            ))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  onTap: () {},
                                                                  behavior:
                                                                      HitTestBehavior
                                                                          .opaque,
                                                                );
                                                              });
                                                            },
                                                          );
                                                        }
                                                      });
                                                    },
                                                    icon: Icon(Icons.add),
                                                    label:
                                                        Text('Select Places')),
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                    StatefulBuilder(
                                        builder: (context, setStateFul) {
                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Set Public',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.all(10),
                                                    child: FlutterSwitch(
                                                        showOnOff: true,
                                                        activeText: 'yes',
                                                        inactiveText: 'no',
                                                        activeColor: Colors
                                                            .deepPurple
                                                            .shade400,
                                                        value: _isPublic,
                                                        onToggle: (onToggle) {
                                                          setStateFul(() {
                                                            if (!onToggle) {
                                                              _isMemoryPublic =
                                                                  false;
                                                            }
                                                            _isPublic =
                                                                onToggle;
                                                          });
                                                        }),
                                                  ),
                                                ]),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 15, right: 15),
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Set Memories Public',
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 10,
                                                  // ),
                                                  Container(
                                                    padding: EdgeInsets.all(5),
                                                    margin: EdgeInsets.all(10),
                                                    child: FlutterSwitch(
                                                        disabled: !_isPublic,
                                                        showOnOff: true,
                                                        activeText: 'yes',
                                                        inactiveText: 'no',
                                                        activeColor: Colors
                                                            .deepPurple
                                                            .shade400,
                                                        value: _isMemoryPublic,
                                                        onToggle: (onToggle) {
                                                          if (_isPublic) {
                                                            setStateFul(() {
                                                              _isMemoryPublic =
                                                                  onToggle;
                                                            });
                                                          }
                                                        }),
                                                  ),
                                                ]),
                                          )
                                        ],
                                      );
                                    }),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: FlatButton.icon(
                                                color: Colors.deepPurple[400],
                                                textColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                onPressed: () {
                                                  _saveForm();
                                                },
                                                height: 50,
                                                icon: Icon(Icons.add),
                                                label: Text('Create')),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: FlatButton.icon(
                                                // color: Colors.deepPurple[400],
                                                // textColor: Colors.white,
                                                textColor: Colors.deepPurple,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: BorderSide(
                                                      color: Colors.deepPurple,
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                height: 50,
                                                icon: Icon(Icons.clear),
                                                label: Text('Cancel')),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
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
