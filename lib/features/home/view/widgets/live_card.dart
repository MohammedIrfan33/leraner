import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leraner/app/core/constants/app_colors.dart';

class LiveClassCard extends StatelessWidget {
  final String title;
  final String instructor;
  final String time;
  final bool isLive;
  final VoidCallback onJoin;
  final String action;

  const LiveClassCard({
    super.key,
    required this.title,
    required this.instructor,
    required this.time,
    required this.isLive,
    required this.onJoin, required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFF3CC),
            Color(0xFFFFE6A6),
          ],
        ),
      ),
      child: Row(
        children: [
         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                if (isLive)
                  Container(
                    padding:
                         EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Color(0xff3FC94F),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle,
                            size: 8, color: Colors.white),
                        SizedBox(width: 6),
                        Text(
                          "Live",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 10),

            
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                 SizedBox(height: 2),

           
                Text(
                  instructor,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.ktextBlack,
                    fontWeight: FontWeight.w400
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  time,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black54,

                  ),
                ),
              ],
            ),
          ),

     
          OutlinedButton(
            onPressed: onJoin,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.orange,
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.orange),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            ),
            child:  Text(
              action,
              style: TextStyle(fontWeight: FontWeight.w500 ,fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }
}
