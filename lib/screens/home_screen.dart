import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_todo/blocs/todos/todos_bloc.dart';
import 'package:k_todo/screens/add_todo_screen.dart';

import 'widgets/todo_item.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AppBar
    var appBar = AppBar(
      title: const Text("To Dos"),
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
          return SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // No Todos
                if (state.todos.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text("No To Do's found!"),
                    ),
                  ),
                // Show Todos
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
