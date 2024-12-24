import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Text_form_field extends StatelessWidget {
  String hint;
  String label;
  TextEditingController? control;
  Text_form_field({required this.hint,required this.label,required this.control});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:control ,
      validator:(value)
      {
        if(value?.isEmpty??true)
        {
          return "field is required";
        }
        else
        {
          return null;
        }
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.r,
            vertical: 22.r,
          ),
          hintText: hint,
          labelText: label,
          hintStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
          )),
    );
  }
}
