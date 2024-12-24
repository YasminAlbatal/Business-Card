import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QR extends StatelessWidget {
  Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('userName') ?? 'Unknown',
      'title': prefs.getString('jobTitle') ?? 'Unknown',
      'company': prefs.getString('company') ?? 'Unknown',
      'phone': prefs.getString('phone') ?? 'Unknown',
      'email': prefs.getString('email') ?? 'Unknown',
      'link': prefs.getString('link') ?? 'Unknown',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      appBar: AppBar(
        title: Text(
          'QR code',
          style: TextStyle(
              fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Color(0xff4B9CD3),
        iconTheme:  IconThemeData(size: 28.sp, color: Colors.white),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<Map<String, String>>(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError || !snapshot.hasData) {
                return const Text(
                  'Error loading user data',
                  style: TextStyle(color: Colors.red),
                );
              } else {
                final userData = snapshot.data!;
                final qrData = """
Name:    ${userData['name']}

Title:  ${userData['title']}

Company:  ${userData['company']}

Phone:  ${userData['phone']}

Email:  ${userData['email']}

Link:  ${userData['link']}
                """;

                return SizedBox(
                  height: 400.h,
                  width: 350.w,
                  child: QrImageView(
                    foregroundColor: const Color(0xff4B9CD3),
                    data: qrData, // Include all user data in the QR code
                    version: QrVersions.auto,
                    size: 350.0.r,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
