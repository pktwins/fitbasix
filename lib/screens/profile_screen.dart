import 'dart:io';

import 'package:fitbasix_task/controllers/profile_controller.dart';
import 'package:fitbasix_task/utils/colors.dart';
import 'package:fitbasix_task/utils/fonts.dart';
import 'package:fitbasix_task/utils/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Profile_Screen extends StatefulWidget {
  Profile_Screen({super.key});
  var profile_controller = Get.find<Profile_Controller>();

  @override
  State<Profile_Screen> createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {
  var name_controller = TextEditingController();
  var imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var imagedata = widget.profile_controller.image;
    var namedata = widget.profile_controller.name;

    if (imagedata != null) {
      imageFile = imagedata;
    }
    if (namedata != null) {
      name_controller.text = namedata;
    } else {
      name_controller.text = "Pavan";
    }
  }

  @override
  Widget build(BuildContext context) {
    var screensize = MediaQuery.of(context).size;
    return Container(
        height: screensize.height * 0.5,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Update Profile",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: AppFonts.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(children: [
              imageFile != null
                  ? InkWell(
                      onTap: () {
                        pickImageFromGallery();
                      },
                      child: ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Image.file(
                            File(imageFile.path),
                            fit: BoxFit.cover,
                            width: 128,
                            height: 128,
                          ),
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: Ink.image(
                          image: AssetImage(AppAssets.boy),
                          fit: BoxFit.cover,
                          width: 128,
                          height: 128,
                          child: InkWell(onTap: () {
                            pickImageFromGallery();
                          }),
                        ),
                      ),
                    ),
              Positioned(
                bottom: 0,
                right: 4,
                child: InkWell(
                  onTap: () {
                    pickImageFromGallery();
                  },
                  child: ClipOval(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: AppColors.blue_color,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              )
            ]),
            SizedBox(height: 20),
            Container(
              height: 40,
              width: screensize.width * 0.5,
              child: TextFormField(
                onChanged: (v) {},
                controller: name_controller,
                //validator: validate,
                style: TextStyle(fontFamily: "BrandonMed"),
                decoration: InputDecoration(
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Name",
                    hintStyle: TextStyle(fontFamily: AppFonts.regular),
                    labelStyle: TextStyle(
                        color: Colors.black,
                        height: 0.8,
                        fontFamily: AppFonts.regular
                        // background: Paint
                        ),
                    contentPadding:
                        EdgeInsets.only(left: 14, bottom: 8, top: 8),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(25.7)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(25.7)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.7)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.circular(25.7))),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xFF0170d0))),
                  child: ElevatedButton(
                    onPressed: () {
                      if (name_controller.text.isNotEmpty &&
                          imageFile != null) {
                        onSaved();
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'BrandonMed'),
                    ),
                    style: ElevatedButton.styleFrom(
                        //    primary: Colors.purple,
                        primary: Color(0xFF0170d0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  onSaved() {
    widget.profile_controller.updateimage(imageFile);
    widget.profile_controller.updatename(name_controller.text);

    showmyalert();
  }

  showmyalert() {
    Navigator.of(context).pop();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Update Profile',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontFamily: AppFonts.bold),
          ),
          content: Text(
            "SuccessFully Updated!",
            style: TextStyle(
                color: Colors.green, fontSize: 15, fontFamily: AppFonts.bold),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  pickImageFromGallery() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          imageFile = pickedImage;
        });
        //   widget.profile_controller.updateimage(pickedImage);
      }
    } catch (e) {}
  }
}
