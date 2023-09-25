import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/logic/task_logic.dart';
import 'package:todo_app/settings/theme.dart';
import 'package:todo_app/views/account/profile.dart';
import 'package:todo_app/views/layout.dart';
import 'package:todo_app/views/task/task_add.dart';

import 'logic/home_list_provider.dart';
import 'logic/share_logic.dart';
import 'logic/list_logic.dart';
import 'services/user_provider.dart';
import 'views/account/forgot_password.dart';

import 'views/account/login.dart';
import 'views/account/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
        ChangeNotifierProvider<HomeListProvider>(create: (context) => HomeListProvider()),
        ChangeNotifierProvider<TaskLogic>(create: (context) => TaskLogic()),
        ChangeNotifierProvider<TaskListLogic>(create: (context) => TaskListLogic()),
        ChangeNotifierProvider<ShareLogic>(create: (context) => ShareLogic()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(context),
      routes: {
        "/layoutPage": (context) => const LayoutPage(),
        "/addTask": (context) => const AddTask(),
        "/profilePage": (context) => const ProfilePage(),
        "/loginPage": (context) => const LoginPage(),
        "/registerPage": (context) => const RegisterPage(),
        "/forgotPasswordPage": (context) => const ForgotPasswordPage(),
      },
      home: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.user;
          if (user != null) {
            return const LayoutPage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
