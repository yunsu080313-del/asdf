import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module_110_a/controller/controller.dart';

class Calender extends StatefulWidget {
  const Calender({super.key});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [title(),Cal()]);
  }

  Widget Cal() {
    final date = DateTime(Controller.focusday.year, Controller.focusday.month);

    final firstOffset = DateUtils.firstDayOffset(date.year, date.month, DefaultMaterialLocalizations());
    final monthInday = DateUtils.getDaysInMonth(date.year, date.month);
    final endOffset = DateUtils.firstDayOffset(date.year, date.month + 1, DefaultMaterialLocalizations());

    return Container(
      width: 300,
      height: 50.0 * ((monthInday+endOffset)/7).ceil(),
      child: Wrap(
        children: [
          ...List.generate(firstOffset, (index) => cell(date.subtract(Duration(days: firstOffset - index)), false)),
          ...List.generate(monthInday, (index) => cell(DateUtils.addDaysToDate(date, index), true)),
          ...List.generate(endOffset, (index) => cell(DateUtils.addDaysToDate(DateTime(date.year,date.month+1), index), false),)
        ],
      ),
    );
  }

  Widget cell(DateTime date,bool thisday) => GestureDetector(
    onTap: () {
      Controller.focusday = DateTime(date.year,date.month,date.day);
      Controller.currentindex.value++;
    },
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 300/7,
      child: Text('${date.day}',style: TextStyle(color: thisday ? Colors.white:Colors.grey,fontSize: 18),),
    ),
  );

  Widget title() => GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 250,
            color: Color(0xff2f004f),
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.monthYear,
                minimumYear: 1900,
                initialDateTime: Controller.focusday,
                maximumYear: DateTime.now().year,
                onDateTimeChanged: (value) {
                  Controller.focusday = value;
                  setState(() {

                  });
                },
              ),
            ),
          );
        },
      );
    },
    child: Text(
      format('yyyy.MM', Controller.focusday),
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
  );
}
