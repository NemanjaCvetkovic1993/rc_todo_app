import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/user_provider.dart';

String selectedCollection = 'Main';

class TaskDropDownButton extends StatefulWidget {
  const TaskDropDownButton({super.key});

  @override
  State<TaskDropDownButton> createState() => _TaskDropDownButtonState();
}

class _TaskDropDownButtonState extends State<TaskDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('tasks').doc(user?.uid).collection('list_of_collections').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const CircularProgressIndicator();
        }

        final collectionDocs = snapshot.data!.docs;
        final collectionNames = collectionDocs.map((doc) => doc.id).toList();

        if (collectionNames.isEmpty) {
          collectionNames.add('Main');
        }

        return DropdownButton<String>(
          value: selectedCollection,
          items: collectionNames.map((collectionName) {
            return DropdownMenuItem<String>(
              value: collectionName,
              child: Text(
                collectionName,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedCollection = newValue ?? 'Main';
            });
          },
        );
      },
    );
  }
}
