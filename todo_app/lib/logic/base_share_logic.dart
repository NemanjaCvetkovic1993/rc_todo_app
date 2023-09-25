import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class BaseShareLogic {
  Future<void> shareTaskWithEmail(BuildContext context, TextEditingController emailController, DocumentSnapshot document);

  Future<void> removeSharedTaskWithEmail(BuildContext context, String email, DocumentSnapshot document);

  void addEmailToShareTask(String email);

  Stream<List<String>> listOfSharedEmailsForTask(DocumentSnapshot document);
}
