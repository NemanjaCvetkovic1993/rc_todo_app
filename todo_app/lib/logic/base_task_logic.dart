import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class BaseTaskLogic {
  Future<void> addTaskToFirebase(
      BuildContext context, TextEditingController titleController, TextEditingController descriptionController, String selectedColor, String selectedCollection);

  Future<void> addQuickTaskToFirebase(BuildContext context, TextEditingController titleController);

  Future<void> markTaskAsCompleted(DocumentSnapshot document);

  Future<void> removeTaskFromFirebase(BuildContext context, DocumentSnapshot document);

  Color getColorFromHex(String hexColor);
}
