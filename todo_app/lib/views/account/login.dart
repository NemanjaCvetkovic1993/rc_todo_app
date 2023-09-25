import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/user_provider.dart';
import '../../widgets/button.dart';
import '../../widgets/form_field.dart';
import '../../settings/padding.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      body: FormFieldDesktopPadding(
        child: MainPadding(
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
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
                      title: "Login",
                      onTap: () async {
                        final userProvider = Provider.of<UserProvider>(context, listen: false);
                        final User? user = await userProvider.signInWithEmailAndPassword(
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
                    const SizedBox(
                      height: 8.0,
                    ),
                    TextButton(
                      child: const Text('Forgot password?'),
                      onPressed: () => Navigator.of(context).pushNamed("/forgotPasswordPage"),
                    ),
                    SizedBox(height: paddingMain(context) * 3),
                    TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.google,
                            size: 24.0,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Sign in with Google',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      onPressed: () async => await userProvider.signInWithGoogle(),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushNamed("/registerPage"),
                      child: Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
