import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class DragonView extends StatelessWidget {
  var data;
  List<dynamic> imgList;
  DragonView({this.data});

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    imgList = data["flickr_images"];
    return Scaffold(
      appBar: AppBar(
        title: Text(data["name"]),
      ),
      body: ListView(
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45),
                ),
                Text(
                  "Type: ${data["type"]}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
                Text(
                  "Active: ${data["active"] ? "✅" : "❌"}",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                ),
                SelectableLinkify(
                  onOpen: _onOpen,
                  text: "Wikipedia: ${data["wikipedia"]} ",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  " ${data["description"]}",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
