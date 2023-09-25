import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/logic/share_logic.dart';
import 'package:todo_app/settings/padding.dart';

import 'form_field.dart';

class BuildAlertDialog {
  static Future<String?> showShareTask({
    required BuildContext context,
    required DocumentSnapshot<Object?> document,
  }) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          content: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ShareTask(
              document: document,
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog({required BuildContext context, required child}) {}
}

class ShareTask extends StatefulWidget {
  final DocumentSnapshot document;
  const ShareTask({super.key, required this.document});

  @override
  State<ShareTask> createState() => _ShareTaskState();
}

class _ShareTaskState extends State<ShareTask> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shareLogicProvider = Provider.of<ShareLogic>(context);
    return MainPadding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: paddingMain(context) * 2),
          const Text(
            "Share Task",
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          FormContainerWidget(
            controller: _emailController,
            hintText: "Email",
            isPasswordField: false,
          ),
          SizedBox(height: paddingMain(context)),
          GestureDetector(
            onTap: () {
              shareLogicProvider.shareTaskWithEmail(
                context,
                _emailController,
                widget.document,
              );
              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              height: 45.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Share task",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: paddingMain(context) * 2),
        ],
      ),
    );
  }
}
