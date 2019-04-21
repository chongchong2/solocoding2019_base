
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


@immutable
class StoredWeather extends Equatable {
  final String location;
  final String current_temp;
  final String max_temp;
  final String min_temp;
  final String date;

  StoredWeather({this.location, this.current_temp, this.max_temp, this.min_temp, this.date})
      : super([location, current_temp, max_temp, min_temp, date]);

//  StoredWeather copyWith({bool complete, String id, String note, String task}) {
//    return StoredWeather(
//      task ?? this.task,
//      complete: complete ?? this.complete,
//      id: id ?? this.id,
//      note: note ?? this.note,
//    );
//  }

//  @override
//  String toString() {
//    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
//  }

  StoredWeatherEntity toEntity() {
    return StoredWeatherEntity(location, current_temp, max_temp, min_temp, date);
  }

  static StoredWeather fromEntity(StoredWeatherEntity entity) {
    return StoredWeather(
      location : entity.location,
      current_temp: entity.current_temp,
      max_temp: entity.max_temp,
      min_temp: entity.min_temp,
      date: entity.date
    );
  }
}




class StoredWeatherEntity {
  final String location;
  final String current_temp;
  final String max_temp;
  final String min_temp;
  final String date;

  StoredWeatherEntity(this.location, this.current_temp, this.max_temp, this.min_temp, this.date);


//  @override
//  bool operator ==(Object other) =>
//      identical(this, other) ||
//          other is StoredWeatherEntity &&
//              runtimeType == other.runtimeType &&
//              complete == other.complete &&
//              task == other.task &&
//              note == other.note &&
//              id == other.id;

  Map<String, Object> toJson() {
    return {
      "location": location,
      "current_temp": current_temp,
      "max_temp": max_temp,
      "min_temp": min_temp,
      "date": date
    };
  }

//  @override
//  String toString() {
//    return 'StoredWeatherEntity{complete: $complete, task: $task, note: $note, id: $id}';
//  }

  static StoredWeatherEntity fromJson(Map<String, Object> json) {
    return StoredWeatherEntity(
      json["location"] as String,
      json["current_temp"] as String,
      json["max_temp"] as String,
      json["min_temp"] as String,
      json["date"] as String
    );
  }
}
