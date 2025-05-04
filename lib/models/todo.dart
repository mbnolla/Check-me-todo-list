// models/todo.dart
import 'package:flutter/material.dart';

enum TodoCategory { personal, work, school, urgent, other }

extension TodoCategoryExtension on TodoCategory {
  String get name {
    switch (this) {
      case TodoCategory.personal:
        return 'Personal';
      case TodoCategory.work:
        return 'Work';
      case TodoCategory.school:
        return 'School';
      case TodoCategory.urgent:
        return 'Urgent';
      case TodoCategory.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case TodoCategory.personal:
        return Colors.blue;
      case TodoCategory.work:
        return Colors.green;
      case TodoCategory.school:
        return Colors.purple;
      case TodoCategory.urgent:
        return Colors.red;
      case TodoCategory.other:
        return Colors.grey;
    }
  }
}

class Todo {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TodoCategory category;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    this.description,
    DateTime? createdAt,
    this.dueDate,
    this.category = TodoCategory.personal,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isOverdue {
    return dueDate != null && !isCompleted && dueDate!.isBefore(DateTime.now());
  }
}
extension TodoCopyWith on Todo {
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? dueDate,
    TodoCategory? category,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}