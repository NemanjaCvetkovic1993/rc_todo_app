import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/home_list_model.dart';

final String? uid = FirebaseAuth.instance.currentUser?.uid;
final String? myEmail = FirebaseAuth.instance.currentUser?.email;

List<HomeListModel> dataHomeList = [
  HomeListModel(
    listName: "Main",
    stream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection('Main').where('isCompleted', isEqualTo: false).snapshots(),
  ),
  HomeListModel(
    listName: "Shared with you",
    stream: FirebaseFirestore.instance.collectionGroup('Main').where('sharedWith', arrayContains: myEmail).orderBy('timestamp', descending: false).snapshots(),
  ),
  HomeListModel(
    listName: "Completed",
    stream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection('Main').where('isCompleted', isEqualTo: true).snapshots(),
  ),
];
