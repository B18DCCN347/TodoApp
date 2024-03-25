import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/utils/constanst.dart';

///
import '../../../models/task.dart';
import '../../../utils/colors.dart';
import '../../../view/tasks/task_view.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  // ignore: library_private_types_in_public_api
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController taskControllerForTitle = TextEditingController();
  TextEditingController taskControllerForSubtitle = TextEditingController();
  List<String> list = [];
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    list = StatusTask.values.map((e) => e.name).toList();

    taskControllerForTitle.text = widget.task.title;
    taskControllerForSubtitle.text = widget.task.subtitle;
    dropdownValue = list.first;
  }

  @override
  void dispose() {
    taskControllerForTitle.dispose();
    taskControllerForSubtitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => TaskView(
              taskControllerForTitle: taskControllerForTitle,
              taskControllerForSubtitle: taskControllerForSubtitle,
              task: widget.task,
            ),
          ),
        );
      },

      /// Main Card
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: widget.task.statusTask == StatusTask.completed.name
                ? const Color.fromARGB(154, 119, 144, 229)
                : Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        child: ListTile(
          /// Check icon
          ///
          trailing: DropdownMenu<String>(
            width: 150,
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            initialSelection: widget.task.statusTask,
            onSelected: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
                for (var status in StatusTask.values) {
                  if (status.name == value) {
                    widget.task.statusTask = status.name;
                  }
                }

                widget.task.save();
              });
            },
            dropdownMenuEntries:
                list.map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
          leading: GestureDetector(
            onTap: () {
              widget.task.pinedTask = !widget.task.pinedTask;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                  color: widget.task.pinedTask ? Colors.green : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: .8)),
              child: const Icon(
                Icons.push_pin,
                color: Colors.white,
              ),
            ),
          ),

          /// title of Task
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              taskControllerForTitle.text,
              style: TextStyle(
                  color: widget.task.statusTask == StatusTask.completed.name
                      ? MyColors.primaryColor
                      : Colors.black,
                  fontWeight: FontWeight.w500,
                  decoration:
                      widget.task.statusTask == StatusTask.completed.name
                          ? TextDecoration.lineThrough
                          : null),
            ),
          ),

          /// Description of task
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskControllerForSubtitle.text,
                style: TextStyle(
                  color: widget.task.statusTask == StatusTask.completed.name
                      ? MyColors.primaryColor
                      : const Color.fromARGB(255, 164, 164, 164),
                  fontWeight: FontWeight.w300,
                  decoration:
                      widget.task.statusTask == StatusTask.completed.name
                          ? TextDecoration.lineThrough
                          : null,
                ),
              ),

              /// Date & Time of Task
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                    top: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        // TimeOfDayFormat('hh:mm a').format(widget.task.createdAtTime),
                        widget.task.createdAtTime.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.task.statusTask ==
                                    StatusTask.completed.name
                                ? Colors.white
                                : Colors.grey),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createdAtDate),
                        style: TextStyle(
                            fontSize: 12,
                            color: widget.task.statusTask ==
                                    StatusTask.completed.name
                                ? Colors.white
                                : Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
