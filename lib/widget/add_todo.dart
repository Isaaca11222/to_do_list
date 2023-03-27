import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/model/todo.dart';
import 'package:to_do_list/provider/todos.dart';
import 'package:to_do_list/widget/todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  const AddTodoDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodoDialogWidget> createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Add Todo',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close),
              color: Colors.orange,
            ),
          ],
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo: addTodo,
              ),
            ],
          ),
        ),
      );

  void addTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        createdTime: DateTime.now(),
        title: title,
        description: description,
        id: DateTime.now().toString(),
      );

      final provider =
          Provider.of<TodosProvider>(context, listen: false).addTodo(todo);

      Navigator.of(context).pop();
    }
  }
}
