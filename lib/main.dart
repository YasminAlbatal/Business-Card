import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Views/Home.dart';
import 'Widget/Textformfield.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<bool> checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true;
  }

  @override
  Widget build(BuildContext context) {


    return ScreenUtilInit(
      designSize: Size(411, 823),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: checkFirstTime(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == true) {
              return WelcomeScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  Future<void> saveData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstTime', false);
    prefs.setString('userName', nameController.text);
    prefs.setString('jobTitle', titleController.text);
    prefs.setString('company', companyController.text);
    prefs.setString('phone', phoneController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('link', linkController.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF3F4F6),
      appBar: AppBar(
        title: Center(
            child: Text(
          'Welcome',
          style: TextStyle(
              fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.w500),
        )),
        backgroundColor: Color(0xff4B9CD3),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding:  EdgeInsets.all(50.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text_form_field(
                hint: 'Enter your name',
                label: 'Name',
                control: nameController,
              ),
              Text_form_field(
                hint: 'Enter your job',
                label: 'Title',
                control: titleController,
              ),
              Text_form_field(
                  hint: 'Enter your company',
                  label: 'Company',
                  control: companyController),
              Text_form_field(
                  hint: 'Enter your Phone',
                  label: 'Phone',
                  control: phoneController),
              Text_form_field(
                  hint: 'Enter your Email',
                  label: 'Email',
                  control: emailController),
              Text_form_field(
                  hint: 'enter the link',
                  label: 'Linkedin',
                  control: linkController),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    saveData(context);
                  }
                },
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
