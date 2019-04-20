import 'dart:convert';
import 'dart:io';

import 'package:solocoding2019_base/models/weather_model.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
      this.tag,
      this.getDirectory,
      );

  Future<List<Weather>> loadTodos() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final todos = (json['todos'])
//        .map<Weather>((todo) => Weather.fromFileJson(todo))
        .toList();

    return todos;
  }

  Future<File> saveTodos(List<Weather> todos) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
//      'todos': todos.map((todo) => todo.toJson()).toList(),
    }));
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