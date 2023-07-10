
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:my_cube/Connectivity/connection_check.dart';

class InitBindings implements Bindings{
  @override
  void dependencies() {
    //Networking
    Get.put<Connectivity>(Connectivity(),permanent: true);

    //Controllers
    Get.put<ConnectionCheck>(ConnectionCheck(Get.find<Connectivity>()),permanent: true);
  }
}