// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo_modular/src/todo/todo_state.dart';

class TodoModel {
  String title;
  String description;
  DateTime createAt;
  DateTime completedAt;
  DateTime finishAt;
  TodoState state;

  TodoModel({
    required this.title,
    required this.description,
    required this.createAt,
    required this.completedAt,
    required this.finishAt,
    required this.state,
  });
}
