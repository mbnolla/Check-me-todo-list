// screens/add_todo_screen.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

class AddTodoScreen extends StatefulWidget {
  @override
  _AddTodoScreenState createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _dueDate;
  TodoCategory _selectedCategory = TodoCategory.personal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveTodo,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title*',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  _dueDate == null
                      ? 'Select due date (optional)'
                      : 'Due date: ${_formatDate(_dueDate!)}',
                ),
                trailing: _dueDate != null
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () => setState(() => _dueDate = null),
                )
                    : null,
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    setState(() => _dueDate = selectedDate);
                  }
                },
              ),
              SizedBox(height: 16),
              Text('Category', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: TodoCategory.values.map((category) {
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: _selectedCategory == category,
                    onSelected: (_) => setState(() => _selectedCategory = category),
                    selectedColor: category.color.withOpacity(0.3),
                    backgroundColor: category.color.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: _selectedCategory == category
                          ? category.color
                          : Colors.black,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        dueDate: _dueDate,
        category: _selectedCategory,
      );
      Navigator.pop(context, newTodo);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}