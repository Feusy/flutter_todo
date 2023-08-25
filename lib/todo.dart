import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Go to Gym', isDone: true),
      Todo(id: '02', todoText: 'Buy food'),
      Todo(id: '03', todoText: 'Check emails', isDone: true),
      Todo(id: '04', todoText: 'Meeting with the team'),
      Todo(id: '05', todoText: 'Learn the stuff'),
      Todo(id: '06', todoText: 'Eat the meat'),
      Todo(id: '07', todoText: 'Call George'),
      Todo(id: '08', todoText: 'Get results'),
    ];
  }
}
