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
  final VoidCallback onChecked;

  const TodoWidget({
    Key? key,
    required this.todo,
    required this.onChecked,
  }) : super(key: key);

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();

    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
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
                  controller.play();
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
