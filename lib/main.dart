import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/presentation/todo_screen.dart';
import 'package:todo_app/todo_cubit/todo_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return BlocProvider(
          create: (context) => TodoCubit(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: TodoScreen(),
          ),
        );
      },
    );
  }
}
