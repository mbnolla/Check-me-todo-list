// screens/todo_details_screen.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoDetailsScreen extends StatefulWidget {
  final Todo todo;

  const TodoDetailsScreen({required this.todo, Key? key}) : super(key: key);

  @override
  _TodoDetailsScreenState createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  late Todo _editedTodo;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _editedTodo = widget.todo;
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController = TextEditingController(
        text: widget.todo.description ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _editTodo,
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              children: [
                Checkbox(
                  value: _editedTodo.isCompleted,
                  onChanged: (value) => setState(() {
                    _editedTodo = _editedTodo.copyWith(
                        isCompleted: value ?? false);
                  }),
                ),
                Expanded(
                  child: Text(
                    _editedTodo.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: _editedTodo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_editedTodo.description != null && _editedTodo.description!.isNotEmpty)
              Text(
                _editedTodo.description!,
                style: TextStyle(fontSize: 16),
              ),
            Divider(height: 32),
            ListTile(
              leading: Icon(Icons.category),
              title: Text('Category'),
              trailing: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _editedTodo.category.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _editedTodo.category.name,
                  style: TextStyle(color: _editedTodo.category.color),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Created at'),
              trailing: Text(_formatDate(_editedTodo.createdAt)),
            ),
            if (_editedTodo.dueDate != null)
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: _editedTodo.isOverdue ? Colors.red : null,
                ),
                title: Text('Due date'),
                trailing: Text(
                  _formatDate(_editedTodo.dueDate!),
                  style: TextStyle(
                    color: _editedTodo.isOverdue ? Colors.red : null,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _editTodo() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _editedTodo = _editedTodo.copyWith(
                        title: _titleController.text,
                        description: _descriptionController.text.isEmpty
                            ? null
                            : _descriptionController.text,
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveChanges() {
    Navigator.pop(context, _editedTodo);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}