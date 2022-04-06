import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final VoidCallback presentDatePickerHandler;
  final String text;

  AdaptiveFlatButton({required this.text, required this.presentDatePickerHandler});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: presentDatePickerHandler,
            color: Theme.of(context).primaryColor,
          )
        : TextButton(
            onPressed: presentDatePickerHandler,
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style:
                TextButton.styleFrom(primary: Theme.of(context).primaryColor),
          );
  }
}
