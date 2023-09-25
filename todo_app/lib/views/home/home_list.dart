import 'package:flutter/material.dart';

import '../../settings/responsive.dart';
import '../../widgets/task_card.dart';
import '../../settings/padding.dart';
import 'list_empty_animation.dart';

class HomeList extends StatelessWidget {
  final String listName;
  final Stream stream;
  const HomeList({
    Key? key,
    required this.listName,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 160.0,
      child: MainPadding(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: !Responsive.isMobile(context) ? 8.0 : 0.0),
          child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final isEmpty = snapshot.data?.docs.isEmpty ?? true;

              if (isEmpty) {
                return EmptyListAnimation(listName: listName);
              } else {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: !Responsive.isMobile(context) ? 12.0 : 6.0),
                      child: TaskCard(document: doc),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
