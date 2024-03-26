import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:studentdataapplication/view/core/constant.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.pickedimage,
    this.radius,
  });

  final RxString pickedimage;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Obx(() => CircleAvatar(
          radius: radius,
          backgroundColor: const  Color.fromARGB(255, 158, 186, 235),
          backgroundImage: pickedimage.isNotEmpty
              ? FileImage(File(pickedimage.value))
              : null,
          child: pickedimage.isEmpty
              ?  Icon(
                  Icons.person,
                  color: Constants().kwhiteColor,
                  size: 35,
                )
              : null,
        ));
  }
}
