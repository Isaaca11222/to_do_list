import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/provider/todos.dart';
import 'package:to_do_list/widget/todo_widget.dart';

class CompletedListWidget extends StatelessWidget {
  const CompletedListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? const Center(
            child: Text(
              'No completed tasks',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(
                todo: todo,
                onChecked: () {},
              );
            });
  }
}
