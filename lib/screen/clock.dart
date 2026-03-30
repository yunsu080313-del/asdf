import 'dart:math';

import 'package:flutter/material.dart';
import 'package:module_110_a/controller/controller.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  int hour = 12;

  int minute = 0;

  double angle = 0;

  bool isHour = true;
  bool isAm = true;

  void update(Offset p) {
    final dx = p.dx - 100;
    final dy = p.dy - 100;
    final a = (atan2(dy, dx) + pi / 2) % (pi * 2);

    setState(() {
      angle = a;
      if (isHour) {
        hour = (a / pi * 6).round() == 0 ? 12 : (a / pi * 6).round();
      } else {
        minute = (a / pi * 30).round() % 60;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title(),
        SizedBox(height: 30),
        GestureDetector(
          onPanEnd: (details) {
            final date = Controller.focusday;
            Controller.focusday = DateTime(
              date.year,
              date.month,
              date.day,
              hour,
              minute,
            );
            if (!isHour) {
              setState(() {
                Controller.currentindex.value++;
              });
            }
          },
          onPanDown: (d) => update(d.localPosition),
          onPanUpdate: (d) => update(d.localPosition),
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
            ),
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                CircleAvatar(radius: 4, backgroundColor: Colors.white),
                Transform.rotate(
                  angle: angle,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: AlignmentGeometry.bottomCenter,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 100),
                        width: 2,
                        height: 65,
                        color: Colors.white,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 165),
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),

                ...List.generate(12, (i) {
                  final angle = (i / 12) * 2 * pi - pi / 2 + pi / 6;
                  final radius = 85;
                  final x = cos(angle);
                  final y = sin(angle);
                  return Positioned(
                    top: y * radius + 90,
                    left: x * radius + 95,
                    child: Text('${i + 1}'),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget title() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    spacing: 10,
    children: [
      GestureDetector(
        onTap: () {
          isHour = true;
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: isHour ? Colors.white : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Text(
            '${hour.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: isHour ? Colors.white : Colors.grey,
              fontSize: 24,
            ),
          ),
        ),
      ),
      Text(':', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      GestureDetector(
        onTap: () {
          isHour = false;
          setState(() {});
        },
        child: Container(
          alignment: Alignment.center,
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: !isHour ? Colors.white : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(14),
          ),

          child: Text(
            '${minute.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: !isHour ? Colors.white : Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      Container(
        height: 50,
        width: 40,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  isAm = true;
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isAm ? Colors.white : Colors.grey,
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'AM',
                    style: TextStyle(
                      fontSize: 18,
                      color: isAm ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isAm = false;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: !isAm ? Colors.white : Colors.grey,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    'PM',
                    style: TextStyle(
                      fontSize: 18,
                      color: !isAm ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
