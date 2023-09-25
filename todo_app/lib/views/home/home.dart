import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/logic/home_list_provider.dart';
import 'package:todo_app/views/home/home_list.dart';

import '../../settings/responsive.dart';
import 'home_horizontal_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeListProvider = Provider.of<HomeListProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: !Responsive.isMobile(context) ? 14.0 : 10.0),
          const HomeHorizontalList(),
          SizedBox(height: !Responsive.isMobile(context) ? 14.0 : 10.0),
          Expanded(
            child: HomeList(
              listName: homeListProvider.listName,
              stream: homeListProvider.stream,
            ),
          ),
        ],
      ),
    );
  }
}
