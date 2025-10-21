import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';
import 'package:todo/ui/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.find<TaskController>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _endTime = DateFormat(
    "hh:mm a",
  ).format(DateTime.now().add(const Duration(minutes: 20))).toString();
  DateTime _selectedDate = DateTime.now();
  int selectedRemind = 5;
  int selectedRemindIndex = 1;
  List<int> remindList = [0, 5, 10, 15, 20];
  String selectedRepeat = 'None';
  int selectedRepeatIndex = 1;
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  List<Color> selectedColorlist = [primaryClr, pinkClr, orangeClr];
  int selectedColor = 0;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Add Task", style: Theme.of(context).textTheme.displaySmall),
              InputField(
                title: "Title",
                hint: "Enter Title here",
                controller: _titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter Note here",
                controller: _noteController,
              ),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                icon: IconButton(
                  onPressed: () => _getDateFromUser(),
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: _startTime,
                      icon: IconButton(
                        onPressed: () => _getTimeFromUser(true),
                        icon: Icon(
                          Icons.access_time_filled_rounded,
                          color: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: InputField(
                      title: "End Time",
                      hint: _endTime,
                      icon: IconButton(
                        onPressed: () => _getTimeFromUser(false),
                        icon: Icon(
                          Icons.access_time_filled_rounded,
                          color: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                title: "Remind",
                hint: '$selectedRemind minutes early',
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRemind = remindList[selectedRemindIndex++];
                      if (selectedRemindIndex == remindList.length) {
                        selectedRemindIndex = 0;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    size: 24,
                  ),
                ),
              ),
              InputField(
                title: "Repeat",
                hint: selectedRepeat,
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      selectedRepeat = repeatList[selectedRepeatIndex++];
                      if (selectedRepeatIndex == repeatList.length) {
                        selectedRepeatIndex = 0;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _color(),
                  Button(
                    label: 'Create Task',
                    onTap: () {
                      _validateData();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          size: 24,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
        ),
      ),
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Column _color() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color", style: Theme.of(context).textTheme.titleLarge),
        Wrap(
          children: List<Widget>.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: selectedColor == index
                      ? const Icon(Icons.done, size: 23, color: Colors.white)
                      : null,
                  backgroundColor: selectedColorlist[index],
                  radius: 15,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  void _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2121),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      log("It's null or something went wrong !");
    }
  }

  void _getTimeFromUser(bool isStartTime) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 20)),
            ),
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (_pickedTime != null) {
      String _formattedTime = _pickedTime.format(context);
      log("formatted time: $_formattedTime");
      setState(() {
        if (isStartTime) {
          _startTime = _formattedTime;
        } else {
          _endTime = _formattedTime;
        }
      });
    } else {
      log("It's null or something went wrong !");
    }
  }

  _addTasktoDB() async {
    await _taskController.addTask(
      Task(
        title: _titleController.text,
        note: _noteController.text,
        isCompleted: 0,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: selectedColor,
        remind: selectedRemind,
        repeat: selectedRepeat,
      ),
    );
  }

  void _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasktoDB();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "Some fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.grey[800] : Colors.white,
        colorText: Get.isDarkMode ? Colors.white : Colors.redAccent,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Get.isDarkMode ? Colors.white : Colors.red,
        ),
      );
    } else {
      log("Something went wrong !");
    }
  }
}
