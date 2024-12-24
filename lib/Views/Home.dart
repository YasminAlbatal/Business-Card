import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'QR.dart';
import 'edit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> userData = {
    'name': 'Unknown',
    'title': 'Unknown',
    'company': 'Unknown',
    'phone': 'Unknown',
    'email': 'Unknown',
    'link': 'Unknown',
  };

  // This method will get the user data from SharedPreferences and update the state
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userData = {
        'name': prefs.getString('userName') ?? 'Unknown',
        'title': prefs.getString('jobTitle') ?? 'Unknown',
        'company': prefs.getString('company') ?? 'Unknown',
        'phone': prefs.getString('phone') ?? 'Unknown',
        'email': prefs.getString('email') ?? 'Unknown',
        'link': prefs.getString('link') ?? 'Unknown',
      };
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData(); // Fetch user data when the screen is initialized
  }

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: userData['email'],
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Business Card',
            style: TextStyle(
                fontSize: 25.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
        ),
        backgroundColor: Color(0xff4B9CD3),
      ),
      backgroundColor: Color(0xffF3F4F6),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    userData['name']!,
                    style: TextStyle(
                      color: Color(0xff1F2937),
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    userData['title']!,
                    style: TextStyle(color: Color(0xff1F2937), fontSize: 22),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    userData['company']!,
                    style: TextStyle(color: Color(0xff1F2937), fontSize: 22.sp),
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    thickness: 0.2.sp,
                    indent: 40.r,
                    endIndent: 40.r,
                    color: Colors.black,
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    width: 370.w,
                    height: 80.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.r, horizontal: 20.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.black.withOpacity(0.6)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.call,
                          color: Color(0xff4B9CD3),
                          size: 40.sp,
                        ),
                        SizedBox(width: 35.w),
                        Text(
                          userData['phone']!,
                          style: TextStyle(
                              color: Color(0xff424242), fontSize: 23.sp),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    width: 370.w,
                    height: 80.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.r, horizontal: 20.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.black.withOpacity(0.6)),
                    ),
                    child: Row(children: [
                      IconButton(
                        onPressed: _sendEmail,
                        icon: Icon(
                          Icons.email_outlined,
                          color: Color(0xff4B9CD3),
                          size: 40.sp,
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Flexible(
                        child: Text(
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          userData['email']!,
                          style: TextStyle(
                              color: Color(0xff424242), fontSize: 23.sp),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 370.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withOpacity(0.6)),
                    ),
                    child: Row(children: [
                      IconButton(
                        onPressed: () async {
                          final link = userData['link'];
                          if (link == null || link.isEmpty) {
                            print('Link is null or empty');
                            return;
                          }

                          var url = Uri.parse(link);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          } else {
                            print('Could not launch $url');
                          }
                        },
                        icon: Padding(
                          padding: EdgeInsets.only(left: 8.0.r),
                          child: SizedBox(
                            width: 55.w,
                            height: 55.h,
                            child: Image.asset('image/linkedin.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 30.w),
                      Text(
                        'linkedin',
                        style:
                            TextStyle(color: Color(0xff424242), fontSize: 23),
                      ),
                      SizedBox(height: 20.h),
                    ]),
                  ),
                  SizedBox(height: 100.h),
                  SizedBox(
                    height: 100.h,
                    width: 200.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.qr_code_2,
                            size: 45.sp,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QR(),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings_rounded,
                            size: 40.sp,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
