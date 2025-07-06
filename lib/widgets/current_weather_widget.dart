import 'package:flutter/material.dart';


import '../model/current.dart';
import '../utils/custom_colors.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final Current current;

  const CurrentWeatherWidget({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        temperatureAreaWidget(),
        const SizedBox(
          height: 20,
        ),
        currentWeatherMoreInfoWidget(),
      ],
    );
  }

  temperatureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset("assets/weather/${current.weather![0].icon}.png"),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${current.temp?.toInt()}°",
              style: const TextStyle(
                  fontSize: 68,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.textColorBlack)),
          TextSpan(
              text: "${current.weather![0].description}",
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey)),
        ]))
      ],
    );
  }

  currentWeatherMoreInfoWidget() {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: CustomColors.cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset("assets/icons/windspeed.png"),
        ),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: CustomColors.cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset("assets/icons/clouds.png"),
        ),
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: CustomColors.cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset("assets/icons/humidity.png"),
        ),
      ]),
      const SizedBox(
        height: 10,
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        SizedBox(
          width: 60,
          height: 20,
          child: Text(
            "${current.windSpeed}km/h",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 60,
          height: 20,
          child: Text(
            "${current.clouds}%",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 60,
          height: 20,
          child: Text(
            "${current.humidity}%",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
      ]
      )
    ]);
  }
}
