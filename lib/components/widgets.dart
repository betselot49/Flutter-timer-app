import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;
  const SettingButton(
      this.color, this.text, this.size, this.value, this.setting, this.callback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => callback(setting, value),
      color: color,
      minWidth: size,
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
