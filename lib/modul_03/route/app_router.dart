import 'package:flutter_2/modul_03/screens/add_krs_screen.dart';
import 'package:flutter_2/modul_03/screens/course_detail_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../screens/krs_list_screen.dart';
import '../models/krs_course.dart';

final modul03Router = GoRouter(
  initialLocation: '/modul-03',
  routes: [
    GoRoute(
      path: '/modul-03',
      builder: (context, state) => const KrsListScreen(),
      routes: [
        GoRoute(path: 'add', builder: (context, state) => const AddKrsScreen()),
        GoRoute(
          path: 'detail/:code',
          builder: (context, state) {
            final course = state.extra as KrsCourse?;
            if (course == null) {
              return const Scaffold(
                body: Center(child: Text('Mata kuliah tidak ditemukan.')),
              );
            }
            return CourseDetailScreen(course: course);
          },
        ),
      ],
    ),
  ],
);
