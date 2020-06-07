import 'package:flutter/material.dart';

InputDecoration clearInput({
  String labelText,
  bool enabled = true,
  Function onPressed,
  bool passwordToggle = false,
  Function onPasswordTogglePressed,
  bool passwordToggleVisible = false,
}) {
  return InputDecoration(
    labelText: labelText,
    suffixIcon: enabled
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (passwordToggle) ...[
                ButtonTheme(
                  child: IconButton(
                    icon: passwordToggleVisible
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: onPasswordTogglePressed,
                  ),
                ),
              ],
              IconButton(
                icon: Icon(Icons.close),
                onPressed: onPressed,
              ),
            ],
          )
        : null,
  );
}
