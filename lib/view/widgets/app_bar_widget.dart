import 'package:flutter/material.dart';

import 'package:studentdataapplication/view/core/constant.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    super.key,
    this.lefticon,
    this.righticon,
    required this.title,
    this.onTapLeft,
    this.onTapRight,
  });
  final IconData? lefticon;
  final IconData? righticon;
  final String title;
  final void Function()? onTapLeft;
  final void Function()? onTapRight;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      
      title: Text(
        title,
        
        style: const TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w700),
      ),
      elevation: 0,
      leading: InkWell(
        child: Icon(
          lefticon,
          color: Constants().kwhiteColor,
          size: 30,
        ),
        onTap: () {
          onTapLeft!();
         
            
        },
      ),
      actions: [
        InkWell(
          child: Icon(
            righticon,
            
            color: Constants().kwhiteColor,
            
            size: 30,
          ),
          onTap: () {
            onTapRight!();
          },
        )
      ],
      centerTitle: true,
      backgroundColor: Constants().kblueAsscent,
    );
  }
}