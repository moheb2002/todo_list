part of 'todo_cubit.dart';

abstract class TodoState {
  List<Todo> get todos => [];
}

class TodoInitial extends TodoState {}

class TodoLoaded extends TodoState {
  @override
  final List<Todo> todos;

  TodoLoaded(this.todos);
}
