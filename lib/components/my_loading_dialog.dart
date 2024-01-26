import 'package:flutter/material.dart';

//to show our dialog
Future<void> showLoadingDialog(
  BuildContext context,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

// to hide our current dialog
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop();
}