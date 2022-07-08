import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_todo/models/todo_model.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    on<LoadTodo>(_onLoadTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<AddTodo>(_onAddTodo);
  }

  void _onLoadTodo(LoadTodo event, Emitter<TodosState> emit) {
    emit(
      TodosLoaded(todos: event.todos),
    );
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.map((todo) => todo).toList();
      todos.add(event.todo);
      emit(
        TodosLoaded(todos: todos),
      );
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos
          .map((todo) => todo.id == event.todo.id ? event.todo : todo)
          .toList();
      emit(
        TodosLoaded(todos: todos),
      );
    }
  }
}
