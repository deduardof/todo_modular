import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:todo_modular/src/services/todos_service.dart';
import 'package:todo_modular/src/todo/todo_model.dart';
import 'package:todo_modular/src/todo/todo_state.dart';

class TodoModal extends StatefulWidget {
  const TodoModal({super.key});

  @override
  State<TodoModal> createState() => _TodoModalState();
}

class _TodoModalState extends State<TodoModal> {
  DateFormat df = DateFormat('dd/MM/y');
  DateFormat tf = DateFormat('HH:mm');
  DateTime finishAt = DateTime.now().copyWith(second: 0, millisecond: 0, microsecond: 0);
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: Text(
                'Cadastrar atividade',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              )),
              IconButton(
                onPressed: () {
                  Modular.to.pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: true,
            decoration: const InputDecoration(
              label: Text('Título'),
            ),
            onChanged: (value) => title = value,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Descrição'),
            ),
            onChanged: (value) => description = value,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 10),
              const Text('Concluir até: '),
              TextButton.icon(
                onPressed: () async {
                  final today = DateTime.now();
                  final selectedDate = await showDatePicker(
                    context: context,
                    firstDate: today.subtract(const Duration(days: 365)),
                    lastDate: today.add(const Duration(days: 1000)),
                    currentDate: finishAt,
                    locale: const Locale('pt', 'BR'),
                  );

                  if (selectedDate != null) {
                    setState(() {
                      finishAt = selectedDate;
                    });
                  }
                },
                label: Text(
                  df.format(finishAt),
                ),
                icon: const Icon(Icons.calendar_month_outlined),
              ),
              TextButton.icon(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(finishAt),
                  );

                  if (selectedTime != null) {
                    setState(() {
                      finishAt = finishAt.copyWith(hour: selectedTime.hour, minute: selectedTime.minute);
                    });
                  }
                },
                label: Text(
                  tf.format(finishAt),
                ),
                icon: const Icon(Icons.schedule_outlined),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () {
                  if (title.isNotEmpty) {
                    final todo = TodoModel(
                      title: title,
                      description: description,
                      createAt: DateTime.now(),
                      completedAt: finishAt,
                      finishAt: finishAt,
                      state: TodoState.created,
                    );
                    context.read<TodosService>().add(todo: todo);
                    Modular.to.pop();
                  }
                },
                style: FilledButton.styleFrom(
                    minimumSize: const Size(200, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                child: const Text('Salvar'),
              )
            ],
          )
        ],
      ),
    );
  }
}
