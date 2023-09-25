import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/logic/base_share_logic.dart';

class ShareLogic extends BaseShareLogic with ChangeNotifier {
  List<String> selectedEmailsToShareTask = [];

  @override
  Future<void> shareTaskWithEmail(
    BuildContext context,
    TextEditingController emailController,
    DocumentSnapshot document,
  ) async {
    final email = emailController.text;

    final documentReference = document.reference;
    await documentReference.update({
      'sharedWith': FieldValue.arrayUnion([email]),
    });
  }

  @override
  void addEmailToShareTask(String email) {
    selectedEmailsToShareTask.add(email);
    notifyListeners();
  }

  @override
  Future<void> removeSharedTaskWithEmail(
    BuildContext context,
    String email,
    DocumentSnapshot document,
  ) async {
    final documentReference = document.reference;
    await documentReference.update({
      'sharedWith': FieldValue.arrayRemove([email]),
    });
  }

  @override
  Stream<List<String>> listOfSharedEmailsForTask(DocumentSnapshot document) {
    final List<dynamic> sharedWith = document['sharedWith'];
    final List<String> sharedWithEmails = sharedWith.map((sharedWithEmail) => sharedWithEmail.toString()).toList();
    return Stream.value(sharedWithEmails);
  }
}
