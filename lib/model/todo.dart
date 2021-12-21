import 'package:geolocator/geolocator.dart';

class Todo {
  int? id;
  String title;
  String description;
  bool isdone;
  String? pos;

  Todo(
      {this.id,
      required this.title,
      required this.description,
      required this.isdone,
      this.pos});
  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['description'] = description;
    map['isDone'] = isdone ? 1 : 0;
    map['pos'] = pos;

    return map;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isdone: map['isDone'] == 1,
      pos: map['pos'],
    );
  }
}
