import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/views/task/task_details.dart';

import '../logic/task_logic.dart';
import '../settings/responsive.dart';

class TaskCard extends StatelessWidget {
  final DocumentSnapshot<Object?> document;
  const TaskCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final taskLogicProvider = Provider.of<TaskLogic>(context);
    final bool isCompleted = document['isCompleted'] ?? false;
    final colorHex = document['color'] as String;
    final color = taskLogicProvider.getColorFromHex(colorHex);
    final sharedWith = document['sharedWith'] as List<dynamic>;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskDetails(document: document),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: !Responsive.isMobile(context) ? 120.0 : 90.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: !Responsive.isMobile(context) ? 16.0 : 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isCompleted,
                    onChanged: (newValue) {
                      final updatedValue = !isCompleted;

                      final documentReference = document.reference;
                      documentReference.update({'isCompleted': updatedValue});
                    },
                  ),
                  SizedBox(
                    width: !Responsive.isMobile(context) ? 16.0 : 8.0,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      document['title'],
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: isCompleted,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                      ),
                      onPressed: () async {
                        await taskLogicProvider.removeTaskFromFirebase(context, document);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -6.0,
            right: -6.0,
            child: (sharedWith.isNotEmpty)
                ? Container(
                    width: !Responsive.isMobile(context) ? 46.0 : 34.0,
                    height: !Responsive.isMobile(context) ? 46.0 : 34.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.people,
                        size: !Responsive.isMobile(context) ? 26.0 : 20.0,
                        color: Colors.white,
                      ),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
