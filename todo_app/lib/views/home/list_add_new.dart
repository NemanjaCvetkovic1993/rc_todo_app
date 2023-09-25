import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/logic/list_logic.dart';

import '../../widgets/form_field.dart';
import '../../settings/padding.dart';

class AddNewList extends StatefulWidget {
  final String uid;
  const AddNewList({
    super.key,
    required this.uid,
  });

  @override
  State<AddNewList> createState() => _AddNewListState();
}

class _AddNewListState extends State<AddNewList> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskListLogicProvider = Provider.of<TaskListLogic>(context);
    return MainPadding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: paddingMain(context) * 2),
          const Text(
            "Add new list",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          FormContainerWidget(
            controller: _nameController,
            hintText: "List name",
          ),
          SizedBox(height: paddingMain(context)),
          GestureDetector(
            onTap: () {
              String listName = _nameController.text;
              taskListLogicProvider.createList(widget.uid, listName);
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: paddingMain(context) * 2),
        ],
      ),
    );
  }
}
