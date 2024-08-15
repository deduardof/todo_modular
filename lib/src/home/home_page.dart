import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_modular/src/core/colors/app_colors.dart';
import 'package:todo_modular/src/services/todos_service.dart';
import 'package:todo_modular/src/todo/todo_modal.dart';
import 'package:todo_modular/src/todo/todo_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final todos = context.watch<TodosService>().todos;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas atividades'),
        actions: [
          PopupMenuButton<PopupMenuItem>(
            itemBuilder: (context) {
              final service = context.read<TodosService>();
              return [
                CheckedPopupMenuItem(
                  checked: !service.showActives,
                  child: const Text('Exibir atividades concluídas'),
                  onTap: () {
                    service.showHideNotActives();
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: (todos.isEmpty)
          ? Center(
              child: Text(
                'Não há atividades pendentes no momento.',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos.elementAt(index);
                return GestureDetector(
                  onTapDown: (details) async {
                    final offset = details.globalPosition;
                    final height = MediaQuery.sizeOf(context).height;
                    final width = MediaQuery.sizeOf(context).width;

                    await showMenu<TodoState>(
                      context: context,
                      position: RelativeRect.fromLTRB(offset.dx, offset.dy, width - offset.dx, height - offset.dy),
                      items: TodoState.values
                          .map((state) => PopupMenuItem<TodoState>(
                                //            value: state,
                                child: Text(state.name),
                                onTap: () => todo.state = state,
                              ))
                          .toList(),
                    );
                    print(todo.state.name);
                  },
                  child: CheckboxListTile(
                    title: Text(
                      todo.title,
                      style: TextStyle(decoration: (todo.state == TodoState.finished) ? TextDecoration.lineThrough : null),
                    ),
                    subtitle: Text(
                      todo.description,
                      style: TextStyle(decoration: (todo.state == TodoState.finished) ? TextDecoration.lineThrough : null),
                    ),
                    value: todo.state == TodoState.finished,
                    onChanged: (value) {
                      if (value != null) {
                        if (value) {
                          todo.completedAt = DateTime.now();
                          todo.state = TodoState.finished;
                        } else {
                          todo.state = TodoState.started;
                        }
                        context.read<TodosService>().finish(index: index, todo: todo);
                      }
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            backgroundColor: AppColors.background,
            builder: (context) => const TodoModal(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
