import 'package:flutter/cupertino.dart';
import 'package:notes/utilities/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
      context: context,
      title: "Delete",
      content: "Really want to delete item?",
      optionsBuilder: () => {
            'Cancel': false,
            'Delete': true,
          }).then((value) => value ?? false);
}
