import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:space_x_app/api/api.dart';
import 'package:space_x_app/screens/rocket_view.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Future<List<dynamic>> history;
  @override
  void initState() {
    super.initState();
    history = fetchHistory();
  }

  getLocalTime(String utcTime) {
    var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(utcTime, true);
    var dateLocal = dateTime.toLocal();
    return DateFormat("yMd").format(dateLocal);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: history,
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
                title: Text(
                  data["title"],
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  data["details"],
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Text(getLocalTime(data["event_date_utc"])),
                isThreeLine: true,
              ),
            );
          },
        );
      },
    );
  }
}
