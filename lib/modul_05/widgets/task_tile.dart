import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, required this.onToggle});

  final Task task;
  final ValueChanged<Task> onToggle;

  String _labelPrioritas(int prioritas) {
    switch (prioritas) {
      case 1:
        return 'Tinggi';
      case 2:
        return 'Sedang';
      default:
        return 'Rendah';
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;
    final DateTime? tanggal = DateTime.tryParse(task.createdAt);

    return Card(
      child: CheckboxListTile(
        value: task.done,
        onChanged: (_) => onToggle(task),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Row(
          children: <Widget>[
            Text(task.id),
            Icon(Icons.flag, size: 14, color: warna.primary),
            const SizedBox(width: 4),
            Text(_labelPrioritas(task.prioritas)),
            const SizedBox(width: 12),
            Icon(Icons.book, size: 14, color: warna.secondary),
            const SizedBox(width: 4),
            Text(task.course),
            if (tanggal != null) ...[
              const SizedBox(width: 12),
              Icon(Icons.calendar_today, size: 14, color: warna.secondary),
              const SizedBox(width: 4),
              Text('${tanggal.day}/${tanggal.month}/${tanggal.year}'),
            ],
          ],
        ),
      ),
    );
  }
}