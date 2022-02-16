import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Widget/place_Widget.dart';
import '../Models/image.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toyr2/Models/place.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class toyrScreen extends StatelessWidget {
  static const Routename = '/toyrScreen';

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();
    final List<image> images = [
      image(
          imageId: "p1",
          imgUrl:
              "https://lh5.googleusercontent.com/p/AF1QipMz9P5BrDQATamw27O9h08B9yt0l71m3v4IWzwj=w1080-k-no"),
      image(
          imageId: "p2",
          imgUrl:
              "http://touristinformationcenter.net/wp-content/uploads/2021/09/gopi-4.jpg"),
      image(
          imageId: "p3",
          imgUrl:
              "https://i.pinimg.com/736x/fe/8c/4b/fe8c4b4f17d110af461affb6f880f00a.jpg"),
      image(
          imageId: "p4",
          imgUrl:
              "https://pcbodiwala.com/storage/work_experience/5fc5dc150256a1606802453.jpeg"),
      image(
          imageId: "p5",
          imgUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/eb/f6/9b/wave-pool.jpg?w=1200&h=1200&s=1")
    ];
    final List<place> places = [
      place(
          id: "p1",
          name: "Iskcon Temple",
          imgUrl:
              "https://lh5.googleusercontent.com/p/AF1QipMz9P5BrDQATamw27O9h08B9yt0l71m3v4IWzwj=w1080-k-no"),
      place(
          id: "p2",
          name: "Gopi talav",
          imgUrl:
              "http://touristinformationcenter.net/wp-content/uploads/2021/09/gopi-4.jpg"),
      place(
          id: "p3",
          name: "Dumas",
          imgUrl:
              "https://i.pinimg.com/736x/fe/8c/4b/fe8c4b4f17d110af461affb6f880f00a.jpg"),
      place(
          id: "p4",
          name: "Woop",
          imgUrl:
              "https://pcbodiwala.com/storage/work_experience/5fc5dc150256a1606802453.jpeg"),
      place(
          id: "p5",
          name: "Amazia Water Park",
          imgUrl:
              "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0d/eb/f6/9b/wave-pool.jpg?w=1200&h=1200&s=1")
    ];
    final imgUrl =
        // "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/International_Business_Center%2C_Piplod%2C_Surat..jpg/250px-International_Business_Center%2C_Piplod%2C_Surat..jpg";
        "https://c0.wallpaperflare.com/preview/403/5/230/bridge-water-building-waterfront.jpg";
    // "https://w0.peakpx.com/wallpaper/445/806/HD-wallpaper-surat-city-ab.jpg";
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
      body: Container(
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
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Surat Trip",
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 50, color: Colors.white)),
                                Text(
                                  "Created At: 23/10/2002",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.white),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "                                                                                                                                                      ",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      )),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.location_on,
                              // Icons.location_on,
                              size: 55,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
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
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 55,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.share,
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
                          "Share",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 55,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.photo_library,
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
                          "Memories",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 3, color: Colors.grey),
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 55,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey[300],
                            ),
                            child: Icon(
                              Icons.update_sharp,
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
                          "Update",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                  child: PlaceWidget(
                      placeName: places[i].name,
                      city: "Surat",
                      imgUrl: places[i].imgUrl),
                ),
                itemCount: places.length,
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
                  count: places.length,
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
            // Container(
            //   padding: EdgeInsets.only(left: 15, bottom: 10),
            //   child: Text(
            //     "Memories",
            //     style: GoogleFonts.poppins(
            //         fontSize: 20, fontWeight: FontWeight.w500),
            //   ),
            // ),
            // Container(child: StaggeredGrid.count(crossAxisCount: crossAxisCount),),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
