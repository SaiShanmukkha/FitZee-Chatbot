import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pedometer_2/pedometer_2.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class PedometerBigShape extends CustomPainter {
  final Color color;

  PedometerBigShape({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5156921, size.height * 0.01976029);
    path_0.cubicTo(
        size.width * 0.5157012,
        size.height * 0.009506983,
        size.width * 0.5260976,
        size.height * 0.001190450,
        size.width * 0.5389451,
        size.height * 0.001158175);
    path_0.lineTo(size.width * 0.9765732, size.height * 0.00005884599);
    path_0.cubicTo(
        size.width * 0.9894970,
        size.height * 0.00002638589,
        size.width * 0.9999909,
        size.height * 0.008382676,
        size.width * 0.9999756,
        size.height * 0.01869509);
    path_0.lineTo(size.width * 0.9987591, size.height * 0.9814015);
    path_0.cubicTo(
        size.width * 0.9987470,
        size.height * 0.9916764,
        size.width * 0.9883079,
        size.height,
        size.width * 0.9754329,
        size.height);
    path_0.lineTo(size.width * 0.5139329, size.height);
    path_0.cubicTo(
        size.width * 0.4810488,
        size.height,
        size.width * 0.4706037,
        size.height * 0.9916642,
        size.width * 0.4706037,
        size.height * 0.9813820);
    path_0.lineTo(size.width * 0.4706037, size.height * 0.6390560);
    path_0.cubicTo(
        size.width * 0.4706037,
        size.height * 0.6287737,
        size.width * 0.4601585,
        size.height * 0.6204380,
        size.width * 0.4472744,
        size.height * 0.6204380);
    path_0.lineTo(size.width * 0.02387463, size.height * 0.6204380);
    path_0.cubicTo(
        size.width * 0.01099909,
        size.height * 0.6204380,
        size.width * 0.0005579817,
        size.height * 0.6121144,
        size.width * 0.0005459024,
        size.height * 0.6018370);
    path_0.lineTo(size.width * 0.00002197186, size.height * 0.1561599);
    path_0.cubicTo(
        size.width * 0.000009851006,
        size.height * 0.1458494,
        size.width * 0.01050012,
        size.height * 0.1374944,
        size.width * 0.02341966,
        size.height * 0.1375248);
    path_0.lineTo(size.width * 0.4921890, size.height * 0.1386309);
    path_0.cubicTo(
        size.width * 0.5050915,
        size.height * 0.1386613,
        size.width * 0.5155762,
        size.height * 0.1303265,
        size.width * 0.5155884,
        size.height * 0.1200290);
    path_0.lineTo(size.width * 0.5156921, size.height * 0.01976029);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

const double themeBorderRadius = 8;
const double scaffoldPadding = 16;

class LiveStepCount extends StatelessWidget {
  const LiveStepCount({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Step Counter'),
        ),
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(scaffoldPadding),
            child: Column(
              children: [
                Text(
                  'Check your daily steps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                StepData(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StepData extends StatefulWidget {
  const StepData({super.key});

  @override
  State<StepData> createState() => _StepDataState();
}

class _StepDataState extends State<StepData> {
  int? stepCount;
  int? stepTodayCount;
  int? stepCountStream;
  PedestrianStatus? pedestrianStatusStream;

  int? stepCountStreamFrom;
  int? androidFirstStepFrom;

  StreamSubscription? _stepStream;
  StreamSubscription? _stepStreamFrom;
  StreamSubscription? _pedestrianStatusStream;

  DateTime now = DateTime.now();
  // Start of the week - Monday
  late DateTime from = now.subtract(Duration(days: now.weekday - 1));
  //End of the week - Sunday
  late DateTime to =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _refreshData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _stepStream?.cancel();
    _stepStreamFrom?.cancel();
    _pedestrianStatusStream?.cancel();
  }

  void _checkPermissions() async {
    PermissionStatus perm = Platform.isAndroid
        ? await Permission.activityRecognition.request()
        : await Permission.sensors.request();

    if (perm.isDenied || perm.isPermanentlyDenied || perm.isRestricted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You need to approve the permissions to use the pedometer',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onError,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeBorderRadius),
          ),
          // Open the system settings to allow the permissions
          action: SnackBarAction(
            label: 'Settings',
            textColor: Theme.of(context).colorScheme.onError,
            onPressed: () => openAppSettings(),
          ),
        ),
      );
    } else {
      _getStepCount();
      _getTodaysStepCount();
      _listenStepCountStream();
      _listenStepCountStreamFrom();
      _listenPedestrianStatusStream();
    }
  }

  void _getStepCount() async {
    try {
      stepCount = await Pedometer().getStepCount(from: from, to: to);
      setState(() {});
    } catch (e) {
      throw Exception('getStepCount error: $e');
    }
  }

  void _getTodaysStepCount() async {
    try {
      late DateTime dayFrom =
          DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
      ;
      late DateTime dayto = DateTime.now();
      stepTodayCount = await Pedometer().getStepCount(from: dayFrom, to: dayto);
      setState(() {});
    } catch (e) {
      throw Exception('getTodayStepCount error: $e');
    }
  }

  void _listenStepCountStream() {
    try {
      _stepStream = Pedometer().stepCountStream().listen((step) {
        stepCountStream = step;
        setState(() {});
      });
    } catch (e) {
      throw Exception('stepCountStream error: $e');
    }
  }

  void _listenStepCountStreamFrom() async {
    try {
      if (Platform.isAndroid) {
        stepCountStreamFrom =
            await Pedometer().getStepCount(from: from, to: DateTime.now());
        setState(() {});

        _stepStreamFrom = Pedometer().stepCountStream().listen((step) {
          if (androidFirstStepFrom == null) {
            androidFirstStepFrom = step;
            return;
          }

          stepCountStreamFrom =
              stepCountStreamFrom! + step - androidFirstStepFrom!;
          setState(() {});
        });
        return;
      }

      _stepStreamFrom =
          Pedometer().stepCountStreamFrom(from: from).listen((step) {
        stepCountStreamFrom = step;
        setState(() {});
      });
    } catch (e) {
      // print('stepCountStreamFrom error: $e');
      throw Exception('stepCountStreamFrom error: $e');
    }
  }

  _listenPedestrianStatusStream() {
    try {
      _pedestrianStatusStream =
          Pedometer().pedestrianStatusStream().listen((status) {
        pedestrianStatusStream = status;
        setState(() {});
      });
    } catch (e) {
      throw Exception('pedestrianStatusStream error: $e');
    }
  }

  void _refreshData() {
    // _getStepCount();
    _getTodaysStepCount();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        StepDataSquare(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          time: 'Today',
          name: "Today's Step Count",
          functionName: '',
          value: stepTodayCount.toString(),
          stream: false,
        ),
        const SizedBox(height: 16),
        // StepDataSquare(
        //   backgroundColor: Theme.of(context).colorScheme.secondary,
        //   foregroundColor: Theme.of(context).colorScheme.onSecondary,
        //   time: '${from.formatDate} - ${to.formatDate}',
        //   name: 'GetCount',
        //   functionName: 'getStepCount()',
        //   value: stepCount.toString(),
        //   stream: false,
        // ),
        // const SizedBox(height: 16),
        StepDataSquare(
          backgroundColor: const Color.fromARGB(255, 172, 134, 22),
          foregroundColor: const Color.fromARGB(255, 40, 32, 8),
          name: 'Pedestrian Status',
          functionName: 'pedestrianStatusStream()',
          value: _enumToString(pedestrianStatusStream),
          small: true,
        ),
        const SizedBox(height: 8),
        StepDataSquare(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          time: 'Last boot - now',
          name: 'Step Count Since Last Reboot',
          functionName: '',
          value: stepCountStream.toString(),
        ),
        const SizedBox(height: 8),
        Platform.isIOS
            ? StepDataSquare(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                foregroundColor:
                    Theme.of(context).colorScheme.onPrimaryContainer,
                time: '${from.formatDate} - now',
                name: 'CountFrom',
                functionName: 'stepCountStreamFrom()',
                value: stepCountStreamFrom.toString(),
              )
            : Container(),
      ],
    );
  }
}

class StepDataSquare extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final String name;
  final String functionName;
  final bool small;
  final bool stream;
  final String? time;
  final String? value;

  const StepDataSquare({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.name,
    required this.functionName,
    required this.value,
    this.small = false,
    this.stream = true,
    this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: small ? 150 / 60 : 150 / 90,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(themeBorderRadius),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (time case String time) ...{
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: foregroundColor,
                      ),
                    ),
                  },
                  const SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: small ? 10 : 16,
                            fontWeight: FontWeight.bold,
                            height: 1,
                            color: foregroundColor,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Opacity(
                          opacity: .8,
                          child: Text(
                            '  $functionName',
                            style: TextStyle(
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                              height: 1,
                              color: foregroundColor,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (value case String value)
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: small ? 20 : 30,
                              fontWeight: FontWeight.w900,
                              height: 1,
                              color: foregroundColor,
                            ),
                          )
                        else
                          Container(
                            height: 14,
                            width: 14,
                            margin: const EdgeInsets.all(4),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: foregroundColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (stream)
              Opacity(
                opacity: .6,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Stream',
                    style: TextStyle(
                      fontSize: small ? 10 : 16,
                      fontWeight: FontWeight.bold,
                      height: 1,
                      color: foregroundColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class SquareSizes {
  late final double _width;

  SquareSizes(double width) {
    _width = width - scaffoldPadding * 2;
  }

  double get avatarWidth => _width * .50;
  double get avatarHeight => avatarWidth * .31;
  double get stepDataWidth => _width;
  double get stepDataHeight => stepDataWidth * 1.24;
  double get gitSize => _width * .45;
}

extension DateTimeExtension on DateTime {
  String get formatDate {
    final day = this.day.formatNumber;
    final month = this.month.formatNumber;
    return '$day.$month';
  }
}

extension IntExtension on int {
  String get formatNumber {
    return toString().padLeft(2, '0');
  }
}

String? _enumToString(Object? o) => o?.toString().split('.').last;
