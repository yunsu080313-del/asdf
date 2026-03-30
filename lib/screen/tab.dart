import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_110_a/screen/calender.dart';
import 'package:module_110_a/screen/check.dart';
import 'package:module_110_a/screen/clock.dart';
import 'package:module_110_a/screen/input.dart';
import 'package:module_110_a/screen/main.dart';
import 'package:module_110_a/screen/sex.dart';

import '../controller/controller.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  bool moon = false;
  bool anilogo = false;
  bool button = false;

  Duration duration = Duration(milliseconds: 1000);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(duration);
      moon = true;
      setState(() {});
      await Future.delayed(duration);
      anilogo = true;
      setState(() {});
      await Future.delayed(duration);
      button = true;
      setState(() {});
    });
  }

  final text = [
    '운명을 엿볼 시간이에요.',
    '이름을 입력해주세요.',
    '나이를 입력해주세요.',
    '성별을 선택해주세요.',
    '태어난 날짜를 입력해주세요.',
    '태어난 시간을 입력해주세요.',
    '입력한 정보가 맞는지 확인해주세요.',
  ];

  @override
  Widget build(BuildContext context) {
    final screen = [
      startButton(button),
      Input(),
      Input(),
      Sex(),
      Calender(),
      Clock(),
      Check(),
    ];
    return ValueListenableBuilder(
      valueListenable: Controller.currentindex,
      builder: (context, value, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: start(
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: moon ? 1 : 0,
                    duration: duration,
                    child: cloud(context),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: duration,
                      opacity: moon ? 1 : 0,
                      child: Align(
                        alignment: AlignmentGeometry.topLeft,
                        child: Image.asset('assets/image/moon.png', width: 150),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: anilogo
                          ? Controller.currentindex.value == 0
                                ? 100
                                : 0
                          : 200,
                    ),
                    AnimatedOpacity(
                      duration: duration,
                      opacity: anilogo ? 1 : 0,
                      child: logo(text[Controller.currentindex.value]),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: Controller.currentindex.value == 0 ? 100 : 30,
                    ),

                    screen[Controller.currentindex.value],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget startButton(bool button) => AnimatedOpacity(
    duration: duration,
    opacity: anilogo ? 1 : 0,
    child: AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: button ? Color(0xff6f6f6f) : Colors.transparent,
            offset: Offset(0, button ? 5 : 0),
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Controller.currentindex.value++;
        },
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomCenter,
              colors: [Color(0xff7f7f7f), Color(0xff2f004f)],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '시작하기',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
              Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                  width: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


Widget logo(String logo) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image.asset('assets/image/Daily Tarot.png', width: 220),
    Image.asset('assets/image/graphic.png', width: 70),
    Text(logo, style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
  ],
);

Widget start(Widget wiget) => Container(
  width: double.infinity,
  height: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: AlignmentGeometry.topCenter,
      end: AlignmentGeometry.bottomCenter,
      colors: [Color(0xff4f008f), Color(0xff2f004f)],
    ),
  ),
  child: wiget,
);

Widget cloud(BuildContext context) => SizedBox(
  height: 200,
  child: Stack(
    alignment: AlignmentGeometry.center,
    children: [
      posi(120, 0, false),
      posi(-50, 20, true),
      posi(250, 50, false),
      posi(-50, 80, true),
      posi(90, 120, false),
      Positioned(left: 0, right: 0, bottom: 0, child: line()),
      Controller.currentindex.value == 6 ? GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Main()));
        },
        child: Container(
          width: 200,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: AlignmentGeometry.topLeft,
              end: AlignmentGeometry.bottomCenter,
              colors: [Color(0xff7f7f7f), Color(0xff4f006f)],
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '시작하기',
                style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
              ),
              Transform.rotate(
                angle: pi,
                child: SvgPicture.asset(
                  'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                  width: 30,
                ),
              ),
            ],
          ),
        ),
      ) : beforebutton(),
    ],
  ),
);

Widget beforebutton() => AnimatedOpacity(
  opacity: Controller.currentindex.value == 0 ? 0 : 1,
  duration: Duration(milliseconds: 1000),
  child: IgnorePointer(
    ignoring: Controller.currentindex.value == 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Controller.currentindex.value -= 1;
          },
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                  height: 30,
                ),
                Text(
                  '이전',
                  style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: Controller.currentindex.value == 5 ? 10 : 0),
        GestureDetector(
          onTap: () {
            Controller.focusday = DateTime(
              Controller.focusday.year,
              Controller.focusday.month,
              Controller.focusday.day,
            );

            Controller.currentindex.value += 1;
          },
          child: Container(
            width: Controller.currentindex.value == 5 ? 200 : 0,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white10,
            ),
            child: Row(
              children: [
                SizedBox(width: 30),
                Text(
                  '잘 모르겠어요',
                  style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
                ),
                Transform.rotate(
                  angle: pi,
                  child: SvgPicture.asset(
                    'assets/icon/arrow_back_ios_new_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget line() => Opacity(
  opacity: Controller.currentindex.value == 0 || Controller.currentindex.value == 6 ? 0 : 1,
  child: Container(
    width: double.infinity,
    height: 6,
    color: Colors.grey,
    child: Row(
      children: [
        ...List.generate(5, (index) {
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: index < Controller.currentindex.value
                    ? Colors.white
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }),
      ],
    ),
  ),
);

Widget posi(double x, double y, bool flip) => Positioned(
  left: x,
  top: y,
  child: Transform.flip(
    flipX: flip,
    child: Image.asset('assets/image/cloud.png', width: 300),
  ),
);
