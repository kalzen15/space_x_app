import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:space_x_app/models/view.dart';

String rocketsFile = "Rockets.json";
String dragonsFile = "Dragons.json";
String historyFile = "History.json";
String informationFile = "Information.json";
String companyFile = "Company.json";

getData(View v) async {
  var cacheDir = await getTemporaryDirectory();
  switch (v) {
    case View.rockets:
      if (await File(cacheDir.path + "/" + rocketsFile).exists()) {
        var jsonData =
            File(cacheDir.path + "/" + rocketsFile).readAsStringSync();
        return jsonDecode(jsonData);
      } else {
        return null;
      }
      break;
    case View.dragons:
      if (await File(cacheDir.path + "/" + dragonsFile).exists()) {
        var jsonData =
            File(cacheDir.path + "/" + dragonsFile).readAsStringSync();
        return jsonDecode(jsonData);
      } else {
        return null;
      }
      break;
    case View.history:
      if (await File(cacheDir.path + "/" + historyFile).exists()) {
        var jsonData =
            File(cacheDir.path + "/" + historyFile).readAsStringSync();
        return jsonDecode(jsonData);
      } else {
        return null;
      }
      break;
    case View.information:
      if (await File(cacheDir.path + "/" + informationFile).exists()) {
        var jsonData =
            File(cacheDir.path + "/" + informationFile).readAsStringSync();
        return jsonDecode(jsonData);
      } else {
        return null;
      }
      break;
    case View.company:
      if (await File(cacheDir.path + "/" + companyFile).exists()) {
        var jsonData =
            File(cacheDir.path + "/" + companyFile).readAsStringSync();
        return jsonDecode(jsonData);
      } else {
        return null;
      }
      break;
  }
}

writeData(View v, response) async {
  var cacheDir = await getTemporaryDirectory();
  switch (v) {
    case View.rockets:
      File file = File(cacheDir.path + "/" + rocketsFile);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);
      break;
    case View.dragons:
      File file = File(cacheDir.path + "/" + dragonsFile);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);
      break;
    case View.history:
      File file = File(cacheDir.path + "/" + historyFile);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);
      break;
    case View.information:
      File file = File(cacheDir.path + "/" + informationFile);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);
      break;
    case View.company:
      File file = File(cacheDir.path + "/" + companyFile);
      file.writeAsString(response.body, flush: true, mode: FileMode.write);
      break;
  }
}
