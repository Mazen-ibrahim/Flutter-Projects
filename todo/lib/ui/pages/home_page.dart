import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/ui/pages/add_task_page.dart';
import 'package:todo/ui/size_config.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskController _taskController = Get.find<TaskController>();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _taskController.filterTasks();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          //Add Task Bar
          _addTaskBar(context),

          //Add Date Bar
          _addDateBar(context),

          //Sized Box
          const SizedBox(height: 6),

          // Show Tasks
          _showTasks(),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
        },
        icon: Icon(
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
        ),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Container _addTaskBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text("Today", style: Theme.of(context).textTheme.titleLarge),
            ],
          ),

          Button(
            label: "Add Task",
            onTap: () async {
              await Get.to(() => const AddTaskPage());
            },
          ),
        ],
      ),
    );
  }

  Container _addDateBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      child: DatePicker(
        DateTime.now(),
        width: 90,
        height: 110,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        dayTextStyle: Theme.of(context).textTheme.titleMedium!,
        monthTextStyle: Theme.of(context).textTheme.titleMedium!,
        dateTextStyle: Theme.of(context).textTheme.titleLarge!,
        onDateChange: (DateTime datetime) {
          setState(() {
            _selectedDate = datetime;
          });
        },
      ),
    );
  }

  Stack _noTaskMsg(BuildContext context) {
    return Stack(
      children: [
        OrientationBuilder(
          builder: (context, orientation) => ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: SizeConfig.screenHeight -
                  (SizeConfig.orientation == Orientation.landscape
                      ? SizeConfig.screenHeight * 0.75
                      : SizeConfig.screenHeight * 0.26),
            ),
            child: SingleChildScrollView(
                scrollDirection: orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                child: Wrap(
                  direction: orientation == Orientation.landscape
                      ? Axis.horizontal
                      : Axis.vertical,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    orientation == Orientation.landscape
                        ? const SizedBox(height: 10)
                        : const SizedBox(height: 150),
            
                    SvgPicture.asset(
                      "images/task.svg",
                      height: 90,
                      color: primaryClr,
                    ),
            
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "You do not have any Tasks yet!\nAdd new tasks to make your days productive.",
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: (SizeConfig.orientation == Orientation.landscape)
              ? (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.6
                    : SizeConfig.screenHeight * 0.8)
              : (task.isCompleted == 1
                    ? SizeConfig.screenHeight * 0.30
                    : SizeConfig.screenHeight * 0.39),
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (task.isCompleted == 0) ...[
                _buildBottomSheet(
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markAsCompleted(task);
                    Get.back();
                  },
                  clr: primaryClr,
                ),
              ],
              _buildBottomSheet(
                label: "Delete Task",
                onTap: () {
                  _taskController.deleteTask(task);
                  Get.back();
                },
                clr: Colors.red[300]!,
              ),
              Divider(
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                height: 20,
              ),
              _buildBottomSheet(
                label: "Close",
                onTap: () {
                  Get.back();
                },
                clr: const Color.fromARGB(255, 201, 69, 67),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _buildBottomSheet({
    required String label,
    required Function()? onTap,
    required Color clr,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: clr),
          borderRadius: BorderRadius.circular(20),
          color: clr,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Obx _showTasks() {
    return Obx(() {
      if (_taskController.taskList.isEmpty) {
        return _noTaskMsg(context);
      } else {
        return Expanded(
          child: OrientationBuilder(
            builder: (context, orientation) => 
             ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (BuildContext context, int index) {
                if (_taskController.taskList[index].date ==
                        DateFormat.yMd().format(_selectedDate) ||
                    _taskController.taskList[index].repeat == "Daily") {
                  return GestureDetector(
                    onTap: () => _showBottomSheet(
                      context,
                      _taskController.taskList[index],
                    ),
                    child: TaskTile(task: _taskController.taskList[index]),
                  );
                }
                if (_taskController.taskList[index].repeat == "Weekly" &&
                    _selectedDate
                                .difference(
                                  DateFormat.yMd().parse(
                                    _taskController.taskList[index].date!,
                                  ),
                                )
                                .inDays %
                            7 ==
                        0) {
                  return GestureDetector(
                    onTap: () => _showBottomSheet(
                      context,
                      _taskController.taskList[index],
                    ),
                    child: TaskTile(task: _taskController.taskList[index]),
                  );
                }
                if (_taskController.taskList[index].repeat == "Monthly" &&
                    DateFormat.yMd()
                            .parse(_taskController.taskList[index].date!)
                            .day ==
                        _selectedDate.day) {
                  return GestureDetector(
                    onTap: () => _showBottomSheet(
                      context,
                      _taskController.taskList[index],
                    ),
                    child: TaskTile(task: _taskController.taskList[index]),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        );
      }
    });
  }
}
