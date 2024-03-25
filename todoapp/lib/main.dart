import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/hive_data_store.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/timeofday.dart';
import 'package:todoapp/utils/constanst.dart';
import 'package:todoapp/view/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initial Hive DB
  await Hive.initFlutter();

  /// Register Hive Adapter
  Hive
    ..registerAdapter<TimeOfDay>(TimeOfDayAdapter())
    ..registerAdapter<Task>(TaskAdapter());
  // ..registerAdapter<StatusTask>(StatusTaskAdapter());

  /// Open box
  var box = await Hive.openBox<Task>("tasksBox");

  /// Delete data from previous day
  // ignore: avoid_function_literals_in_foreach_calls
  box.values.forEach((task) {
    if (task.createdAtDate.day == (DateTime.now().day - 1)) {
    } else {}
  });

  runApp(BaseWidget(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}

class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);
  final HiveDataStore dataStore = HiveDataStore();
  final Widget child;

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Could not find ancestor widget of type BaseWidget');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
