import 'package:flutter/material.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/pages/modul_musteri_kartlari/musteri_kartlari.dart';
import 'package:musteri_takip/pages/modul_taksitli_borc_ekle/taksitli_borc_ekle.dart';
import 'package:musteri_takip/pages/modul_taksitli_borc_liste/taksitli_borc_liste.dart';
import 'package:musteri_takip/pages/odeme_aldim.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/color.dart';
import '../widgets/home_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Future<bool> notRedirect()async{

    return false;
  }

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
    //loadStaticBannerAd();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(Icons.home),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.power_settings_new),
          ),
          SizedBox(width: 8),
        ],
        backgroundColor: AppColors.mainColor,
        title: Center(child: Text("Anasayfa")),
      ),

        backgroundColor: Colors.grey[100],
        body:WillPopScope(
          onWillPop: ()=>notRedirect(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Content içerisinde yer alan row'ların içeriği
                Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height-56
                  ),
                  child: Column(
                    children: [
                      ///Ödeme Ekle
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OdemeAldim()));
                            //var alert=AlertMessage();
                            //alert.alertInfoIcon(context, color: Colors.red, infoText: "Yakında Kullanıma Açılacak", alertType: "Hata");
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //color: Color(0xFFBEDEA4),
                            //color:Colors.green.withOpacity(0.2),
                            color: AppColors.mainColor.withOpacity(0.2),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/odeme_ekle.png",width: 60,),
                                  SizedBox(height: 4,),
                                  Text("Ödeme Ekle",style: TextStyle(
                                      fontSize: 16,
                                  ),),
                                  SizedBox(height: 4,),
                                  Text("(Müşteriden alınan ödeme)",style: TextStyle( //(Müşteriden alınan ödemeyi eklemek için kullanılır)
                                      fontSize: 12,
                                      fontFamily: "NotoSans"
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///Borç Ekle
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaksitliBorcEkle()));

                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.grey[400],
                            //color:Color(0xFFDDDEA4),
                            //color:Colors.orange.withOpacity(0.3),
                            color: AppColors.mainColor.withOpacity(0.3),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/borc_ekle.png",width: 60,),
                                  SizedBox(height: 4,),
                                  Text("Borç Ekle",style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoSans"
                                  ),),
                                  SizedBox(height: 4,),
                                  Text("(Yeni Borç Ekle/Yeni Sabit Ödeme Ekle)",style: TextStyle( //(Müşteriden alınan ödemeyi eklemek için kullanılır)
                                      fontSize: 12,
                                      fontFamily: "NotoSans"
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///Borç Liste
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaksitliBorcListe()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            //color: Colors.grey[600],
                            //color:Color(0xFFDEC5A4),
                            //color:Colors.yellow.withOpacity(0.2),
                            color: AppColors.mainColor.withOpacity(0.2),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/borc_liste.png",width: 60,),
                                  SizedBox(height: 4,),
                                  Text("Borç Liste",style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoSans"
                                  ),),
                                  SizedBox(height: 4,),
                                  Text("(Taksitli Borç Listesi)",style: TextStyle( //(Müşteriden alınan ödemeyi eklemek için kullanılır)
                                      fontSize: 12,
                                      fontFamily: "NotoSans"
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///Sabit Ödeme Liste
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            var alert=AlertMessage();
                            alert.alertInfoIcon(context, color: Colors.red, infoText: "Yakında Kullanıma Açılacak", alertType: "Hata");
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.mainColor.withOpacity(0.3),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset("images/sabit_odeme.png",width: 60,),
                                  SizedBox(height: 4,),
                                  Text("Sabit Ödeme Liste",style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoSans"
                                  ),),
                                  SizedBox(height: 4,),
                                  Text("(Aylık Alınan Sabit Ödeme)",style: TextStyle( //(Müşteriden alınan ödemeyi eklemek için kullanılır)
                                      fontSize: 12,
                                      fontFamily: "NotoSans"
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ///Müşteri Kartları
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MusteriKartlari()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: AppColors.mainColor.withOpacity(0.2),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("images/man.png",width: 60,),
                                      Image.asset("images/businesswoman.png",width: 60,),
                                    ],
                                  ),
                                  SizedBox(height: 4,),
                                  Text("Müşteri Kartları",style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "NotoSans"
                                  ),),
                                  SizedBox(height: 4,),
                                  Text("(Müşteri Ekle/Müşteri Bilgileri)",style: TextStyle( //(Müşteriden alınan ödemeyi eklemek için kullanılır)
                                      fontSize: 12,
                                      fontFamily: "NotoSans"
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),


                      /*
                      SizedBox(height: 10,),

                      ///Ödeme Aldım
                      GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OdemeAldim()));
                          },
                          child:HomeButtons(text: "Ödeme Aldım", images: "images/wallet.png")
                      ),
                      SizedBox(height: 12,),

                      ///Ödeme Listesi
                      GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaksitliBorcListe()));
                          },
                          child: HomeButtons(text: "Taksitli Borç Liste", images: "images/wallet.png")
                        //HomeButtonsIcon(text: "Cari Oluştur", icon: Icons.person_add),//
                      ),
                      SizedBox(height: 12,),


                      ///Taksitli Borç Ekle
                      GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>TaksitliBorcEkle()));
                          },
                          child:HomeButtons(text: "Taksitli Borç Ekle", images: "images/wallet.png")),
                      SizedBox(height: 12,),


                      ///Müşteri Kartları
                      GestureDetector(
                          onTap: ()async{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MusteriKartlari()));
                          },
                          child:HomeButtons(text: "Müşteri Kartları", images: "images/wallet.png")),
                      SizedBox(height: 12,),

                      SizedBox(height: 50,),
                      */
                    ],
                  ),
                ),

                /*
                SizedBox(
                  height: MediaQuery.of(context).orientation ==Orientation.portrait
                      ?MediaQuery.of(context).size.height>821? 66: MediaQuery.of(context).size.width<321? 40:48
                      :MediaQuery.of(context).size.height>551? 66:MediaQuery.of(context).size.height<321?40:48,
                  //height: MediaQuery.of(context).size.height>810? 70:MediaQuery.of(context).size.width<321?40:56,//(MediaQuery.of(context).size.height>810?70:56),
                  width: double.maxFinite,
                  child: Container(
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.power_settings_new,color: Colors.redAccent,)),
                  ),
                ),
                */
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.mainColor.withOpacity(0.3),
                  child: Column(
                    children: [
                      SizedBox(height: 4,),
                      Text("V.1.4",style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                      SizedBox(height: 2,),
                      Text("BSGNSOFT",style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                      SizedBox(height: 2,),
                      Text("Tüm Hakları Saklıdır ©",style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.normal)),
                      SizedBox(height: 6,),
                    ],
                  ),
                ),

                ///Reklam
                /*
                Container(
                  //color: Colors.teal,
                  //color: Colors.grey[350],
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: AdWidget(ad: staticAd)),
                ),
                */
                /*
                //Çıkış
                SizedBox(
                  height: MediaQuery.of(context).orientation ==Orientation.portrait
                      ?MediaQuery.of(context).size.height>821? 66: MediaQuery.of(context).size.width<321? 40:48
                      :MediaQuery.of(context).size.height>551? 66:MediaQuery.of(context).size.height<321?40:48,
                  //height: MediaQuery.of(context).size.height>810? 70:MediaQuery.of(context).size.width<321?40:56,//(MediaQuery.of(context).size.height>810?70:56),
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                            (Set<MaterialState> states) {
                          return EdgeInsets.zero;
                        },
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor), //Color(0xFFF5F5F5)
                      elevation: MaterialStateProperty.all(2),

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          side: BorderSide(width: 0.2,color: AppColors.mainColor),

                        ),
                      ),

                    ),
                    onPressed: () async {

                    },
                    child: Container(
                      //Dikey ise verilecek size.
                      height: MediaQuery.of(context).orientation ==Orientation.portrait
                          ?MediaQuery.of(context).size.height>821? 70: MediaQuery.of(context).size.width<321? 40:48
                          :MediaQuery.of(context).size.height>551? 70:MediaQuery.of(context).size.height<321?40:48,
                      //height:MediaQuery.of(context).size.height>810? 70:MediaQuery.of(context).size.width<321?40:56,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        //border: Border.all(width: 0.2,color: Colors.black),
                        color:AppColors.mainColor,// Color(0xFF0078AA).withOpacity(0.55),//background,//AppColors.mainColor,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10,),
                          //Kapı Iconu
                          Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: (){
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: "")));
                                Navigator.pushNamed(context, "/main");
                              },
                              child: Icon(Icons.door_back_door_outlined,size: MediaQuery.of(context).size.width>321?26:23,),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: Text("Çıkış",style: TextStyle(
                                  color: Colors.white,
                                  //fontSize: screenWidth/16,
                                  fontSize: MediaQuery.of(context).size.width>321?19:16,//MediaQuery.of(context).size.width>1200?24:MediaQuery.of(context).size.height>1200?24: 22,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "NotoSans"
                              ),),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              padding: EdgeInsets.only(right: 8),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Center()
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                */
              ],
            ),
          ),
        )
    );
  }
}
