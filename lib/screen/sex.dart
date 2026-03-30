import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:module_110_a/controller/controller.dart';

class Sex extends StatefulWidget {
  const Sex({super.key});

  @override
  State<Sex> createState() => _SexState();
}

class _SexState extends State<Sex> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Controller.male = false;
                Controller.currentindex.value++;
              },
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white),
                ),
                child: SvgPicture.asset(
                  'assets/icon/female_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                  width: 50,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Controller.currentindex.value++;
              },
              child: Container(
                alignment: Alignment.center,
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white),
                ),
                child: SvgPicture.asset(
                  'assets/icon/male_24dp_E3E3E3_FILL0_wght100_GRAD0_opsz24.svg',
                  width: 50,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
