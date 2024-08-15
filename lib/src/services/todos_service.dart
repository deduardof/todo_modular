import 'package:flutter/material.dart';
import 'package:todo_modular/src/todo/todo_model.dart';
import 'package:todo_modular/src/todo/todo_state.dart';

class TodosService extends ChangeNotifier {
  final List<TodoModel> _todos = [];
  bool _onlyActives = false;

  bool get showActives => _onlyActives;

  List<TodoModel> get todos =>
      (_onlyActives) ? _todos.where((todo) => todo.state == TodoState.created || todo.state == TodoState.started).toList() : _todos;

  void add({required TodoModel todo}) {
    _todos.add(todo);
    notifyListeners();
  }

  void finish({required int index, required TodoModel todo}) {
    _todos[index] = todo;
    notifyListeners();
  }

  void showHideNotActives() {
    _onlyActives = !_onlyActives;
    notifyListeners();
  }
}
