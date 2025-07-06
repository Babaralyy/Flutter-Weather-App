import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controller/global_controller.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  String cityName = "";
  String date = DateFormat("yMMMMd").format(DateTime.now());

  final GlobalController globalController =
  Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress(globalController.getLatitude().value, globalController.getLongitude().value);
    super.initState();
  }

  void getAddress(lat, long) async{
   List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
   Placemark place = placeMarks[0];
   setState(() {
     cityName = place.locality!;
   });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.topLeft,
          child: Text(cityName, style: const TextStyle(fontSize: 35, height: 2),),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(date, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey[700], height: 1.5),),
        ),
      ],
    );
  }
}
