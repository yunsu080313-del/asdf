import 'package:flutter/material.dart';
import 'package:module_110_a/controller/controller.dart';

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 50,
      padding: EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        style: TextStyle(
          color: Colors.white,
          fontSize: 18
        ),
        onSubmitted: (value) {
          if (Controller.currentindex.value == 1) {
            if (value.length >= 2 && value.length <= 20) {
              Controller.currentindex.value++;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('이름은 2자 이상 20이하만 가능합니다.'))
              );
            }
          } else {
            if (int.tryParse(value) != null) {
              Controller.currentindex.value++;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('나이는 숫자만 입력가능합니다.'))
              );
            }
          }
        },
        controller: Controller.currentindex.value == 1
            ? Controller.name
            : Controller.age,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: Controller.currentindex.value == 1
              ? '이름을 입력해주세요.'
              : '나이를 입력해주세요.',
          hintStyle: TextStyle(color: Colors.grey, fontFamily: 'Roboto'),

        ),
      ),
    );
  }
}
