import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Text_Field extends StatelessWidget {
  String label;
  TextEditingController? control;
  Text_Field({required this.label,required this.control});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:control ,
      decoration: InputDecoration(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.r, vertical: 22.r),
          labelText: label,
          hintStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r))),
    );
  }

}