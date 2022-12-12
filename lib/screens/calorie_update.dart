import 'package:fitbasix_task/controllers/data_controller.dart';
import 'package:fitbasix_task/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Update_Calorie extends StatefulWidget {
  Update_Calorie({super.key});
  var data_controller = Get.find<Data_Controller>();

  @override
  State<Update_Calorie> createState() => _Update_CalorieState();
}

class _Update_CalorieState extends State<Update_Calorie> {
  var currentvalue = 2500.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var tempvalue = widget.data_controller.calorie_value;
    currentvalue = double.parse("$tempvalue");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Update Calories',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontFamily: AppFonts.bold),
      ),
      content: Container(
        height: 80,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "0",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: AppFonts.bold),
                ),
                Container(
                  height: 50,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                    ),
                    child: Slider(
                        min: 0.0,
                        max: 5000.0,
                        //  divisions: 1000,
                        thumbColor: Color(0xFF0170d0),
                        activeColor: Color(0xFF0170d0),
                        inactiveColor: Colors.grey,
                        value: currentvalue,
                        label: "$currentvalue",
                        onChangeEnd: (value) {
                          setState(() {
                            currentvalue =
                                double.parse("${value.toStringAsFixed(0)}");
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            currentvalue =
                                double.parse("${value.toStringAsFixed(0)}");
                          });
                        }),
                  ),
                ),
                Text(
                  "5000",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontFamily: AppFonts.bold),
                ),
              ],
            ),
            Text(
              "Value : ${currentvalue.toStringAsFixed(0)}",
              style: TextStyle(
                  color: Colors.black, fontSize: 15, fontFamily: AppFonts.bold),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Update'),
          onPressed: () {
            widget.data_controller
                .updatecalorievalue(int.parse(currentvalue.toStringAsFixed(0)));

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
