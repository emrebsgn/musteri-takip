import 'dart:async';
import 'package:flutter/material.dart';
import '../utils/color.dart';

class AlertMessage{

  /// Iconlu bilgi alerti
  Future<void> alertInfoIcon(context,{required Color color ,required String infoText,required String alertType}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  child: alertType=="Hata"? Icon(Icons.cancel,size: 60,color: Colors.redAccent):alertType=="Uyarı"?Icon(Icons.warning_amber_outlined,size: 60,color: Colors.orange):Icon(Icons.check_circle_outline,size: 60,color: Colors.green),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,//screenWidth/26,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )
                    ),
                  ),
                ),
                Expanded(child: SizedBox(

                )),
              ],
            ),
          ],
        );
      },
    );
  }


  ///İşlem yaptıran alert
  Future<void> alertOnlyProcess(context,Color color, String infoText,Function f) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  //padding: EdgeInsets.all(screenWidth / 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                    //color: Color(0xFFEEEBB8),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                              ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                              :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: () async {
                          f();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }


  /// Iconlu işlem yaptıran alert
  Future<void> alertOnlyProcessIcon(context,{required Color color, required String infoText,required Function f, required String alertType}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  child: alertType=="Hata"? Icon(Icons.cancel,size: 60,color: Colors.redAccent):alertType=="Uyarı"?Icon(Icons.warning_amber_outlined,size: 60,color: Colors.orange):Icon(Icons.check_circle_outline,size: 60,color: Colors.green),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: () async {
                          f();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Text(
                            "Tamam",style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }


  Future<void> alertProcessIcon(context,{required Color color, required String infoText,required Function f, required String alertType}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        var screenInfos =MediaQuery.of(context); //Burada ekran boyutu alınacak.
        final double screenWidth = screenInfos.size.width;
        final double screenHeight = screenInfos.size.height;
        //Future.delayed(const Duration(),() => SystemChannels.textInput.invokeMethod('TextInput.hide'));
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth/20)
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  child: alertType=="Hata"? Icon(Icons.cancel,size: 60,color: Colors.redAccent):alertType=="Uyarı"?Icon(Icons.warning_amber_outlined,size: 60,color: Colors.orange):Icon(Icons.check_circle_outline,size: 60,color: Colors.green),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenWidth / 100),
                  ),
                  child: Center(
                    child: Text(
                      infoText,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: color
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: AppColors.mainColor)
                                )
                            )
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Text(
                            "Vazgeç",style: TextStyle(
                              color: AppColors.mainColor,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(screenWidth/40),
                                    side: BorderSide(color: Colors.grey)
                                )
                            )
                        ),
                        onPressed: () async {
                          await f();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Text(
                            "Onayla",style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 16: MediaQuery.of(context).size.width<321? 12:16
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?12:16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "PoppinsRegular"
                          ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }




}
