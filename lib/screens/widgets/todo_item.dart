import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/todos/todos_bloc.dart';
import '../../models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  void toggleTodo(BuildContext context) {
    context.read<TodosBloc>().add(
          UpdateTodo(
            todo: todo.copyWith(
              isCompleted: !todo.isCompleted,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // Todo Item's style
    TextStyle style = TextStyle(
        decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        color: todo.isCompleted ? Colors.grey : null);

    return ListTile(
      onTap: () => toggleTodo(context),
      onLongPress: () {
        showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                height: 100,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text("Delete"),
                      onTap: () {
                        context.read<TodosBloc>().add(DeleteTodo(todo: todo));
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            });
      },
      leading: FittedBox(
          child: Text(
        "#${todo.id}",
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: todo.isCompleted ? Colors.grey : null),
      )),
      title: Text(
        "${todo.title}",
        style: style,
      ),
      subtitle: Text(
        "${todo.description}",
        style: style,
      ),
      trailing: todo.isCompleted
          ? const Icon(Icons.check_circle_outline_rounded)
          : null,
    );
  }
}
