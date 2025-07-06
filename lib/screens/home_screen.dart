import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/global_controller.dart';
import '../utils/custom_colors.dart';
import '../widgets/comfort_level.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_data_forecast.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Obx(() => globalController.checkLoading().isTrue
          ?  Center(
              child: Image.asset("assets/icons/clouds.png", height: 200, width: 200,),
            )
          : ListView(
              scrollDirection: Axis.vertical,
              children:[
                const SizedBox(height: 20,),
                const HeaderWidget(),
                CurrentWeatherWidget(current: globalController.getWeatherInfo().value.current!),
                HourlyDataWidget(hourly: globalController.getWeatherInfo().value.hourly!),
                DailyDataForecast(weatherInfoDaily: globalController.getWeatherInfo().value.daily!),
                Container(
                  height: 1,
                  color: CustomColors.dividerLine,
                ),
                const SizedBox(
                  height: 10,
                ),
                ComfortLevel(current: globalController.getWeatherInfo().value.current!),
              ],
            )),
    ));
  }
}
