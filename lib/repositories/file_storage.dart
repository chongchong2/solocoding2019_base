import 'dart:convert';
import 'dart:io';

import 'package:solocoding2019_base/models/stored_weather_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
      this.tag,
      this.getDirectory,
      );

  Future<List<StoredWeatherEntity>> loadTodos() async {
    final file = await _getLocalFile();
    try {
      final string = await file.readAsString();
      final json = JsonDecoder().convert(string);
      final weathers = (json['weathers'])
          .map<StoredWeather>((weathers) => StoredWeatherEntity.fromJson(weathers))
          .toList();
      return weathers;
    }catch(e) {
      print(e);
    }
  }

  Future<File> saveTodos(List<StoredWeatherEntity> weathers) async {
    final file = await _getLocalFile();

//    var rr = JsonEncoder().convert(weathers.getRawFson());

    var result =  file.writeAsString(
        JsonEncoder().convert({
      'weathers': weathers.map((weathers) => weathers.toJson()).toList(),
    })
    );

    return result;
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}