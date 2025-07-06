import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/daily.dart';
import '../utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final List<Daily> weatherInfoDaily;

  const DailyDataForecast({super.key, required this.weatherInfoDaily});

  String getDay(final ts) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(ts * 1000);
    String day = DateFormat('EEEE').format(date);
    return day;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.dividerLine.withAlpha(150),
      ),
      child: Column(children: [
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "Next Days",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: CustomColors.textColorBlack,
            ),
          ),
        ),
        dailyList(),
      ]),
    );
  }

  Widget dailyList() {
    return SizedBox(
        height: 300,
        child: ListView.builder(
          itemCount: weatherInfoDaily.length > 7 ? 7 : weatherInfoDaily.length,
          itemBuilder: (context, index) {
            return Column(children: [
              Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          getDay(weatherInfoDaily[index].dt),
                          style: const TextStyle(
                              color: CustomColors.textColorBlack, fontSize: 13),
                        )
                      ),
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                            "assets/weather/${weatherInfoDaily[index].weather![0].icon}.png"),
                      ),
                      Text(
                        "${weatherInfoDaily[index].temp!.max!.toInt()}°/${weatherInfoDaily[index].temp!.min!.toInt()}°",
                        style: const TextStyle(
                            color: CustomColors.textColorBlack, fontSize: 13),
                      ),
                    ],
                  )
              ),
            ]);
          },
        ));
  }
}
