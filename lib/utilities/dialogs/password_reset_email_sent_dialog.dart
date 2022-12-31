import 'package:flutter/material.dart';
import 'package:notes/utilities/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(context: context,
    title: "Password reset",
    content: "We have sent you a password reset link. Check your email!",
    optionsBuilder: () =>
    {
      'Ok': null,
    },);
}