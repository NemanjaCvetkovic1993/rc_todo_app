import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/logic/task_logic.dart';

import '../../widgets/form_field.dart';

class AddQuickTask extends StatefulWidget {
  const AddQuickTask({super.key});

  @override
  State<AddQuickTask> createState() => _AddQuickTaskState();
}

class _AddQuickTaskState extends State<AddQuickTask> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final taskLogicProvider = Provider.of<TaskLogic>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 100.0,
            child: FormContainerWidget(
              controller: _titleController,
              hintText: "Add Quick Task",
            ),
          ),
          IconButton(
            onPressed: () {
              taskLogicProvider.addQuickTaskToFirebase(
                context,
                _titleController,
              );
            },
            icon: const Icon(
              Icons.send_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
