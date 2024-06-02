import 'package:flutter/material.dart';
import 'package:musteri_takip/VeriTabaniYardimcisi.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/dao/veritabanidao.dart';

import '../../utils/color.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MusteriEkle extends StatefulWidget {
  const MusteriEkle({Key? key}) : super(key: key);

  @override
  State<MusteriEkle> createState() => _MusteriEkleState();
}

class _MusteriEkleState extends State<MusteriEkle> {

  var _tfMusteriKod=TextEditingController();
  var _tfMusteriAdUnvan=TextEditingController();
  var _tfUlke=TextEditingController();
  var _tfIl=TextEditingController();
  var _tfIlce=TextEditingController();
  var _tfTel=TextEditingController();
  var _tfMail=TextEditingController();
  var _tfWeb=TextEditingController();
  var _tfNot=TextEditingController();

  late FocusNode focusMusteriAdUnvan;


  var listCinsiyet=<String>["Erkek","Kadın","Şirket"];
  String selectedCinsiyet="Erkek";


  late BannerAd staticAd;
  bool statisAdloaded=false;
  static const AdRequest request=AdRequest();

  void loadStaticBannerAd(){

    staticAd=BannerAd(
        adUnitId: "XXXX",
        size: AdSize.banner,
        request: request,
        listener: BannerAdListener(
            onAdLoaded: (ad){
              setState(() {
                statisAdloaded=true;
              });
            },
            onAdFailedToLoad: (ad,error){
              ad.dispose();
              print("failed ${error.message}");
            }
        )
    );
    staticAd.load();
  }


  @override
  void initState() {
    focusMusteriAdUnvan=FocusNode();
    loadStaticBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    focusMusteriAdUnvan.dispose();


    _tfMusteriKod.dispose();
    _tfMusteriAdUnvan.dispose();
    _tfUlke.dispose();
    _tfIl.dispose();
    _tfIlce.dispose();
    _tfTel.dispose();
    _tfMail.dispose();
    _tfWeb.dispose();
    _tfNot.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Müşteri Ekle"),
      ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Container(
              constraints: BoxConstraints(
                  maxHeight: screenHeight-56-MediaQuery.of(context).padding.bottom-110-30-10
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8,right: 8),
                    child: Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Müşteri Kod
                            Row(
                              children: [
                                Text("Müşteri Kod"),
                                Spacer(),
                                Text("* (Zorunlu)",style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            ///Müşteri Kod Gir
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfMusteriKod,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Müşteri Kod Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),

                            ///Müşteri Ad
                            Row(
                              children: [
                                Text("Müşteri Ad / Unvan"),
                                Spacer(),
                                Text("* (Zorunlu)",style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            ///Müşteri Ad Gir
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfMusteriAdUnvan,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Müşteri Ad / Unvan",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Row(
                              children: [
                                Text("Cinsiyet / Şirket"),
                                Spacer(),
                                Text("* (Zorunlu)",style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 12
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                      decoration: BoxDecoration(
                                          color: selectedCinsiyet=="Erkek"? Colors.orange.withOpacity(0.15):selectedCinsiyet=="Kadın"?Colors.pink.withOpacity(0.08):AppColors.mainColor.withOpacity(0.15),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          borderRadius: BorderRadius.circular(12),
                                          isDense: true,
                                          value: selectedCinsiyet,
                                          items: listCinsiyet.map<DropdownMenuItem<String>>((String value){

                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value,style: TextStyle(
                                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "PoppinsRegular",
                                              ),
                                              ),
                                            );
                                          }).toList(),
                                          icon: Icon(Icons.arrow_drop_down),
                                          onChanged: (String? selectedData) async{
                                            setState(() {
                                              selectedCinsiyet=selectedData!;
                                            });

                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12,),


                            Text("Ülke"),
                            SizedBox(height: 6,),
                            ///Ülke Gir
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfUlke,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Ülke Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Text("İl"),
                            SizedBox(height: 6,),
                            ///İl Gir
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfIl,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "İl Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Text("İlçe"),
                            SizedBox(height: 6,),
                            ///İlçe
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfIlce,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "İlçe Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Text("Tel"),
                            SizedBox(height: 6,),
                            ///Tel Gir
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfTel,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Tel Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Text("Mail"),
                            SizedBox(height: 6,),
                            ///Mail
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfMail,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Mail Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),

                            Text("Web"),
                            SizedBox(height: 6,),
                            ///Web
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfWeb,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Web Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),


                            Text("Not"),
                            SizedBox(height: 6,),
                            ///Not
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: MediaQuery.of(context).orientation ==Orientation.portrait
                                        ?MediaQuery.of(context).size.width<321? 38:42
                                        :MediaQuery.of(context).size.height<321?38:42,
                                    //45,
                                    //padding: EdgeInsets.symmetric(horizontal: 16),
                                    padding: EdgeInsets.only(left:16,top: 2,right: 16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1,color: AppColors.mainColor),
                                        color: Colors.white
                                    ),
                                    child: TextField(
                                      controller: _tfNot,
                                      textAlign: TextAlign.left,
                                      maxLines: 1,
                                      autofocus: false,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                            :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: "Not Gir",
                                        hintStyle: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[400]
                                        ),
                                        enabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                      onSubmitted: (onSubmitValue){
                                        setState(() {
                                          //focusTaksitSayisi.requestFocus();
                                        });

                                      },
                                      onChanged: (value){

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),

            ),


            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 6,right: 6),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:6,right: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    padding: EdgeInsets.zero,

                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      //_tfToplamBorc.clear();
                                      //_tfTaksitSayisi.clear();
                                    });

                                    var a=await VeritabaniDao().musteriListesi();
                                    for(var i in a){
                                      print(i.musteriKod);
                                      print(i.musteriAd);
                                    }

                                  }, child: Text("Temizle", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width>1200?24:MediaQuery.of(context).size.height>1200?24: MediaQuery.of(context).orientation ==Orientation.portrait
                                      ?MediaQuery.of(context).size.height>821? 20: MediaQuery.of(context).size.width<321? 14:16
                                      :MediaQuery.of(context).size.height>551? 20:MediaQuery.of(context).size.height<321?14:16
                              ),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:6,right: 6),
                      //color: Colors.grey[500],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 35,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: EdgeInsets.zero,

                                  ),
                                  onPressed: () async {



                                    var alert=AlertMessage();
                                    if(_tfMusteriKod.text.isEmpty){
                                      alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Lütfen Müşteri Kod Giriniz", alertType: "Hata");
                                    }else if(_tfMusteriKod.text.length<4){
                                      alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Müşteri Kod 4 Karakterden Az Olamaz", alertType: "Hata");
                                    }else if(_tfMusteriAdUnvan.text.isEmpty){
                                      alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Lütfen Müşteri Ad Giriniz", alertType: "Hata");
                                    }else if(_tfMusteriAdUnvan.text.length<4){
                                      alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Müşteri Ad/Unvan 4  Karakterden Az Olamaz", alertType: "Hata");
                                    }else{

                                      int musteriCount=0;
                                      if(_tfMusteriKod.text.isNotEmpty){
                                        musteriCount=await VeritabaniDao().lineCount(tableName: 'musteriler', columnName: 'musteri_kod', columnValue: '${_tfMusteriKod.text}');

                                        if(musteriCount==0){
                                          try{
                                            await VeritabaniDao().musteriEkle(
                                                context: context,
                                                musteriKod: _tfMusteriKod.text,
                                                musteriAd: _tfMusteriAdUnvan.text,
                                                cinsiyet: selectedCinsiyet,
                                                ulke: _tfUlke.text,
                                                il: _tfIl.text,
                                                ilce: _tfIlce.text,
                                                tel: _tfTel.text,
                                                mail: _tfMail.text,
                                                web: _tfWeb.text,
                                                not: _tfNot.text);
                                            print("Eklendi");
                                          }catch(e){
                                            alert.alertInfoIcon(context, color: Colors.redAccent, infoText: e.toString(), alertType: "Hata");
                                          }
                                        }else{
                                          alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Bu Müşteri Kod'u Zaten Bulunmaktadır.", alertType: "Hata");
                                        }

                                      }

                                    }



                                  }, child: Text("Ekle", style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width>1200?24:MediaQuery.of(context).size.height>1200?24: MediaQuery.of(context).orientation ==Orientation.portrait
                                      ?MediaQuery.of(context).size.height>821? 20: MediaQuery.of(context).size.width<321? 14:16
                                      :MediaQuery.of(context).size.height>551? 20:MediaQuery.of(context).size.height<321?14:16
                              ),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            ///Reklam
            Container(
              //color: Colors.teal,
              //color: Colors.grey[350],
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Center(child: AdWidget(ad: staticAd)),
            ),
          ],
        ),
      ),
    );
  }
}
