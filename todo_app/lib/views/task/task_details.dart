import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/settings/padding.dart';

import '../../services/user_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/share_task.dart';
import '../../logic/share_logic.dart';
import '../../logic/task_logic.dart';
import '../../widgets/task_drop_down_button.dart';
import '../home/list_add_new.dart';

class TaskDetails extends StatelessWidget {
  final DocumentSnapshot document;

  const TaskDetails({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final taskLogicProvider = Provider.of<TaskLogic>(context);
    final shareLogicProvider = Provider.of<ShareLogic>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Details',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await taskLogicProvider.removeTaskFromFirebase(context, document);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          MainPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingMain(context) * 2),
                const TaskSubtitle(title: "Title"),
                SizedBox(height: paddingMain(context)),
                MainPadding(
                  child: Text(
                    document["title"],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                SizedBox(height: paddingMain(context) * 2),
                const TaskSubtitle(title: "Description"),
                SizedBox(height: paddingMain(context)),
                MainPadding(
                  child: Text(
                    document["description"],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: paddingMain(context) * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TaskSubtitle(title: "Add task to list:"),
                    TextButton(
                      onPressed: () async {
                        await BuildAlertDialog.showAlertDialog(
                          context: context,
                          child: AddNewList(uid: user!.uid),
                        );
                      },
                      child: Text(
                        "Add List",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingMain(context)),
                const TaskDropDownButton(),
                SizedBox(height: paddingMain(context) * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StreamBuilder<List<String>>(
                      stream: shareLogicProvider.listOfSharedEmailsForTask(document),
                      builder: (context, snapshot) {
                        final sharedEmails = snapshot.data ?? [];
                        return sharedEmails.isEmpty ? const TaskSubtitle(title: "Task not shared yet") : const TaskSubtitle(title: "Task shared with:");
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        await BuildAlertDialog.showShareTask(
                          context: context,
                          document: document,
                        );
                      },
                      child: Text(
                        "Share Task",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingMain(context)),
                Expanded(
                  child: StreamBuilder(
                    stream: shareLogicProvider.listOfSharedEmailsForTask(document),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      final sharedEmails = snapshot.data ?? [];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView.builder(
                          itemCount: sharedEmails.length,
                          itemBuilder: (context, index) {
                            final email = sharedEmails[index];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  email,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await shareLogicProvider.removeSharedTaskWithEmail(context, email, document);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.grey.shade900,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: paddingMain(context),
            left: paddingMain(context),
            right: paddingMain(context),
            child: MainButton(
              title: "Mark as Completed",
              onTap: () {
                taskLogicProvider.markTaskAsCompleted(document);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TaskSubtitle extends StatelessWidget {
  final String title;
  const TaskSubtitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
      textAlign: TextAlign.left,
    );
  }
}
