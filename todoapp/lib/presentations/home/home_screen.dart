import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/presentations/home/widgets/fab_button.dart';
import 'package:todoapp/utils/app_colors.dart';
import 'package:todoapp/utils/app_const.dart';
import 'package:todoapp/utils/app_str.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<int> testing = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      /// Floating Action Button
      floatingActionButton: const FAB(),
      appBar: AppBar(
        title: Text(
          "My tasks",
          style: textTheme.displayLarge,
        ),
      ),
      body: _buildBody(textTheme),
    );
  }

  SizedBox _buildBody(
    // List<Task> tasks,
    // BaseWidget base,
    TextTheme textTheme,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Top Section Of Home page : Text, Progrss Indicator
            Container(
              margin: const EdgeInsets.fromLTRB(55, 0, 0, 0),
              width: double.infinity,
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// CircularProgressIndicator
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(MyColors.primaryColor),
                      backgroundColor: Colors.grey,
                      // value: checkDoneTask(tasks) / valueOfTheIndicator(tasks),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),

                  /// Texts
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(MyString.mainTitle, style: textTheme.headline1),
                      const SizedBox(
                        height: 3,
                      ),
                      // Text("${checkDoneTask(tasks)} of ${tasks.length} task",
                      //     style: textTheme.subtitle1),
                    ],
                  )
                ],
              ),
            ),

            /// Divider
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Divider(
                thickness: 2,
                indent: 100,
              ),
            ),

            /// Bottom ListView : Tasks
            SizedBox(
              width: double.infinity,
              height: 585,
              child: testing.isNotEmpty
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: testing.length,
                      itemBuilder: (BuildContext context, int index) {
                        // var task = tasks[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          background: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(MyString.deletedTask,
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ))
                            ],
                          ),
                          onDismissed: (direction) {
                            // base.dataStore.dalateTask(task: task);
                          },
                          key: Key(index.toString()),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: true
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
                              leading: GestureDetector(
                                onTap: () {
                                  // widget.task.isCompleted =
                                  //     !widget.task.isCompleted;
                                  // widget.task.save();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 600),
                                  decoration: BoxDecoration(
                                      color: true
                                          ? MyColors.primaryColor
                                          : Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey, width: .8)),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              /// title of Task
                              title: const Padding(
                                padding: EdgeInsets.only(bottom: 5, top: 3),
                                child: Text(
                                  "title of task",
                                  style: TextStyle(
                                      color: true
                                          ? MyColors.primaryColor
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                      decoration: true
                                          ? TextDecoration.lineThrough
                                          : null),
                                ),
                              ),

                              /// Description of task
                              subtitle: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description of task",
                                    style: TextStyle(
                                      color: true
                                          ? MyColors.primaryColor
                                          : Color.fromARGB(255, 164, 164, 164),
                                      fontWeight: FontWeight.w300,
                                      decoration: true
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),

                                  /// Date & Time of Task
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                        top: 10,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            // DateFormat('hh:mm a').format(
                                            //     widget.task.createdAtTime),
                                            "hh:mm a",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: true
                                                    ? Colors.white
                                                    : Colors.grey),
                                          ),
                                          Text(
                                            // DateFormat.yMMMEd().format(
                                            //     widget.task.createdAtDate),
                                            "yMMMEd",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: true
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
                          // child: SizedBox(),
                        );
                      },
                    )

                  // if All Tasks Done Show this Widgets
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Lottie
                        // FadeIn(
                        //   child: SizedBox(
                        //     width: 200,
                        //     height: 200,
                        //     child: Lottie.asset(
                        //       lottieURL,
                        //       animate: tasks.isNotEmpty ? false : true,
                        //     ),
                        //   ),
                        // ),
                        FadeIn(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: testing.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        // /// Bottom Texts
                        FadeInUp(
                          from: 30,
                          child: const Text(MyString.doneAllTask),
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
