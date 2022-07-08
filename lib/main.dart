import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_todo/blocs/todos/todos_bloc.dart';
import 'package:k_todo/models/todo_model.dart';
import 'package:k_todo/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodo(
                todos: [
                  Todo(
                    id: 1,
                    title: 'Eat Breakfast',
                    description: 'Must eat vegetables!',
                    isCompleted: false,
                  ),
                  Todo(
                    id: 2,
                    title: 'Eat Lunch',
                    description: 'Must eat meat and soups!',
                    isCompleted: false,
                  ),
                ],
              ),
            ),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
