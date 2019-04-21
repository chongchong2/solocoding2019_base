import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:solocoding2019_base/models/stored_weather_model.dart';
import 'package:solocoding2019_base/models/weather_model.dart';
import 'package:solocoding2019_base/repositories/file_repository.dart';

@immutable
abstract class FileState extends Equatable {
  FileState([List props = const []]) : super(props);
}

class WeathersLoading extends FileState {
  @override
  String toString() => 'WeathersLoading';
}

class WeathersLoaded extends FileState {
  final List<StoredWeather> weathers;

  WeathersLoaded([this.weathers = const []]) : super([weathers]);

  @override
  String toString() => 'WeathersLoaded { weathers: $weathers }';
}

class WeathersNotLoaded extends FileState {
  @override
  String toString() => 'WeathersNotLoaded';
}


@immutable
abstract class FileEvent extends Equatable {
  FileEvent([List props = const []]) : super(props);
}

class LoadWeathers extends FileEvent {
  @override
  String toString() => 'LoadWeathers';
}

class AddWeathers extends FileEvent {
  final StoredWeather weather;

  AddWeathers(this.weather) : super([weather]);

  @override
  String toString() => 'AddWeathers { weather: $weather }';
}

class LoadCurrentWeathers extends FileEvent {
  @override
  String toString() => 'LoadCurrentWeathers';
}
//
//class UpdateTodo extends TodosEvent {
//  final Todo updatedTodo;
//
//  UpdateTodo(this.updatedTodo) : super([updatedTodo]);
//
//  @override
//  String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
//}
//
//class DeleteTodo extends TodosEvent {
//  final Todo todo;
//
//  DeleteTodo(this.todo) : super([todo]);
//
//  @override
//  String toString() => 'DeleteTodo { todo: $todo }';
//}
//
//class ClearCompleted extends TodosEvent {
//  @override
//  String toString() => 'ClearCompleted';
//}




class FileBloc extends Bloc<FileEvent, FileState> {
  final FileRepository fileRepository;

  FileBloc({@required this.fileRepository});

  @override
  FileState get initialState => WeathersLoading();

  @override
  Stream<FileState> mapEventToState(FileEvent event) async* {
    if (event is LoadWeathers) {
      yield* _mapLoadWeathersToState();
    } else if (event is AddWeathers) {
      yield* _mapAddWeathersToState(event);
    }
//    else if (event is UpdateTodo) {
//      yield* _mapUpdateTodoToState(event);
//    } else if (event is DeleteTodo) {
//      yield* _mapDeleteTodoToState(event);
//    } else if (event is ToggleAll) {
//      yield* _mapToggleAllToState();
//    } else if (event is ClearCompleted) {
//      yield* _mapClearCompletedToState();
//    }
  }

  Stream<FileState> _mapLoadWeathersToState() async* {
    try {
      final weathers = await this.fileRepository.loadTodos();
      yield WeathersLoaded(
        weathers.map(StoredWeather.fromEntity).toList(),
      );
    } catch (_) {
//      yield WeathersNotLoaded();
    List<StoredWeather> t = List<StoredWeather>();
      yield WeathersLoaded(t);
    }
  }

  Stream<FileState> _mapAddWeathersToState(AddWeathers event) async* {
    if (currentState is WeathersLoaded) {
      if(!_checkOverlapWeather((currentState as WeathersLoaded).weathers, event.weather)){
        if(_checkMaximumWeather((currentState as WeathersLoaded).weathers, event.weather)) {
          List.from((currentState as WeathersLoaded).weathers)..removeAt(0);
        }
        final List<StoredWeather> updatedWeathersList =
        List.from((currentState as WeathersLoaded).weathers)..add(event.weather);
        yield WeathersLoaded(updatedWeathersList);
        _saveWeathers(updatedWeathersList);
      }
    }
  }

//  Stream<FileState> _mapUpdateTodoToState(UpdateWeathers event) async* {
//    if (currentState is TodosLoaded) {
//      final List<Todo> updatedTodos =
//      (currentState as TodosLoaded).todos.map((todo) {
//        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
//      }).toList();
//      yield TodosLoaded(updatedTodos);
//      _saveTodos(updatedTodos);
//    }
//  }
//
//  Stream<FileState> _mapDeleteTodoToState(DeleteTodo event) async* {
//    if (currentState is TodosLoaded) {
//      final updatedTodos = (currentState as TodosLoaded)
//          .todos
//          .where((todo) => todo.id != event.todo.id)
//          .toList();
//      yield TodosLoaded(updatedTodos);
//      _saveTodos(updatedTodos);
//    }
//  }
//
//  Stream<TodosState> _mapToggleAllToState() async* {
//    if (currentState is TodosLoaded) {
//      final allComplete =
//      (currentState as TodosLoaded).todos.every((todo) => todo.complete);
//      final List<Todo> updatedTodos = (currentState as TodosLoaded)
//          .todos
//          .map((todo) => todo.copyWith(complete: !allComplete))
//          .toList();
//      yield TodosLoaded(updatedTodos);
//      _saveTodos(updatedTodos);
//    }
//  }
//
//  Stream<TodosState> _mapClearCompletedToState() async* {
//    if (currentState is TodosLoaded) {
//      final List<Todo> updatedTodos = (currentState as TodosLoaded)
//          .todos
//          .where((todo) => !todo.complete)
//          .toList();
//      yield TodosLoaded(updatedTodos);
//      _saveTodos(updatedTodos);
//    }
//  }

  Future _saveWeathers(List<StoredWeather> weathers) {
    return fileRepository.saveTodos(
        weathers.map((weather) => weather.toEntity()).toList(),
    );
  }

  bool _checkOverlapWeather(List<StoredWeather> list, StoredWeather weather) {
    if(list.length > 0) {
      for(var data in list) {
        if(data.location == weather.location && data.date == weather.date) {
          return true;
        }
      }
    }
    return false;
  }

  bool _checkMaximumWeather(List<StoredWeather> list, StoredWeather weather) {
   if(list.length != 20) {
     return false;
   }
   return true;
  }
}