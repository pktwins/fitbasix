import 'dart:async';
import 'dart:io';

import 'package:fitbasix_task/controllers/data_controller.dart';
import 'package:fitbasix_task/controllers/profile_controller.dart';
import 'package:fitbasix_task/screens/calorie_update.dart';
import 'package:fitbasix_task/screens/profile_screen.dart';
import 'package:fitbasix_task/screens/water_bottle.dart';
import 'package:fitbasix_task/screens/water_update.dart';
import 'package:fitbasix_task/utils/colors.dart';
import 'package:fitbasix_task/utils/fonts.dart';
import 'package:fitbasix_task/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'dart:ui' as ui;

import 'package:syncfusion_flutter_gauges/gauges.dart';

class Home_Screen extends StatefulWidget {
  Home_Screen({super.key});
  var data_controller = Get.find<Data_Controller>();

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final waterBottleRef = GlobalKey<WaterBottleState>();

  int _progressValue = 0;
  var _timer;
  int _fatcurrentValue = 30;
  int _proteincurrentValue = 80;
  int _carbscurrentValue = 60;
  var today = DateTime.now();

  Map<String, double> dataMap = {
    "Water": 4,
    "Coke": 1,
    "Coffee": 2,
    "Juice": 3,
  };
  List<Color> colorsList = [
    Colors.blue[300]!,
    Colors.yellow[300]!,
    Colors.purple[300]!,
    Colors.teal[300]!
  ];
  ValueNotifier<double>? valueNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // valueNotifier = ValueNotifier(0.0);
    // widget.data_controller.updateanimatedvalue();
    var tempvalue = widget.data_controller.calorie_value;
    _timer = Timer.periodic(const Duration(milliseconds: 1), (_timer) {
      if (_progressValue == tempvalue) {
      } else {
        setState(() {
          _progressValue++;
        });
      }
    });
  }

  // updateprogress(calvalue, isbusy) {
  //   if (isbusy) {
  //   } else {
  //     _progressValue = 0;
  //     var tempvalue = calvalue;
  //     _timer = Timer.periodic(const Duration(milliseconds: 1), (_timer) {
  //       if (_progressValue == tempvalue) {
  //         widget.data_controller.updatebusy(false);
  //       } else {
  //         setState(() {
  //           _progressValue++;
  //         });
  //         widget.data_controller.updatebusy(true);
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white_color,
        body: Column(
          children: [
            GetBuilder<Profile_Controller>(builder: (snapshot) {
              return InkWell(
                onTap: () {
                  showprofilesheet();
                },
                child: Container(
                  height: screensize.height * 0.1,
                  //color: Colors.red,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 5, right: 10),
                    // onTap: () {},
                    leading: snapshot.image != null
                        ? ClipOval(
                            child: Material(
                            color: Colors.transparent,
                            child: Image.file(
                              File(snapshot.image.path),
                              height: 55,
                              width: 55,
                              fit: BoxFit.cover,
                            ),
                          ))
                        : Container(
                            height: 80,
                            width: 80,
                            child: Image.asset(AppAssets.boy)),
                    title: Text(
                      snapshot.name == null
                          ? "Hello Pavan!"
                          : "Hello ${snapshot.name}!",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: AppFonts.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Thursday, 08 July",
                      style: TextStyle(
                        fontFamily: AppFonts.medium,
                      ),
                    ),
                    trailing: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white)),
                      child: Icon(
                        Icons.notifications_none_outlined,
                        color: AppColors.black_color,
                      ),
                    ),
                  ),
                ),
              );
            }),
            GestureDetector(
              onTap: () {
                showCalorieAlert();
              },
              child: GetBuilder<Data_Controller>(builder: (snapshot) {
                var consumed = snapshot.calorie_value;
                var remaining = 5000 - snapshot.calorie_value;
                // valueNotifier!.value =
                //     double.parse("${snapshot.calorie_value}");
                return Container(
                  height: screensize.height * 0.35,
                  width: screensize.width * 0.95,
                  decoration: BoxDecoration(
                      color: AppColors.calorie_bg,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // width: screensize.width * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Calories InTake",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: AppFonts.bold),
                            ),
                            SizedBox(height: 5),
                            Text("Recommended 5000 kcal",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: AppFonts.medium)),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  "$consumed kcal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: AppFonts.bold),
                                ),
                                SizedBox(height: 5),
                                Text("Consumed",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: AppFonts.medium)),
                              ],
                            ),
                          ),
                          Container(
                            // width: screensize.width * 0.4,
                            child: Column(
                              children: [
                                Container(
                                  //  color: Colors.red,
                                  height: 150,
                                  width: 150,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        minimum: 0,
                                        maximum: 5000,
                                        showLabels: false,
                                        showTicks: false,
                                        startAngle: 270,
                                        endAngle: 270,
                                        axisLineStyle: AxisLineStyle(
                                          thickness: 0.2,
                                          cornerStyle: CornerStyle.bothCurve,
                                          color: Colors.red[50]!,
                                          thicknessUnit: GaugeSizeUnit.factor,
                                        ),
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                            value: consumed != 1400
                                                ? double.parse("$consumed")
                                                : double.parse(
                                                    "$_progressValue"),
                                            cornerStyle: CornerStyle.bothCurve,
                                            width: 0.2,
                                            color: Colors.red,
                                            sizeUnit: GaugeSizeUnit.factor,
                                          )
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              positionFactor: 0.1,
                                              angle: 90,
                                              widget: Text(
                                                (consumed != 1400
                                                        ? consumed
                                                            .toStringAsFixed(0)
                                                        : _progressValue
                                                            .toStringAsFixed(
                                                                0)) +
                                                    ' / 5000',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily:
                                                        AppFonts.medium),
                                              ))
                                        ])
                                  ]),

                                  //  SimpleCircularProgressBar(
                                  //   //  maxValue: 100,
                                  //   animationDuration: 10,

                                  //   backColor: Colors.red[50]!,
                                  //   valueNotifier: valueNotifier,
                                  //   fullProgressColor: Colors.red,
                                  //   progressColors: [Colors.red, Colors.red],
                                  //   mergeMode: true,
                                  //   onGetText: (double value) {
                                  //     return Text(
                                  //       ' ${value.toInt()}%',
                                  //       textDirection: TextDirection.ltr,
                                  //       style: const TextStyle(
                                  //         //fontSize: 30,
                                  //         fontFamily: AppFonts.medium,
                                  //         color: Colors.black,
                                  //       ),
                                  //     );
                                  //   },
                                  // ),

                                  //  SfRadialGauge(axes: <RadialAxis>[
                                  //   RadialAxis(
                                  //     minimum: 0,
                                  //     maximum: 50,
                                  //     showLabels: false,
                                  //     showTicks: false,
                                  //     startAngle: 270,
                                  //     endAngle: 270,
                                  //     axisLineStyle: AxisLineStyle(
                                  //       thickness: 0.2,
                                  //       cornerStyle: CornerStyle.bothCurve,
                                  //       color: Color(0xFFF2EADF),
                                  //       thicknessUnit: GaugeSizeUnit.factor,
                                  //     ),
                                  //     pointers: <GaugePointer>[
                                  //       RangePointer(
                                  //         value:
                                  //             double.parse("$_progressValue"),
                                  //         cornerStyle: CornerStyle.bothCurve,
                                  //         width: 0.2,
                                  //         sizeUnit: GaugeSizeUnit.factor,
                                  //         color: Colors.red,
                                  //       )
                                  //     ],
                                  //   )
                                  // Create primary radial axis
                                  // RadialAxis(
                                  //   minimum: 0,
                                  //   maximum: 50,
                                  //   showLabels: false,
                                  //   showTicks: false,
                                  //   startAngle: 270,
                                  //   endAngle: 270,
                                  //   radiusFactor: 0.7,
                                  //   axisLineStyle: AxisLineStyle(
                                  //     thickness: 0.3,
                                  //     color: Color(0xFFF2EADF),
                                  //     thicknessUnit: GaugeSizeUnit.factor,
                                  //   ),
                                  //   pointers: <GaugePointer>[
                                  //     RangePointer(
                                  //       value: double.parse("$_progressValue"),
                                  //       width: 0.05,
                                  //       pointerOffset: 0.07,
                                  //       sizeUnit: GaugeSizeUnit.factor,
                                  //     )
                                  //   ],
                                  // ),
                                  // Create secondary radial axis for segmented line
                                  // RadialAxis(
                                  //   minimum: 0,
                                  //   interval: 1,
                                  //   maximum: 4,
                                  //   showLabels: false,
                                  //   showTicks: true,
                                  //   showAxisLine: false,
                                  //   tickOffset: -0.05,
                                  //   offsetUnit: GaugeSizeUnit.factor,
                                  //   minorTicksPerInterval: 0,
                                  //   startAngle: 270,
                                  //   endAngle: 270,
                                  //   radiusFactor: 0.3,
                                  //   majorTickStyle: MajorTickStyle(
                                  //       length: 0.3,
                                  //       thickness: 3,
                                  //       lengthUnit: GaugeSizeUnit.factor,
                                  //       color: Colors.red),
                                  // )
                                  // ]),
                                )
                              ],
                            ),
                          ),
                          Container(
                            // width: screensize.width * 0.25,
                            child: Column(
                              children: [
                                Text(
                                  "$remaining kcal",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: AppFonts.bold),
                                ),
                                SizedBox(height: 5),
                                Text("Remaining",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: AppFonts.medium)),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 80,
                            // height: 100,
                            child: Column(
                              children: [
                                Text("P - 10/12g",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: AppFonts.medium)),
                                Container(
                                  height: 5,
                                  child: FAProgressBar(
                                    animatedDuration: Duration(seconds: 1),

                                    currentValue:
                                        double.parse("$_proteincurrentValue"),
                                    progressColor: Colors.black,
                                    backgroundColor: Colors.grey[500]!,

                                    //displayText: '%',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            //height: 100,
                            child: Column(
                              children: [
                                Text("C - 10/12g",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: AppFonts.medium)),
                                Container(
                                  height: 5,
                                  child: FAProgressBar(
                                    animatedDuration: Duration(seconds: 1),

                                    currentValue:
                                        double.parse("$_carbscurrentValue"),
                                    progressColor: Color(0xFF12A670),
                                    backgroundColor: Color(0x8012A670),

                                    //displayText: '%',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            //height: 100,
                            child: Column(
                              children: [
                                Text("F - 10/12g",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                        fontFamily: AppFonts.medium)),
                                Container(
                                  height: 5,
                                  child: FAProgressBar(
                                    animatedDuration: Duration(seconds: 1),
                                    currentValue:
                                        double.parse("$_fatcurrentValue"),
                                    progressColor: Colors.orange,
                                    backgroundColor: Colors.orange[100]!,
                                    //displayText: '%',
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                showWaterAlert();
              },
              child: GetBuilder<Data_Controller>(builder: (snapshot) {
                var consumed = snapshot.water_value;
                var percent = consumed / 5000 * 100;
                var waterlevel = percent / 100;
                print(waterlevel);

                return Container(
                  height: screensize.height * 0.35,
                  width: screensize.width * 0.95,
                  decoration: BoxDecoration(
                      color: AppColors.water_bg,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            // width: screensize.width * 0.25,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Water InTake",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: AppFonts.bold),
                                ),
                                SizedBox(height: 5),
                                Text("Recommended 5L",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: AppFonts.medium)),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${consumed}ml/5000ml",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 15,
                                          fontFamily: AppFonts.bold),
                                    ),
                                    Text(" - "),
                                    Text(
                                      "${percent.toStringAsFixed(0)}%",
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 18,
                                          fontFamily: AppFonts.bold),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: screensize.width * 0.6,
                                  child: PieChart(
                                    dataMap: dataMap,
                                    animationDuration:
                                        Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: colorsList,
                                    initialAngleInDegree: 0,
                                    chartType: ChartType.ring,
                                    ringStrokeWidth: 20,
                                    //  centerText: "HYBRID",
                                    legendOptions: LegendOptions(
                                      showLegendsInRow: false,
                                      legendPosition: LegendPosition.right,
                                      showLegends: true,
                                      // legendShape:S,
                                      legendTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValueBackground: true,
                                      showChartValues: true,
                                      showChartValuesInPercentage: true,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 0,
                                    ),
                                    // gradientList: ---To add gradient colors---
                                    // emptyColorGradient: ---Empty Color gradient---
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: screensize.height * 0.3,
                            width: 80,
                            child: WaterBottle(
                              key: waterBottleRef,
                              waterlevel: waterlevel,
                              waterColor: AppColors.blue_color,
                              bottleColor: AppColors.black_color,
                              capColor: AppColors.blue_grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),

      // Center(
      //     child: Container(
      //         height: 300,
      //         width: 75,
      //         child: WaterBottle(
      //           waterColor: AppColors.blue_color,
      //           bottleColor: AppColors.black_color,
      //           capColor: AppColors.blue_grey,
      //         )))),
    );
  }

  showprofilesheet() {
    showModalBottomSheet(
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: Color(0xFFebf6ff),
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Profile_Screen(),
            ));
  }

  showCalorieAlert() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Update_Calorie();
        });
  }

  showWaterAlert() async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return Update_Water();
        });
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = AppColors.blue_color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.5006667, size.height * 0.2460000);
    path0.quadraticBezierTo(size.width * 0.4733750, size.height * 0.2297143,
        size.width * 0.5005000, size.height * 0.2140000);
    path0.cubicTo(
        size.width * 0.5109167,
        size.height * 0.2136429,
        size.width * 0.5310833,
        size.height * 0.2140714,
        size.width * 0.5415000,
        size.height * 0.2137143);
    path0.quadraticBezierTo(size.width * 0.5683750, size.height * 0.2305714,
        size.width * 0.5423333, size.height * 0.2445714);
    path0.quadraticBezierTo(size.width * 0.5417083, size.height * 0.2992143,
        size.width * 0.5415000, size.height * 0.3174286);
    path0.quadraticBezierTo(size.width * 0.5859167, size.height * 0.3181429,
        size.width * 0.5831667, size.height * 0.3888571);
    path0.lineTo(size.width * 0.5831667, size.height * 0.7431429);
    path0.lineTo(size.width * 0.4590000, size.height * 0.7445714);
    path0.quadraticBezierTo(size.width * 0.4590000, size.height * 0.4788571,
        size.width * 0.4590000, size.height * 0.3902857);
    path0.quadraticBezierTo(size.width * 0.4556667, size.height * 0.3141429,
        size.width * 0.4990000, size.height * 0.3188571);
    path0.lineTo(size.width * 0.5008333, size.height * 0.2474286);
    path0.lineTo(size.width * 0.5421667, size.height * 0.2448571);
    path0.lineTo(size.width * 0.5420000, size.height * 0.3180000);
    path0.lineTo(size.width * 0.4995000, size.height * 0.3185714);
    path0.lineTo(size.width * 0.5420000, size.height * 0.3177143);
    path0.lineTo(size.width * 0.5420000, size.height * 0.3188571);
    path0.lineTo(size.width * 0.4990000, size.height * 0.3185714);
    path0.lineTo(size.width * 0.4990000, size.height * 0.3185714);
    path0.lineTo(size.width * 0.5416667, size.height * 0.3185714);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
