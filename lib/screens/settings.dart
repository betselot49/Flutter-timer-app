import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: const Settings());
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

const String WORKTIME = "workTime";
const String SHORTBREAK = "shortBreak";
const String LONGBREAK = "longBreak";
int? workTime;
int? shortBreak;
int? longBreak;

class _SettingsState extends State<Settings> {
  SharedPreferences? prefs;

  TextStyle textStyle = const TextStyle(fontSize: 24);
  TextEditingController? txtWork;
  TextEditingController? txtShort;
  TextEditingController? txtLong;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs?.getInt(WORKTIME);
    if (workTime == null) {
      await prefs?.setInt(WORKTIME, int.parse('30'));
    }
    shortBreak = prefs?.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await prefs?.setInt(SHORTBREAK, int.parse('5'));
    }
    longBreak = prefs?.getInt(LONGBREAK);
    if (longBreak == null) {
      await prefs?.setInt(LONGBREAK, int.parse('20'));
    }
    setState(() {
      txtWork?.text = workTime.toString();
      txtShort?.text = shortBreak.toString();
      txtLong?.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs?.getInt(WORKTIME);
          // workTime += value;
          if (workTime == null) {
            workTime = 0;
          } else {
            workTime += value;
          }
          if (workTime >= 1 && workTime <= 180) {
            prefs?.setInt(WORKTIME, workTime);
            setState(() {
              txtWork?.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs?.getInt(SHORTBREAK);
          // short += value;
          if (short == null) {
            short = 0;
          } else {
            short += value;
          }
          if (short >= 1 && short <= 120) {
            prefs?.setInt(SHORTBREAK, short);
            setState(() {
              txtShort?.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs?.getInt(LONGBREAK);
          // long += value;
          if (long == null) {
            long = 0;
          } else {
            long += value;
          }
          if (long >= 1 && long <= 180) {
            prefs?.setInt(LONGBREAK, long);
            setState(() {
              txtLong?.text = long.toString();
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 3,
      childAspectRatio: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: const EdgeInsets.all(20.0),
      children: [
        Text(
          "Work",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        SettingButton(
            const Color(0xff455A64), "-", 10, -1, WORKTIME, updateSetting),

        TextField(
            controller: txtWork,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        // SettingsButton((0xff009688), +"", 1,),

        SettingButton(
            const Color(0xff009688), "+", 10, 1, WORKTIME, updateSetting),
        Text("Short", style: textStyle),
        const Text(""),
        const Text(""),
        // SettingsButton(Color(0xff455A64), "-", -1, ),
        SettingButton(
            const Color(0xff455A64), "-", 10, -1, SHORTBREAK, updateSetting),
        TextField(
            controller: txtShort,
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        // SettingsButton(Color(0xff009688), "+", 1),
        SettingButton(
            const Color(0xff009688), "+", 10, 1, SHORTBREAK, updateSetting),

        Text(
          "Long",
          style: textStyle,
        ),
        const Text(""),
        const Text(""),
        // SettingsButton(Color(0xff455A64), "-", -1,),
        SettingButton(
            const Color(0xff455A64), "-", 10, -1, LONGBREAK, updateSetting),
        TextField(
            style: textStyle,
            controller: txtLong,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number),
        // SettingsButton(Color(0xff009688), "+", 1,),
        SettingButton(
            const Color(0xff009688), "+", 10, 1, LONGBREAK, updateSetting),
      ],
    );
  }
}
