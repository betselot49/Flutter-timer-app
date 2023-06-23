import 'package:flutter/material.dart';
import './screens/settings.dart';
import './timermodel.dart';
import 'components/buttons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';

void main() {
  runApp(const MyApp());
}

final CountDownTimer timer = CountDownTimer();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final double defaultPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    timer.startWork();
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const TimerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TimerHomePage extends StatelessWidget {
  const TimerHomePage({Key? key}) : super(key: key);

  double get defaultPadding => 5.0;

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text(
        'Settings',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    ));

    void goToSettings(BuildContext context) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My work timer'),
        actions: [
          PopupMenuButton<String>(itemBuilder: (BuildContext context) {
            return menuItems.toList();
          }, onSelected: (s) {
            if (s == 'Settings') {
              goToSettings(context);
            }
          })
        ],
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  const Padding(padding: EdgeInsets.all(5)),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: "Work",
                      onPressed: () => timer.startWork(),
                      size: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff607D8B),
                      text: "Short Break",
                      onPressed: () => timer.startBreak(true),
                      size: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff455A64),
                      text: "Long Break",
                      onPressed: () => timer.startBreak(false),
                      size: 20,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return SizedBox(
                      height: availableWidth / 2,
                      child: CircularPercentIndicator(
                        radius: availableWidth / 2,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Text(
                          timer.time,
                          style: Theme.of(context).textTheme.headline4!,
                        ),
                        progressColor: Color.fromARGB(255, 0, 114, 191),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff212121),
                      text: 'Stop',
                      onPressed: () => timer.stopTimer(),
                      size: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: const Color(0xff009688),
                      text: 'Restart',
                      onPressed: () => timer.startTimer(),
                      size: 20,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
