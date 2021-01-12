import 'dart:convert';

import 'package:http/http.dart' as http;

var url = 'https://api.spacexdata.com/v4/';

Future<List<dynamic>> fetchRockets() async {
  final response = await http.get(url + "rockets");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("Rockets fetch error ${response.statusCode}");
  }
}

Future<List<dynamic>> fetchDragons() async {
  final response = await http.get(url + "dragons");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("Rockets fetch error ${response.statusCode}");
  }
}

Future<List<dynamic>> fetchHistory() async {
  final response = await http.get(url + "history");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("Rockets fetch error ${response.statusCode}");
  }
}

Future<Map> fetchInformation() async {
  final response = await http.get(url + "roadster");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("Rockets fetch error ${response.statusCode}");
  }
}

Future<Map> fetchCompany() async {
  final response = await http.get(url + "company");
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    print("Rockets fetch error ${response.statusCode}");
  }
}
