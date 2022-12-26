import 'package:flutter/cupertino.dart';
import 'package:notes/utilities/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      content: "Are you sure you want to lg out?",
      title: "Log out",
      optionsBuilder: () => {
            'Cancel': false,
            'Log out': true,
          }).then(
    (value) => value ?? false,
  );
}
