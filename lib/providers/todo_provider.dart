// providers/todo_provider.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

enum TodoFilter { all, completed, pending }

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  String _searchQuery = '';
  TodoFilter _currentFilter = TodoFilter.all;
  TodoCategory? _selectedCategory;

  List<Todo> get filteredTodos {
    return _todos.where((todo) {
      final matchesSearch = _searchQuery.isEmpty ||
          todo.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (todo.description?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);

      final matchesCategory = _selectedCategory == null || todo.category == _selectedCategory;

      final matchesCompletion = _currentFilter == TodoFilter.all ||
          (_currentFilter == TodoFilter.completed && todo.isCompleted) ||
          (_currentFilter == TodoFilter.pending && !todo.isCompleted);

      return matchesSearch && matchesCategory && matchesCompletion;
    }).toList();
  }

  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  TodoFilter get currentFilter => _currentFilter;
  set currentFilter(TodoFilter value) {
    _currentFilter = value;
    notifyListeners();
  }

  TodoCategory? get selectedCategory => _selectedCategory;
  set selectedCategory(TodoCategory? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((t) => t.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  void refreshTodos() {
    notifyListeners();
  }

  // Load sample data (for demo purposes)
  void loadSampleData() {
    _todos = [
      Todo(
        id: '1',
        title: 'Buy groceries',
        description: 'Milk, eggs, bread, fruits',
        dueDate: DateTime.now().add(Duration(days: 1)),
        category: TodoCategory.personal,
      ),
      Todo(
        id: '2',
        title: 'Finish Flutter project',
        description: 'Implement all features and test',
        dueDate: DateTime.now().add(Duration(days: 3)),
        category: TodoCategory.work,
      ),
      Todo(
        id: '3',
        title: 'Call mom',
        dueDate: DateTime.now().subtract(Duration(days: 1)),
        category: TodoCategory.personal,
        isCompleted: true,
      ),
      Todo(
        id: '4',
        title: 'Pay electricity bill',
        dueDate: DateTime.now().add(Duration(days: 5)),
        category: TodoCategory.urgent,
      ),
    ];
    notifyListeners();
  }
}