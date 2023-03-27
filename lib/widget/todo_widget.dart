import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/provider/todos.dart';
import 'package:to_do_list/utils.dart';
import 'package:to_do_list/pages/edit_todo_page.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;

  const TodoWidget({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 6));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          key: Key(widget.todo.id),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => editTodo(context, widget.todo),
                backgroundColor: Colors.green,
                label: 'Edit',
                icon: Icons.edit,
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => deleteTodo(context, widget.todo),
                backgroundColor: Colors.red,
                label: 'Delete',
                icon: Icons.delete,
              ),
            ],
          ),
          child: buildTodo(context),
        ),
      );

  Widget buildTodo(BuildContext context) => Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.green,
              checkColor: Colors.white,
              value: widget.todo.isDone,
              onChanged: (bool? value) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(widget.todo);
                if (value == true && isDone) {
                  _confettiController.play();
                }

                Utils.showSnackBar(context,
                    isDone ? 'Task completed' : "Task marked incomplete");
              },
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.todo.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 22,
                    ),
                  ),
                  if (widget.todo.description.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: Text(widget.todo.description,
                          style: const TextStyle(fontSize: 20, height: 1.5)),
                    )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _confettiController.play();
              },
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                particleDrag:
                    0.05, // wartość 0 oznacza brak oporu, wartość 1 oznacza dużo oporu
                emissionFrequency: 0.05, // częstotliwość emisji konfetti
                numberOfParticles: 20, // liczba konfetti
                gravity:
                    0.05, // wartość 0 oznacza brak grawitacji, wartość 1 oznacza dużo grawitacji
                shouldLoop: true,
              ),
            ), // czy konfetti powinno działać w
          ],
        ),
      );

  void deleteTodo(BuildContext context, Todo todo) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    provider.removeTodo(widget.todo);

    Utils.showSnackBar(context, 'Delete the task');
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: widget.todo),
        ),
      );
}
