import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/share_logic.dart';
import '../settings/padding.dart';
import 'form_field.dart';

class ShareTaskWhileCreation extends StatefulWidget {
  const ShareTaskWhileCreation({super.key});

  @override
  State<ShareTaskWhileCreation> createState() => _ShareTaskWhileCreationState();
}

class _ShareTaskWhileCreationState extends State<ShareTaskWhileCreation> {
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
              shareLogicProvider.addEmailToShareTask(_emailController.text);
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
