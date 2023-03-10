import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';
import 'package:notes/services/auth/bloc/auth_bloc.dart';
import 'package:notes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          const Text(
            "We've send you an verification email. Please open and verify your email.",
          ),
          const Text(
            "If you haven't received a verification email? Please click below to receive a new one.",
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(const AuthEventSendEmailVerification(),);
              //await AuthService.firebase().sendEmailVerification();
            },
            child: const Text("Send verification email"),
          ),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
                // await AuthService.firebase().logOut();
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //   registerRoute,
                //   (route) => false,
                // );
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
