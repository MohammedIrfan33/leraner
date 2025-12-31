import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leraner/app/core/constants/app_colors.dart';
import 'package:leraner/app/core/model/home_model.dart';

class CommunityCard extends StatelessWidget {
  final Community community;
  final VoidCallback? onTap;

  const CommunityCard({
    Key? key,
    required this.community,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2.r,
              blurRadius: 8.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.kprimary,
                    child: Icon(Icons.group, color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                    '${community.activeMembers} active members',
                    style: TextStyle(
                      color: Color(0xff6B7280),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                      ],
                    ),
                  ),
                  
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                community.description,
                style: TextStyle(
                  color: Color(0xff4B5563),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xffF0F7FF),
                    foregroundColor: Colors.teal[800],
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Join Discussion',
                    style: TextStyle(
                      color: AppColors.kprimary,
                      fontSize: 14.sp ,fontWeight: FontWeight.w500),
                  ),

                ),
              ),

              SizedBox(height:15.h),


              Row(
                children: [
                  Image(image: AssetImage('assets/posts.png'),width: 43,height: 18,),
                  Text('12 recent posts',style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6B7280),


                  ),),
                  Spacer(),
                  Text('Active Now',style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff10B981),


                  ),),

                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
