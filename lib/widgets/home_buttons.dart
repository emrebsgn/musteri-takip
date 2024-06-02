import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  late String text;
  late String images;

  HomeButtons({Key? key,
    required this.text,
    required this.images,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(width: 8,),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              //color: AppColors.mainColor.withOpacity(0.3),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(600)
            ),
            child: Image.asset(images,
              //width: 50,
              width: 30,
            ),
          ),
          SizedBox(width: 6,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16)
              ),
              child: Text(text,style: TextStyle(
                  fontSize: 16,
                  fontFamily: "NotoSans"
              ),),
            ),
          ),
          SizedBox(width: 8,),
        ],
      ),
    );
  }
}