import 'package:get/get.dart';

class Profile_Controller extends GetxController {
  var image;
  var tempimage;
  var name;
  bool imageupdated = false;
  updateimage(data) {
    image = data;
    update();
  }

  updatename(data) {
    name = data;
    update();
  }

  cleartempimage() {
    tempimage = null;
    update();
  }
}
