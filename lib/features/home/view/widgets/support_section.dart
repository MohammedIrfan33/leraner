import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leraner/app/core/model/home_model.dart';


class SupportSection extends StatelessWidget {
  final Support support;
  final VoidCallback? onChatTap;
  final VoidCallback? onCallTap;

  const SupportSection({
    super.key,
    required this.support,
    this.onChatTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
       
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Left Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        support.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        support.description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '“${support.exampleQuestion}”',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w300
                        ),
                      ),
                      SizedBox(height: 16.h),
            
              
                     
                    ],
                  ),
                ),
            
                /// Right Illustration
                SizedBox(width: 12.w),
                CircleAvatar(
                  radius: 42.r,
                  backgroundColor: const Color(0xffF5E6E8),
                  backgroundImage: const AssetImage(
                    'assets/support.png', // your image
                  ),
                ),
              ],
            ),
             Row(
                    children: [
                      Expanded(
                        child: _SupportButton(
                          icon: Icons.chat_bubble_outline,
                          label: 'Chat with us',
                          onTap: onChatTap,
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: _SupportButton(
                          icon: Icons.call_outlined,
                          label: 'Call us',
                          onTap: onCallTap,
                        ),
                      ),
                    ],
                  ),
                
          ],
        ),
      ),
    );
  }
}

class _SupportButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _SupportButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

