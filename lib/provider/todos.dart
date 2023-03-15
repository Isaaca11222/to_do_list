import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: "Walk the dog ♥",
      description: '',
      id: '',
    ),
    Todo(
      createdTime: DateTime.now(),
      title: "Plan birthday party",
      description: '''
      -Buy flowers
      -Rent a car
      -Make cake
      ''',
      id: '',
    ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }
}
