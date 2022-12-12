import 'dart:async';

import 'package:get/get.dart';

class Data_Controller extends GetxController {
  int calorie_value = 1400;
  int animated_value = 0;
  int water_value = 3000;
  bool isupdating = false;

  updateanimatedvalue() {
    animated_value = 0;
    Timer.periodic(const Duration(milliseconds: 1), (_timer) {
      if (animated_value == calorie_value) {
      } else {
        animated_value++;
        update();
      }
    });
  }

  updatecalorievalue(value) {
    calorie_value = value;
    update();
  }

  updatebusy(data) {
    isupdating = data;
    update();
  }

  updatewatervalue(value) {
    water_value = value;
    update();
  }
}
