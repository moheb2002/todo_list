import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:todo_app/model/todo_model.dart';
part 'todo_state.dart';

abstract class TodoRepository {
  Future<void> loadTodos();
  Future<void> saveTodos(List<Todo> todos);
  void addTodo(String title);
  void toggleTodoCompletion(int index);
  void removeTodo(int index);
}

class TodoCubit extends Cubit<TodoState> implements TodoRepository {
  TodoCubit() : super(TodoInitial()) {
    loadTodos();
  }

  @override
  Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');

    if (todosString != null) {
      final List<dynamic> todosJson = jsonDecode(todosString);
      final todos = todosJson.map((json) => Todo.fromJson(json)).toList();
      emit(TodoLoaded(todos));
    } else {
      emit(TodoLoaded([]));
    }
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final String todosString =
        jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosString);
  }

  @override
  void addTodo(String title) {
    final todo = Todo(title: title, isCompleted: false);
    if (state is TodoLoaded) {
      final updatedTodos = List<Todo>.from((state as TodoLoaded).todos)..add(todo);
      emit(TodoLoaded(updatedTodos));
      saveTodos(updatedTodos);
    } else {
      emit(TodoLoaded([todo]));
      saveTodos([todo]);
    }
  }

  @override
  void toggleTodoCompletion(int index) {
    if (state is TodoLoaded) {
      final updatedTodos = List<Todo>.from((state as TodoLoaded).todos);
      updatedTodos[index] = updatedTodos[index].copyWith(
        isCompleted: !updatedTodos[index].isCompleted,
      );
      emit(TodoLoaded(updatedTodos));
      saveTodos(updatedTodos);
    }
  }

  @override
  void removeTodo(int index) {
    if (state is TodoLoaded) {
      final updatedTodos = List<Todo>.from((state as TodoLoaded).todos)..removeAt(index);
      emit(TodoLoaded(updatedTodos));
      saveTodos(updatedTodos);
    }
  }
}
