import 'package:flutter/material.dart';
import 'package:space_x_app/api/api.dart';
import 'package:space_x_app/screens/rocket_view.dart';

class Rockets extends StatefulWidget {
  @override
  _RocketsState createState() => _RocketsState();
}

class _RocketsState extends State<Rockets> {
  Future<List<dynamic>> rockets;
  @override
  void initState() {
    super.initState();
    rockets = fetchRockets();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rockets,
      builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none ||
            projectSnap.hasData == false ||
            projectSnap.data == null) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            var data = projectSnap.data[index];
            return Card(
              child: ListTile(
                title: Text(data["name"]),
                leading: SizedBox(
                  height: 400.0,
                  width: 100.0, // fixed width and height
                  child: Image.network(
                    data["flickr_images"][0],
                    fit: BoxFit.fill,
                  ),
                ),
                subtitle: Text(
                  data["description"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                isThreeLine: true,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => RocketView(
                              data: data,
                            ))),
              ),
            );
          },
        );
      },
    );
  }
}
