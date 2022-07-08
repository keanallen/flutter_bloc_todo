import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_todo/blocs/todos/todos_bloc.dart';
import 'package:k_todo/screens/add_todo_screen.dart';

import '../models/todo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppBar
    var appBar = AppBar(
      actions: [
        IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewTodo(),
              )),
          icon: const Icon(Icons.add_task),
        ),
      ],
    );

    // Main View
    return Scaffold(
      appBar: appBar,
      body: _toDos(),
    );
  }

  BlocBuilder<TodosBloc, TodosState> _toDos() {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TodosLoaded) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tasks"),
                ),
                if (state.todos.isEmpty) const Text("No To Do's found!"),
                if (state.todos.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 0),
                      itemCount: state.todos.length,
                      itemBuilder: (context, index) => TodoItem(
                        todo: state.todos[index],
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const Text("Something went wrong.");
        }
      },
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        showBottomSheet(
            context: context,
            builder: (context) {
              return BlocListener<TodosBloc, TodosState>(
                listener: (context, state) {
                  if (state is TodosLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task Deleted"),
                      ),
                    );
                  }
                },
                child: Container(
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
                ),
              );
            });
      },
      leading: FittedBox(
          child: Text(
        "#${todo.id}",
        style: Theme.of(context).textTheme.headline6,
      )),
      title: Text(
        "${todo.title}",
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Text(
        "${todo.description}",
        style: TextStyle(
          decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (val) {
          context.read<TodosBloc>().add(
                UpdateTodo(
                  todo: todo.copyWith(
                    isCompleted: !todo.isCompleted,
                  ),
                ),
              );
        },
      ),
    );
  }
}
