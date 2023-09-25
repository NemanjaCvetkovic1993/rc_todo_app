import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/settings/padding.dart';

import '../logic/list_logic.dart';
import '../services/user_provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final taskListLogicProvider = Provider.of<TaskListLogic>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'ToDo App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () => Navigator.of(context).pushNamed("/profilePage"),
          ),
          SizedBox(height: paddingMain(context)),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "My Lists",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
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

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: collectionNames.length,
                  itemBuilder: (context, index) {
                    final collectionName = collectionNames[index];
                    return ListTile(
                      leading: const Icon(Icons.list),
                      title: Text(
                        collectionName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await taskListLogicProvider.removeList(user!.uid, collectionNames[index]);
                        },
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
