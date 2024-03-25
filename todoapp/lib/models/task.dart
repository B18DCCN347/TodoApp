import 'package:flutter/material.dart';
import 'package:todoapp/utils/constanst.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
    required this.statusTask,
    required this.pinedTask,
  });

  /// ID
  @HiveField(0)
  final String id;

  /// TITLE
  @HiveField(1)
  String title;

  /// SUBTITLE
  @HiveField(2)
  String subtitle;

  /// CREATED AT TIME
  @HiveField(3)
  TimeOfDay createdAtTime;

  /// CREATED AT DATE
  @HiveField(4)
  DateTime createdAtDate;

  /// IS COMPLETED
  @HiveField(5)
  bool isCompleted;

  /// status
  @HiveField(6)
  String statusTask;

  /// pintask
  @HiveField(7)
  bool pinedTask;

  /// create new Task
  factory Task.create({
    required String? title,
    required String? subtitle,
    TimeOfDay? createdAtTime,
    DateTime? createdAtDate,
    String? statusTask,
    bool? pinedTask,
  }) =>
      Task(
        id: const Uuid().v1(),
        title: title ?? "",
        subtitle: subtitle ?? "",
        createdAtTime: createdAtTime ?? TimeOfDay.now(),
        isCompleted: false,
        createdAtDate: createdAtDate ?? DateTime.now(),
        statusTask: statusTask ?? StatusTask.uncompleted.name,
        pinedTask: false,
      );
}
