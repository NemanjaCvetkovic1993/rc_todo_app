import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/home_list_data.dart';
import '../../logic/home_list_provider.dart';
import '../../services/user_provider.dart';
import '../../settings/responsive.dart';
import '../../widgets/alert_dialog.dart';
import 'list_add_new.dart';

class HomeHorizontalList extends StatelessWidget {
  const HomeHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    final homeListProvider = Provider.of<HomeListProvider>(context);
    return SizedBox(
      height: !Responsive.isMobile(context) ? 70.0 : 45.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            HomeHorizontalButton(
              name: "Main",
              onPressed: () => homeListProvider.updateList(
                newListName: dataHomeList[0].listName,
                newStream: dataHomeList[0].stream,
              ),
            ),
            HomeHorizontalButton(
              name: "Shared with you",
              onPressed: () => homeListProvider.updateList(
                newListName: dataHomeList[1].listName,
                newStream: dataHomeList[1].stream,
              ),
            ),
            HomeHorizontalButton(
              name: "Completed",
              onPressed: () => homeListProvider.updateList(
                newListName: dataHomeList[2].listName,
                newStream: dataHomeList[2].stream,
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
                final collectionNames = collectionDocs.map((doc) => doc.id).where((name) => name != "Main").toList();

                return Row(
                  children: collectionNames.map((name) {
                    return HomeHorizontalButton(
                      name: name,
                      onPressed: () => homeListProvider.updateList(
                        newListName: name,
                        newStream: FirebaseFirestore.instance.collection('tasks').doc(uid).collection(name).snapshots(),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            GestureDetector(
              onTap: () async {
                await BuildAlertDialog.showAlertDialog(
                  context: context,
                  child: AddNewList(uid: user!.uid),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  width: !Responsive.isMobile(context) ? 60.0 : 40.0,
                  height: !Responsive.isMobile(context) ? 60.0 : 40.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHorizontalButton extends StatelessWidget {
  final String name;

  final Function() onPressed;
  const HomeHorizontalButton({
    super.key,
    required this.name,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SizedBox(
        height: !Responsive.isMobile(context) ? 60.0 : 40.0,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
          child: Text(
            name,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
      ),
    );
  }
}
