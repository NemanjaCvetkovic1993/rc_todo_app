import 'package:flutter/material.dart';

import 'package:todo_app/views/home/home.dart';

import '../settings/padding.dart';
import '../settings/responsive.dart';
import '../widgets/drawer.dart';
import 'task/task_quick_add.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ToDo App",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed("/profilePage"),
            child: Container(
              width: !Responsive.isMobile(context) ? 44.0 : 32.0,
              height: !Responsive.isMobile(context) ? 44.0 : 32.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: !Responsive.isMobile(context) ? 28.0 : 20.0,
                ),
              ),
            ),
          ),
          SizedBox(width: paddingMain(context)),
        ],
      ),
      body: const HomePage(),
      bottomNavigationBar: Container(
        height: !Responsive.isMobile(context) ? 80.0 : 70.0,
        color: Colors.blue,
        child: const AddQuickTask(),
      ),
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/addTask"),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );
  }
}
