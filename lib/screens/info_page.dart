import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:space_x_app/api/api.dart';
import 'package:url_launcher/url_launcher.dart';

// class InfoPage extends StatelessWidget {
//   var data;

//   Future<void> _onOpen(LinkableElement link) async {
//     if (await canLaunch(link.url)) {
//       await launch(link.url);
//     } else {
//       throw 'Could not launch $link';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     imgList = data["flickr_images"];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(data["name"]),
//       ),
//       body: FutureBuilder(
//         future: info,
//         builder: (context, projectSnap) {
//           if (projectSnap.connectionState == ConnectionState.none ||
//               projectSnap.hasData == false ||
//               projectSnap.data == null) {
//             return CircularProgressIndicator();
//           }

//           return ListView(
//             physics: BouncingScrollPhysics(),
//             children: [
//               CarouselSlider(
//                 options: CarouselOptions(),
//                 items: imgList
//                     .map((item) => Container(
//                           child: Center(
//                               child: Image.network(
//                             item,
//                             fit: BoxFit.fill,
//                           )),
//                         ))
//                     .toList(),
//               ),
//               Container(
//                 padding: EdgeInsets.all(25),
//                 child: Column(
//                   children: [
//                     Text(
//                       data["name"],
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
//                     ),
//                     Text(
//                       "Founder: ${data["founder"]}",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
//                     ),
//                     Text(
//                       "Stages: ${data["stages"].toString()}",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                     ),
//                     Text(
//                       "Cost Per Launch: ${data["cost_per_launch"].toString()}",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//                     ),
//                     SelectableLinkify(
//                       onOpen: _onOpen,
//                       text: "Wikipedia: ${data["wikipedia"]} ",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Text(
//                       " ${data["description"]}",
//                       style:
//                           TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future<Map> info;
  List<dynamic> imgList;
  @override
  void initState() {
    super.initState();
    info = fetchInformation();
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  getLocalTime(String utcTime) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(utcTime, true);
    var dateLocal = dateTime.toLocal();
    return DateFormat("yMd").format(dateLocal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roadster Information"),
      ),
      body: FutureBuilder(
        future: info,
        builder: (context, projectSnap) {
          if (projectSnap.connectionState == ConnectionState.none ||
              projectSnap.hasData == false ||
              projectSnap.data == null) {
            return Center(child: CircularProgressIndicator());
          }
          var data = projectSnap.data;
          imgList = data["flickr_images"];
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              CarouselSlider(
                options: CarouselOptions(),
                items: imgList
                    .map((item) => Container(
                          child: Center(
                              child: Image.network(
                            item,
                            fit: BoxFit.fill,
                          )),
                        ))
                    .toList(),
              ),
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Text(
                      data["name"],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                    ),
                    Text(
                      "Launch Date: ${getLocalTime(data["launch_date_utc"])}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                    ),
                    SelectableLinkify(
                      onOpen: _onOpen,
                      text: "Youtube: ${data["video"]} ",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                    ),
                    Text(
                      "Launch Mass: ${data["launch_mass_kg"].toString()} kgs",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      "Speed: ${data["speed_kph"].toStringAsFixed(3)} kph",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      "Earth Distance: ${data["earth_distance_km"].toStringAsFixed(3)} km",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      "Mars Distance: ${data["mars_distance_km"].toStringAsFixed(3)} km",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    SelectableLinkify(
                      onOpen: _onOpen,
                      text: "Wikipedia: ${data["wikipedia"]} ",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      " ${data["details"]}",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
