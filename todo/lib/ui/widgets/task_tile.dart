import 'package:flutter/material.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({Key? key, required this.task}) : super(key: key);
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      width: SizeConfig.orientation == Orientation.landscape
          ? SizeConfig.screenWidth / 2
          : SizeConfig.screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: _getTaskClr(task.color),
      ),
      child: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 18,
                        color: Colors.grey[200],
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${task.startTime} - ${task.endTime}',
                        style: TextStyle(fontSize: 16, color: Colors.grey[100]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task.note!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[100]),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 0.5,
              height: 60,
              color: Colors.grey[200],
            ),
            RotatedBox(
              quarterTurns: 1,
              child: Text(
                task.isCompleted == 0 ? 'TODO' : 'Completed',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color? _getTaskClr(int? color) {
  switch (color) {
    case 0:
      return primaryClr;
    case 1:
      return pinkClr;
    case 2:
      return orangeClr;
  }
  return null;
}
