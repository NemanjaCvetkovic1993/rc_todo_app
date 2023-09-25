import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/logic/base_list_logic.dart';

class TaskListLogic extends BaseTaskListLogic with ChangeNotifier {
  @override
  Future<void> createList(String uid, String listName) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('tasks').doc(uid).collection(listName);

      final tempDoc = await collectionRef.add({});
      await tempDoc.delete();

      final mainDoc = await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc('Main').get();

      if (!mainDoc.exists) {
        await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc('Main').set({'title': 'Main'});
      }

      await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc(listName).set({'title': listName});
    } catch (e) {
      return;
    }
  }

  @override
  Future<void> removeList(String uid, String listName) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('tasks').doc(uid).collection(listName);

      final querySnapshot = await collectionRef.get();

      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      await FirebaseFirestore.instance.collection('tasks').doc(uid).collection('list_of_collections').doc(listName).delete();
    } catch (e) {
      return;
    }
  }

  @override
  Future<int> listLength(String uid, String listName) async {
    try {
      final collectionRef = FirebaseFirestore.instance.collection('tasks').doc(uid).collection(listName);

      final querySnapshot = await collectionRef.get();

      return querySnapshot.size;
    } catch (e) {
      return 0;
    }
  }
}
