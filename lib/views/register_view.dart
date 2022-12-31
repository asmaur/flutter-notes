import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';

import '../services/auth/auth_exceptions.dart';
import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_state.dart';
import '../utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              'Weak password.',
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              "Email is already taken.",
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              'Invalid email entered.',
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "Error: Unable to register.",
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
        ),
        body: Column(
          children: [
            TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: "Enter your email here"),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Enter your password here",
              ),
            ),
            TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                context.read<AuthBloc>().add(AuthEventRegister(
                      email,
                      password,
                    ));

                // try {
                //   AuthService.firebase().createUser(
                //     email: email,
                //     password: password,
                //   );
                //   final user = AuthService
                //       .firebase()
                //       .currentUser;
                //   await AuthService.firebase().sendEmailVerification();
                //   Navigator.of(context).pushNamed(
                //     verifyEmailRoute,
                //   );
                // } on Exception catch(e){
                //   emit();
                // }
                // on WeakPasswordAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Weak password.',
                //   );
                // } on EmailAlreadyInUseAuthException {
                //   await showErrorDialog(
                //     context,
                //     "Email is already taken.",
                //   );
                // } on InvalidEmailAuthException {
                //   await showErrorDialog(
                //     context,
                //     'Invalid email entered.',
                //   );
                // } on GenericAuthException {
                //   await showErrorDialog(
                //     context,
                //     "Error: Unable to register.",
                //   );
                // }
              },
              child: const Text("Register"),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   loginRoute,
                //   (route) => false,
                // );
              },
              child: const Text(
                "Already have an account? Login here!",
              ),
            )
          ],
        ),
      ),
    );
  }
}
