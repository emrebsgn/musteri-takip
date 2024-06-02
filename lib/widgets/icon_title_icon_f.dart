import 'package:flutter/material.dart';

import '../utils/color.dart';

class IconTitleIconF extends StatelessWidget {
  late String title;
  late Function f;
  late IconData icon;

  IconTitleIconF({Key? key,
    required this.title,
    this.f=Navigator.pop,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //Dikey ise verilecek size.
      padding: EdgeInsets.only(left:MediaQuery.of(context).padding.left,right: MediaQuery.of(context).padding.right),
      height:MediaQuery.of(context).orientation ==Orientation.portrait
          ?MediaQuery.of(context).size.width<321? 40:48
          :MediaQuery.of(context).size.height<321?40:48,
      width: double.maxFinite,
      color: AppColors.mainColor,//Colors.blue,//AppColors.colorPageTitle,//AppColors.mainColor,
      child: Row(
        children: [
          //Geri Iconu
          Expanded(
            flex: 2,
            child: GestureDetector(
                onTap: (){
                  //print("Tıklandı");
                  f();
                },
                child: Container(
                  padding: EdgeInsets.only(top:6,bottom: 6),
                  child: Icon(
                    Icons.arrow_back,
                    size:MediaQuery.of(context).size.width>321?30:24 ,
                    color: Colors.white,),
                )),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Text(title,style: TextStyle(
                  color: Colors.white,
                  //fontSize: screenWidth/16,
                  fontSize: MediaQuery.of(context).size.width>321?20:16,//title=="Depolar Arası Sevk"?MediaQuery.of(context).size.width>321?18:16:MediaQuery.of(context).size.width>321?22:18,
                  fontWeight: FontWeight.w500,
                  fontFamily: "NotoSans"
              ),),
            ),
          ),
          Expanded(
              flex: 2,
              child:Center(
                  child: Container(
                    padding: EdgeInsets.only(top:6,bottom: 6),
                    child: Icon(
                      icon,
                      size:icon==Icons.create? MediaQuery.of(context).size.width>321?26:20:MediaQuery.of(context).size.width>321?28:22 ,
                      color: Colors.white,),)
              )
          ),
        ],
      ),
    );
  }
}
