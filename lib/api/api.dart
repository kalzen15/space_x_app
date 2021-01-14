import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:space_x_app/api/cache.dart';
import 'package:space_x_app/models/view.dart';

var url = 'https://api.spacexdata.com/v4/';

Future<List<dynamic>> fetchRockets() async {
  View v = View.rockets;
  var data = await getData(v);

  if (data == null) {
    final response = await http.get(url + "rockets");
    if (response.statusCode == 200) {
      writeData(v, response);
      return jsonDecode(response.body);
    } else {
      print("Rockets fetch error ${response.statusCode}");
    }
  } else {
    return data;
  }
}

Future<List<dynamic>> fetchDragons() async {
  View v = View.dragons;
  var data = await getData(v);
  if (data == null) {
    final response = await http.get(url + "dragons");
    if (response.statusCode == 200) {
      writeData(v, response);
      return jsonDecode(response.body);
    } else {
      print("Rockets fetch error ${response.statusCode}");
    }
  } else {
    return data;
  }
}

Future<List<dynamic>> fetchHistory() async {
  View v = View.history;
  var data = await getData(v);
  if (data == null) {
    final response = await http.get(url + "history");
    if (response.statusCode == 200) {
      writeData(v, response);
      return jsonDecode(response.body);
    } else {
      print("Rockets fetch error ${response.statusCode}");
    }
  } else {
    return data;
  }
}

Future<Map> fetchInformation() async {
  View v = View.information;
  var data = await getData(v);
  if (data == null) {
    final response = await http.get(url + "roadster");
    if (response.statusCode == 200) {
      writeData(v, response);
      return jsonDecode(response.body);
    } else {
      print("Rockets fetch error ${response.statusCode}");
    }
  } else {
    return data;
  }
}

Future<Map> fetchCompany() async {
  View v = View.company;
  var data = await getData(v);
  if (data == null) {
    final response = await http.get(url + "company");
    if (response.statusCode == 200) {
      writeData(v, response);
      return jsonDecode(response.body);
    } else {
      print("Rockets fetch error ${response.statusCode}");
    }
  } else {
    return data;
  }
}
