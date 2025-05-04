// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/todo.dart';
import '../models/user.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import 'add_todo_screen.dart';
import 'todo_details_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;

  const HomeScreen({required this.userEmail, Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  bool _showSearchBar = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    final user = User(email: widget.userEmail);
    final filteredTodos = todoProvider.filteredTodos;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: _showSearchBar ? null : Text('CheckMe'),
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileScreen(user: user),
              ),
            ),
            child: Hero(
              tag: 'user_avatar',
              child: CircleAvatar(
                backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                child: Text(
                  user.displayName[0].toUpperCase(),
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_showSearchBar ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _showSearchBar = !_showSearchBar;
                if (!_showSearchBar) {
                  _searchController.clear();
                  todoProvider.searchQuery = '';
                }
              });
            },
          ),
          PopupMenuButton<TodoFilter>(
            icon: Icon(Icons.filter_list),
            onSelected: (filter) {
              todoProvider.currentFilter = filter;
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: TodoFilter.all,
                child: Text('All Tasks'),
              ),
              PopupMenuItem(
                value: TodoFilter.completed,
                child: Text('Completed'),
              ),
              PopupMenuItem(
                value: TodoFilter.pending,
                child: Text('Pending'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          if (_showSearchBar)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant,
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                ),
                onChanged: (query) {
                  todoProvider.searchQuery = query;
                },
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
                todoProvider.refreshTodos();
              },
              child: filteredTodos.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 80,
                      color: theme.colorScheme.primary.withOpacity(0.3),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No tasks found',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.only(top: 8, bottom: 80),
                itemCount: filteredTodos.length,
                itemBuilder: (context, index) {
                  final todo = filteredTodos[index];
                  return TodoItem(
                    todo: todo,
                    onTap: () => _navigateToDetails(todo),
                    onToggle: (value) => todoProvider.updateTodo(
                        todo.copyWith(isCompleted: value)),
                    onDelete: () => todoProvider.deleteTodo(todo.id),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddTodo,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToAddTodo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddTodoScreen()),
    );

    if (result != null && result is Todo) {
      Provider.of<TodoProvider>(context, listen: false).addTodo(result);
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _navigateToDetails(Todo todo) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TodoDetailsScreen(todo: todo)),
    );

    if (result != null && result is Todo) {
      Provider.of<TodoProvider>(context, listen: false).updateTodo(result);
    }
  }
}