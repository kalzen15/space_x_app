import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:space_x_app/api/api.dart';
import 'package:space_x_app/screens/info_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatefulWidget {
  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information> {
  Future<Map> company;
  @override
  void initState() {
    super.initState();
    company = fetchCompany();
  }

  Future<void> _onOpen(LinkableElement link) async {
    if (await canLaunch(link.url)) {
      await launch(link.url);
    } else {
      throw 'Could not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: company,
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            projectSnap.hasData == false ||
            projectSnap.data == null) {
          return CircularProgressIndicator();
        }
        var data = projectSnap.data;
        return ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 1 / 8,
                  25,
                  MediaQuery.of(context).size.width * 1 / 8,
                  0),
              child: RaisedButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => InfoPage())),
                child: Text(
                  "View Info on Roadster",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
                color: Colors.black,
              ),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Column(
                children: [
                  Text(
                    data["name"],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                  ),
                  Text(
                    "Founder: ${data["founder"]}",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                  ),
                  Text(
                    "CEO: ${data["ceo"]}",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Text(
                    "CTO: ${data["cto"]}",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  Text(
                    "COO: ${data["coo"]}",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    " ${data["summary"]}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Headquarters Address: ${data["headquarters"]["address"]}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text: "Website: ${data["links"]["website"]} ",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text: "Flickr: ${data["links"]["flickr"]} ",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text: "Twitter: ${data["links"]["twitter"]} ",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  SelectableLinkify(
                    onOpen: _onOpen,
                    text: "Elon's Twitter: ${data["links"]["elon_twitter"]} ",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
