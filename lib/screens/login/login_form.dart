import 'package:flutter/material.dart';
import 'package:quiz/services/auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  handleSubmit() async {
    // print(passwordController.text);
    await AuthService().emailLogin(emailController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleSubmit,
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
