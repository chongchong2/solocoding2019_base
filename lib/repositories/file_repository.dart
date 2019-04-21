import 'package:meta/meta.dart';
import 'package:solocoding2019_base/models/stored_weather_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/repositories/file_storage.dart';

class FileRepository {
  final FileStorage fileStorage;

  FileRepository({@required this.fileStorage})
      : assert(fileStorage != null);

  Future<List<StoredWeatherEntity>> loadTodos() async {
    try {
      return await fileStorage.loadTodos();
    } catch (e) {
//      fileStorage.saveTodos(todos);
//      return todos;
    }
  }

  Future saveTodos(List<StoredWeatherEntity> weathersList) {
    return Future.wait<dynamic>([
      fileStorage.saveTodos(weathersList)
    ]);
  }
}
