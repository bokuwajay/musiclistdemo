import 'package:flutter/material.dart';
import 'package:keysoctest/core/error/failure_message_to_user.dart';
import 'package:keysoctest/util/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String message) {
  final result = failureMessagesToUser(context, message);

  return showGenericDialog<void>(
    context: context,
    title: "An Error Occurred",
    content: result['content']!,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
