import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_todo/blocs/todos/todos_bloc.dart';
import 'package:k_todo/models/todo_model.dart';

class NewTodo extends StatelessWidget {
  const NewTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController idCtrl = TextEditingController();
    TextEditingController titleCtrl = TextEditingController();
    TextEditingController descriptionCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new To Do"),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("A new to do has been added!"),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _inputField(textController: idCtrl, label: "Task #"),
              _inputField(textController: titleCtrl, label: "Title"),
              _inputField(
                  textController: descriptionCtrl, label: "Description"),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  var todo = Todo(
                    id: int.parse(idCtrl.value.text),
                    title: titleCtrl.value.text,
                    description: descriptionCtrl.value.text,
                  );
                  context.read<TodosBloc>().add(AddTodo(todo: todo));
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Save Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextField _inputField(
      {required TextEditingController textController, required String label}) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(labelText: label),
    );
  }
}
