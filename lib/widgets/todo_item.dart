// widgets/todo_item.dart
import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(bool) onToggle;
  final Function() onDelete;
  final Function()? onTap;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      confirmDismiss: (_) async {
        return await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this todo?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) => onToggle(value ?? false),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          color: todo.isCompleted
                              ? Colors.grey
                              : null,
                        ),
                      ),
                      if (todo.description != null && todo.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            todo.description!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              decoration: todo.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ),
                      if (todo.dueDate != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: todo.isOverdue
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Due ${_formatDate(todo.dueDate!)}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: todo.isOverdue
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                              if (todo.isOverdue)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    '(Overdue)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: todo.category.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    todo.category.name,
                    style: TextStyle(
                      fontSize: 12,
                      color: todo.category.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final tomorrow = today.add(Duration(days: 1));
    final dueDate = DateTime(date.year, date.month, date.day);

    if (dueDate == today) return 'Today';
    if (dueDate == yesterday) return 'Yesterday';
    if (dueDate == tomorrow) return 'Tomorrow';
    if (dueDate.isBefore(today)) {
      return '${date.day}/${date.month}/${date.year}';
    }
    return '${date.day}/${date.month}/${date.year}';
  }
}