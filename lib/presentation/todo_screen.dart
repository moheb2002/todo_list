import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/todo_cubit/todo_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; 

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[200]!, Colors.teal[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0.w),  
          child: BlocBuilder<TodoCubit, TodoState>(
            builder: (context, state) {
              if (state is TodoInitial) {
                return Center(
                  child: Text(
                    'No todos yet.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp, 
                    ),
                  ),
                );
              } else if (state is TodoLoaded) {
                return ListView.separated(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return Card(
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r), 
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            fontSize: 18.sp, 
                            fontWeight: FontWeight.w500,
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: todo.isCompleted ? Colors.grey : Colors.black,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<TodoCubit>().removeTodo(index);
                          },
                        ),
                        leading: Checkbox(
                          value: todo.isCompleted,
                          activeColor: Colors.teal,
                          onChanged: (value) {
                            context
                                .read<TodoCubit>()
                                .toggleTodoCompletion(index);
                          },
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 12.h), 
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            context.read<TodoCubit>().addTodo(_controller.text);
            _controller.clear();
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
        child: TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Add Todo',
            labelStyle: TextStyle(color: Colors.teal, fontSize: 16.sp), 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r), 
              borderSide: const BorderSide(color: Colors.teal),
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 15.w,
            ),  
          ),
        ),
      ),
    );
  }
}
