import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/user_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/form_field.dart';
import '../../settings/padding.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final User? user = userProvider.user;
    return Scaffold(
      body: FormFieldDesktopPadding(
        child: MainPadding(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: paddingMain(context) * 2),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: paddingMain(context)),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: paddingMain(context) * 2),
                MainButton(
                  title: "Sign Up",
                  onTap: () async {
                    await userProvider.createUserWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (user != null) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        "/layoutPage",
                        (Route route) => false,
                      );
                    }
                  },
                ),
                SizedBox(height: paddingMain(context)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                        "/loginPage",
                        (Route route) => false,
                      ),
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
