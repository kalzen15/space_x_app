import 'package:flutter/material.dart';
import 'package:space_x_app/api/api.dart';
import 'package:space_x_app/screens/dragon_view.dart';

class Dragons extends StatefulWidget {
  @override
  _DragonsState createState() => _DragonsState();
}

class _DragonsState extends State<Dragons> {
  Future<List<dynamic>> dragons;
  @override
  void initState() {
    super.initState();
    dragons = fetchDragons();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dragons,
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
                trailing: Text(data["first_flight"]),
                isThreeLine: true,
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DragonView(
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
