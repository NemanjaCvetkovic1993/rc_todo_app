import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/button.dart';

import '../../data/color_data.dart';
import '../../logic/task_logic.dart';
import '../../services/user_provider.dart';
import '../../settings/padding.dart';
import '../../settings/responsive.dart';
import '../../widgets/alert_dialog.dart';
import '../../widgets/form_field.dart';
import '../../widgets/share_add_task.dart';
import '../../widgets/task_drop_down_button.dart';
import '../home/list_add_new.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<String> selectedCollections = [];
  String _selectedColor = listColors[0];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() async {
    final taskLogicProvider = Provider.of<TaskLogic>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final User? user = userProvider.user;

    Future.delayed(Duration.zero, () async {
      await taskLogicProvider.ensureMainCollectionExists(user!.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskLogicProvider = Provider.of<TaskLogic>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Stack(
        children: [
          FormFieldDesktopPadding(
            child: MainPadding(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Add Task",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(height: paddingMain(context) * 4),
                    FormContainerWidget(
                      controller: _titleController,
                      hintText: "Title",
                    ),
                    SizedBox(height: paddingMain(context)),
                    FormContainerWidget(
                      controller: _descriptionController,
                      hintText: "Description",
                    ),
                    SizedBox(height: paddingMain(context) * 2),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.spaceBetween,
                      children: listColors.map((color) {
                        final isSelected = _selectedColor == color;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          child: Container(
                            width: !Responsive.isMobile(context) ? 56.0 : 40.0,
                            height: !Responsive.isMobile(context) ? 56.0 : 40.0,
                            decoration: BoxDecoration(
                              color: Color(int.parse(color)),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected ? Colors.black : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: paddingMain(context) * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TaskDropDownButton(),
                        TextButton(
                          onPressed: () async {
                            await BuildAlertDialog.showAlertDialog(
                              context: context,
                              child: AddNewList(uid: user!.uid),
                            );
                          },
                          child: Text(
                            "Add List",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: paddingMain(context) * 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Task not yet shared",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await BuildAlertDialog.showAlertDialog(
                              context: context,
                              child: const ShareTaskWhileCreation(),
                            );
                          },
                          child: Text(
                            "Share Task",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: paddingMain(context),
            left: paddingMain(context),
            right: paddingMain(context),
            child: MainButton(
              title: "Add Task",
              onTap: () {
                taskLogicProvider.addTaskToFirebase(
                  context,
                  _titleController,
                  _descriptionController,
                  _selectedColor,
                  selectedCollection,
                );
                Navigator.of(context).pushNamedAndRemoveUntil(
                  "/layoutPage",
                  (Route route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
