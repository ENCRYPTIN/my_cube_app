import 'package:flutter/material.dart';

class CustomBanner {
  CustomBanner._();
  static showBanner(
      BuildContext context, String message, Color bgColor, Duration? duration) {
    ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
      content: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              message,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
      actions: [Container()],
      backgroundColor: bgColor,
    ));
  }
}
