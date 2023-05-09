import 'package:flutter/material.dart';

enum MessageType { success, warning, error, networkError }

class MessageDialog {
  static void showMessageDialog({
    required BuildContext context,
    required MessageType type,
    required String title,
    required String message,
    required String buttonText,
    required Function() onPressed,
  }) {
    Widget icon;
    switch (type) {
      case MessageType.success:
        icon = const Icon(
          Icons.check_circle_outline,
          color: Colors.green,
        );
        break;
      case MessageType.warning:
        icon = const Icon(
          Icons.warning_outlined,
          color: Colors.orange,
        );
        break;
      case MessageType.error:
        icon = const Icon(
          Icons.error_outline,
          color: Colors.red,
        );
        break;
      case MessageType.networkError:
        icon = const Icon(
          Icons.wifi_off,
          color: Colors.orange,
        );
        break;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), icon],
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onPressed();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
