import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import '../controller/global_controller.dart';
import '../model/hourly.dart';
import '../utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final List<Hourly> hourly;

  HourlyDataWidget({super.key, required this.hourly});

  final RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        alignment: Alignment.topCenter,
        child: const Text("Today", style: TextStyle(fontSize: 18)),
      ),
      hourlyList(),
    ]);
  }

  hourlyList() {
    return Container(
        height: 160,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: ListView.builder(
          itemCount: hourly.length > 12 ? 14 : hourly.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Obx(() => GestureDetector(
                onTap: () {
                  cardIndex.value = index;
                },
                child: Container(
                  width: 90,
                  margin: const EdgeInsets.only(left: 20, right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0.5, 0),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: Colors.grey.withAlpha(150),
                      )
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor
                          ])
                        : null,
                  ),
                  child: HourlyDetails(
                    temp: hourly[index].temp!.toInt(),
                    timeStamp: hourly[index].dt!,
                    weatherIcon: hourly[index].weather![0].icon!,
                    index: index,
                    cardIndex: cardIndex.value,
                  ),
                )));
          },
        ));
  }
}

class HourlyDetails extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  final int index;
  final int cardIndex;

  String getTime(final int timeStamp) {
    var time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat.jm().format(time);
  }

  const HourlyDetails({
    super.key,
    required this.temp,
    required this.timeStamp,
    required this.weatherIcon,
    required this.index,
    required this.cardIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(getTime(timeStamp), style: TextStyle(color: cardIndex == index ? Colors.white : CustomColors.textColorBlack)),
        ),
        Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(top: 5),
            child: Image.asset("assets/weather/$weatherIcon.png")),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text("$temp°", style: TextStyle(color: cardIndex == index ? Colors.white : CustomColors.textColorBlack)),
        )
      ],
    );
  }
}
