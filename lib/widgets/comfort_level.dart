import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../model/current.dart';
import '../utils/custom_colors.dart';

class ComfortLevel extends StatelessWidget {
  final Current current;

  const ComfortLevel({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(15),
          child: const Text("Comfort Level", style: TextStyle(fontSize: 18),)
        ),
        SizedBox(
          height: 240,
          child: Column(
            children: [
              Center(
                child: SleekCircularSlider(
                  min: 0,
                  max: 100,
                  initialValue: current.humidity!.toDouble(),
                  appearance: CircularSliderAppearance(
                    infoProperties: InfoProperties(
                      bottomLabelText: "Humidity",
                      bottomLabelStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: CustomColors.textColorBlack
                      ),

                    ),
                    animationEnabled: true,
                    size: 180,
                    customWidths: CustomSliderWidths(
                      handlerSize: 0,
                      trackWidth: 12,
                      progressBarWidth: 12
                    ),
                    customColors: CustomSliderColors(
                      hideShadow: true,
                      trackColor: CustomColors.firstGradientColor.withAlpha(50),
                      progressBarColors: [CustomColors.firstGradientColor, CustomColors.secondGradientColor]
                    )
                  )
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(text: "Feels Like ", style: TextStyle(color: CustomColors.textColorBlack, fontSize: 14, fontWeight: FontWeight.w400)),
                        TextSpan(text: "${current.feelsLike!.toInt()}°", style: const TextStyle(color: CustomColors.textColorBlack, fontSize: 18, fontWeight: FontWeight.w600))
                      ]
                    )
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    width: 2,
                    color: CustomColors.dividerLine,
                  ),
                  RichText(
                      text: TextSpan(
                          children: [
                            const TextSpan(text: "UV Index ", style: TextStyle(color: CustomColors.textColorBlack, fontSize: 14, fontWeight: FontWeight.w400)),
                            TextSpan(text: "${current.uvi!.toInt()}", style: const TextStyle(color: CustomColors.textColorBlack, fontSize: 18, fontWeight: FontWeight.w600))
                          ]
                      )
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
