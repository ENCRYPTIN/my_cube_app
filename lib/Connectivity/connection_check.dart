import 'dart:developer';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_cube/Widgets/custom_banner.dart';
import 'package:my_cube/services/utils.dart';


class ConnectionCheck extends GetxController {
  late Connectivity _connectivity;
  ConnectionCheck(this._connectivity);
  RxBool isConnected = true.obs;
  StreamSubscription? subscription;

   listenToNetworkChanges(BuildContext context) {
    subscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile) {
        isConnected.value = true;
        log("Connected");
      } else if (connectivityResult == ConnectivityResult.wifi) {
        isConnected.value = true;
        log("Connected");
      } else {
        isConnected.value = false;
        log("Not Connected");
        // CustomBanner.showBanner(context, "No Internet Connection",
        //     Colors.black, const Duration(days: 365));
        showSnackBar(context, "No Network");
      }
    });
  }

  @override
  void onClose() {
    subscription!.cancel();
    super.onClose();
  }
}
