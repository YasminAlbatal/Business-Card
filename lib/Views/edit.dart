

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_business_card/Views/Home.dart';
import 'package:task_business_card/Widget/text_field.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _titleController = TextEditingController();
  final _companyController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // تحميل البيانات الحالية
    _loadUserData();
  }

  // تحميل البيانات الحالية من SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('userName') ?? '';
      _titleController.text = prefs.getString('jobTitle') ?? '';
      _companyController.text = prefs.getString('company') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _linkController.text = prefs.getString('link') ?? '';
    });
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _nameController.text);
    await prefs.setString('jobTitle', _titleController.text);
    await prefs.setString('company', _companyController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('link', _linkController.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color:Colors.white ,size: 26.sp),
        title: Text(
          'Edit',
          style: TextStyle(
              fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color(0xff4B9CD3),
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(left: 25.0.r,right:25.0.r ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text_Field(label: 'Name', control: _nameController),

              Text_Field(label: 'Job Title', control: _titleController),

              Text_Field(label: 'Company', control: _companyController),

              Text_Field(label: 'Phone', control: _phoneController),

              Text_Field(label: 'Email', control: _emailController),

              Text_Field(label: 'Linkedin', control: _linkController),

              ElevatedButton(
                onPressed: _saveUserData,
                child: SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: Center(
                        child: Text(
                      'Save',
                      style: TextStyle(fontSize: 22.sp, color: Colors.white),
                    ))),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4B9CD3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
