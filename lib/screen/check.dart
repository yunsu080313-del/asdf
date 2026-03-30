import 'package:flutter/material.dart';
import 'package:module_110_a/controller/controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14,
      children: [
        che('이름 : ${Controller.name.text}', 1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            che('나이 : ${Controller.age.text}', 2, width: 230),
            GestureDetector(
              onTap: () {
                Controller.currentindex.value = 3;
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white
                  ),
                  shape: BoxShape.circle
                ),
                child: SvgPicture.asset(
                  'assets/icon/${Controller.male ? 'male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg' : 'female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg'}',
                ),
              ),
            )
          ],
        ),
        che('생일 : ${format('yyyy.MM.dd', Controller.focusday)}', 4),
        che('태어난 시간 : ${format('hh:mm', Controller.focusday)}',5)
      ],
    );
  }

  Widget che(String string, int i, {double width = 300}) => GestureDetector(
    onTap: () {
      Controller.currentindex.value = i;
    },
    child: Container(
      alignment: AlignmentGeometry.centerLeft,
      width: width,
      height: 55,
      padding: EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white),
      ),
      child: Text(string, style: TextStyle(fontSize: 20, fontFamily: 'Roboto')),
    ),
  );
}
