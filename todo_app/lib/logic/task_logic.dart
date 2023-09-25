import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/data/color_data.dart';
import 'package:todo_app/logic/base_task_logic.dart';

import '../services/user_provider.dart';
import 'share_logic.dart';

class TaskLogic extends BaseTaskLogic with ChangeNotifier {
  @override
  Future<void> addTaskToFirebase(
      BuildContext context, TextEditingController titleController, TextEditingController descriptionController, String selectedColor, String selectedCollection) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final shareLogicProvider = Provider.of<ShareLogic>(context, listen: false);

    if (user == null || titleController.text.isEmpty) {
      return;
    }

    final uid = user.uid;
    final time = DateTime.now();

    await FirebaseFirestore.instance.collection('tasks').doc(uid).collection(selectedCollection).doc(time.toString()).set({
      'title': titleController.text,
      'description': descriptionController.text,
      'time': time.toString(),
      'timestamp': time,
      'isCompleted': false,
      'sharedWith': shareLogicProvider.selectedEmailsToShareTask,
      'color': selectedColor,
    });

    shareLogicProvider.selectedEmailsToShareTask.clear();
  }

  @override
  Future<void> addQuickTaskToFirebase(
    BuildContext context,
    TextEditingController titleController,
  ) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (user == null || titleController.text.isEmpty) {
      return;
    }

    final uid = user.uid;
    final time = DateTime.now();

    await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('Main').doc(time.toString()).set({
      'title': titleController.text,
      'description': "",
      'time': time.toString(),
      'timestamp': time,
      'isCompleted': false,
      'sharedWith': [],
      'color': listColors[0],
    });

    titleController.clear();
  }

  @override
  Future<void> markTaskAsCompleted(DocumentSnapshot document) async {
    final documentReference = document.reference;

    await documentReference.update({'isCompleted': true});
  }

  // update task

  @override
  Future<void> removeTaskFromFirebase(
    BuildContext context,
    DocumentSnapshot document,
  ) async {
    final documentReference = document.reference;
    await documentReference.delete();
  }

  // Future<void> deleteTaskFromFirebase(String uid, String taskId) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('Main').doc(taskId).delete();
  //   } catch (e) {
  //     print('Error deleting task: $e');
  //   }
  // }

  @override
  Color getColorFromHex(String hexColor) {
    final int colorValue = int.parse(hexColor);
    return Color(colorValue);
  }

  Future<void> ensureMainCollectionExists(String uid) async {
    final mainDoc = await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc('Main').get();

    if (!mainDoc.exists) {
      await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc('Main').set({'title': 'Main'});
    }
  }
}
