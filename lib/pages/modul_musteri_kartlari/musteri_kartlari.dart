import 'package:flutter/material.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/dao/veritabanidao.dart';
import 'package:musteri_takip/model/model_musteriler.dart';
import 'package:musteri_takip/pages/home_screen.dart';
import 'package:musteri_takip/pages/modul_musteri_kartlari/musteri_ekle.dart';
import 'package:musteri_takip/widgets/icon_title_icon_f.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../utils/color.dart';

class MusteriKartlari extends StatefulWidget {
  const MusteriKartlari({Key? key}) : super(key: key);

  @override
  State<MusteriKartlari> createState() => _MusteriKartlariState();
}

class _MusteriKartlariState extends State<MusteriKartlari> {


  Future<bool>redirectPage()async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    return true;
  }

  var listMusteriler=<ModelMusteriler>[];

  String durum="Yükleniyor...!";

  Future<void>getLocal()async{
    listMusteriler=await VeritabaniDao().musteriListesi();

    if(listMusteriler.isEmpty){
      setState(() {
        durum="Müşteri Listesi Boş";
      });
    }else{
      setState(() {
        durum="";
      });
    }

    setState(() {
      listMusteriler;
    });
  }

  Color renkverTek(){
    return AppColors.mainColor.withOpacity(0.2);
  }

  Color renkverCift(){
    return Colors.grey.withOpacity(0.2);
  }

  Future<void>cariDetay({required int index})async{
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///Mğşteri Kod
                Card(
                  child: Container(
                    color: renkverTek(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Müşteri Kod"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].musteriKod),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Müşteri Ad
                Card(
                  child: Container(
                    color: renkverCift(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Müşteri Ad"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].musteriAd),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Cinsiyet
                Card(
                  child: Container(
                    color: renkverTek(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Cinsiyet/Şti"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].cinsiyet),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Ülke
                Card(
                  child: Container(
                    color: renkverCift(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Ülke"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].ulke),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///İl
                Card(
                  child: Container(
                    color: renkverTek(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("İl"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].il),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///İlçe
                Card(
                  child: Container(
                    color: renkverCift(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("İlçe"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].ilce),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Tel
                Card(
                  child: Container(
                    color: renkverTek(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Tel"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].tel),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Mail
                Card(
                  child: Container(
                    color: renkverCift(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Mail"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].mail),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Web
                Card(
                  child: Container(
                    color: renkverTek(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Mail"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].web),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),
                ///Not
                Card(
                  child: Container(
                    color: renkverCift(),
                    padding: EdgeInsets.only(left: 4,top:8,bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Text("Not"),
                                Spacer(),
                                Text(":"),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            child: Text(listMusteriler[index].not),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4,),


              ],
            ),
          );
        });
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


  Future<void>musteriSilPage({required int lineIndex})async{
    await VeritabaniDao().musteriSil(musteri_kod: listMusteriler[lineIndex].musteriKod);

    try{
      await VeritabaniDao().borcSil(musteri_kod: listMusteriler[lineIndex].musteriKod);
    }catch(e){
      print("Borç konusu: ${e}");
    }
    listMusteriler.remove(listMusteriler[lineIndex]);


    if(listMusteriler.isEmpty){
      setState(() {
        durum="Müşteri Listesi Boş";
      });
    }
    setState(() {
      listMusteriler;
    });
  }

  @override
  void initState() {
    loadStaticBannerAd();
    super.initState();
    getLocal();
  }


  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Müşteri Kartları"),
      ),
      backgroundColor: Colors.grey[300],
      body: WillPopScope(
        onWillPop: ()=>redirectPage(),
        child: Column(
          children: [
            /*
            Container(
                width: screenWidth,
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  //color: Colors.grey[100],
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:Colors.deepOrange.withOpacity(0.5),
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Stack(
                  children: [

                    Row(

                      children: [
                        //Bilgiler
                        Container(
                          width: MediaQuery.of(context).size.width-40,
                          height: MediaQuery.of(context).orientation ==Orientation.portrait
                              ?MediaQuery.of(context).size.width<321? 34:40
                              :MediaQuery.of(context).size.height<321? 34:40,

                          color: Colors.grey[300],
                          child: Center(
                              child: TextField(
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width>321?16:14,
                                ),
                                onChanged: (searchResult)async{

                                },
                                decoration: InputDecoration(
                                    contentPadding:MediaQuery.of(context).size.width>321? EdgeInsets.only(left:8,bottom: 6):EdgeInsets.only(left:8,bottom: 10),
                                    hintText: "Müşteri Ara",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize:MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?13:14
                                            :MediaQuery.of(context).size.height>551? 14:MediaQuery.of(context).size.height<321?13:14
                                    ),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none

                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        top: 0,
                        right: 20,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: (){
                          },
                          child: Container(
                            //Dikey mi?
                            height: MediaQuery.of(context).orientation ==Orientation.portrait
                                ?MediaQuery.of(context).size.width<321? 34:40
                                :MediaQuery.of(context).size.height<321? 34:40,
                            child: ElevatedButton(
                                style: ButtonStyle(

                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:BorderRadius.all(Radius.circular(16))
                                        /*
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16)
                                        )*/
                                      ),
                                    )
                                ),
                                onPressed: (){

                                }, child: Icon(Icons.search,color: Colors.white,size: MediaQuery.of(context).size.width>321?24:18)),
                          ),
                        )),





                    /*
                    //Arama Kutusu
                    Container(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.width<321? 34:40
                                  :MediaQuery.of(context).size.height<321? 34:40,
                              /*
                                height:
                                    MediaQuery.of(context).orientation ==Orientation.portrait
                                    ?MediaQuery.of(context).size.height>821? 60: MediaQuery.of(context).size.width<321? 30:46
                                    :MediaQuery.of(context).size.height>551? 60:MediaQuery.of(context).size.height<321?30:30,

                                */
                              color: Color(0xFFFCF79C),
                              child: Center(
                                  child: TextField(
                                    textCapitalization: TextCapitalization.words,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width>321?16:14,
                                      /*
                                        fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.height>821? 17: MediaQuery.of(context).size.width<321? 10:17
                                            :MediaQuery.of(context).size.height>551? 17:MediaQuery.of(context).size.height<321?10:17,
                                      */
                                    ),
                                    onChanged: (searchResult)async{
                                      var sp=await SharedPreferences.getInstance(); //Buurada ser.con'a veri göndereceğiz.
                                      sp.setString("DepoStokAd", searchResult);
                                      if(searchResult==""){
                                        setState(() {
                                          sp.remove("SiparisStokAra");
                                          txtSearching=false;
                                        });
                                        print("if");
                                        print(txtSearching);
                                      }else{
                                        setState(() {
                                          sp.setString("SiparisStokAra", searchResult);
                                          searchedWord=searchResult;
                                          txtSearching=true;
                                        });
                                        print("else");
                                        print(txtSearching);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      ///en son
                                      //contentPadding: EdgeInsets.only(left:8,bottom: 16),
                                        contentPadding:MediaQuery.of(context).size.width>321? EdgeInsets.only(left:8,bottom: 6):EdgeInsets.only(left:8,bottom: 10),
                                        hintText: "Stok Ara",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                            fontSize:MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?13:14
                                                :MediaQuery.of(context).size.height>551? 14:MediaQuery.of(context).size.height<321?13:14
                                        ),
                                        //fillColor: Color(0xFFFCF79C),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        //disabledBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none

                                    ),
                                  )
                              ),
                            ),
                          ),

                          Expanded(
                            flex:2,
                            child: Container(
                              //Dikey mi?
                              height: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.width<321? 34:40
                                  :MediaQuery.of(context).size.height<321? 34:40,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      )
                                  ),
                                  onPressed: (){

                                  }, child: Icon(Icons.search,color: Colors.white,size: MediaQuery.of(context).size.width>321?24:18)),
                            ),
                          )
                        ],
                      ),
                    ),




                    */
                  ],
                )
            ),
            */
            //Bilgiler
            listMusteriler.isEmpty? Padding(
              padding: EdgeInsets.only(left:5,top: 5,right: 5),
              child: Card(
                child: Container(
                  child: Column(
                    children: [
                      //durum=="Müşteri Listesi Boş"?Center():CircularProgressIndicator(),
                      durum=="Müşteri Listesi Boş"?Center():SizedBox(height: 16,),
                      durum=="Müşteri Listesi Boş"?Center():Center(child: CircularProgressIndicator()),
                      SizedBox(height: 16,),
                      Text(durum),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
              ),
            ):Expanded(
              child: Padding(
                padding: EdgeInsets.only(top:2),
                child: Container(
                  //color: AppColors.mainColor.withOpacity(0.8),
                  color: Colors.grey[200],
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: listMusteriler.length,
                    itemBuilder: (context,index){
                      return InkWell(
                        onLongPress: ()async{
                          var alert=AlertMessage();
                          alert.alertProcessIcon(context, color: Colors.redAccent, infoText: "Müşteri ve Tüm Borçları Silinecek ?", f: ()=>musteriSilPage(lineIndex: index), alertType: "Uyarı");
                        },
                        child: Container(
                            width: screenWidth,
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 0.8,
                                    )
                                )
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    //Icon
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?screenHeight>821? 70: screenWidth<321?40:76
                                            :screenHeight>551? 70:screenHeight<321?36:76,
                                        child: listMusteriler[index].cinsiyet=="Erkek"?Image.asset("images/man.png"):listMusteriler[index].cinsiyet=="Kadın"?Image.asset("images/businesswoman.png"):Image.asset("images/company.png"),
                                      ),
                                    ),
                                    //Bilgiler
                                    Expanded(
                                      flex: 3,
                                      child: GestureDetector(
                                        onTap: (){
                                          cariDetay(index: index);
                                        },
                                        child: Container(
                                          //color: Colors.teal,
                                          child: Column(
                                            children: [
                                              //Ad soyad
                                              Padding(
                                                padding: EdgeInsets.only(left:3,right: 3),
                                                child: Row(
                                                  children: [
                                                    //Ad Soyad Title
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text("Müşteri Ad ",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 11,//screenWidth/32,
                                                            fontFamily: "PoppinsRegular"
                                                        ),),
                                                      ),
                                                    ),
                                                    //Ad soyad value
                                                    Expanded(
                                                      flex: MediaQuery.of(context).orientation ==Orientation.portrait
                                                          ?screenHeight>821? 3: screenWidth<321?40:2
                                                          :screenHeight>551? 4:screenHeight<321?36:4,
                                                      child: Container(
                                                        child: Text(": ${listMusteriler[index].musteriAd}",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 13,//screenWidth/28,
                                                            fontFamily: "PoppinsRegular",
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: screenWidth/150,),
                                              //Tel
                                              Padding(
                                                padding: EdgeInsets.only(left:3,right: 3),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text("Tel ",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 11,//screenWidth/32,
                                                            fontFamily: "PoppinsRegular"
                                                        ),),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: MediaQuery.of(context).orientation ==Orientation.portrait
                                                          ?screenHeight>821? 3: screenWidth<321?40:2
                                                          :screenHeight>551? 4:screenHeight<321?36:4,
                                                      child: Container(
                                                        child: Text(": ${listMusteriler[index].tel}",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 13,//screenWidth/28,
                                                            fontFamily: "PoppinsRegular",
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: screenWidth/150,),
                                              //İlçe
                                              Padding(
                                                padding: EdgeInsets.only(left:3,right: 3),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text("İl ",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 11,//screenWidth/32,
                                                            fontFamily: "PoppinsRegular"
                                                        ),),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: MediaQuery.of(context).orientation ==Orientation.portrait
                                                          ?screenHeight>821? 3: screenWidth<321?40:2
                                                          :screenHeight>551? 4:screenHeight<321?36:4,
                                                      child: Container(
                                                        child: Text(": ${listMusteriler[index].il}",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 13,//screenWidth/28,
                                                            fontFamily: "PoppinsRegular",
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: screenWidth/150,),
                                              //Mail
                                              Padding(
                                                padding: EdgeInsets.only(left:3,right: 3),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text("Mail",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 11,//screenWidth/32,
                                                            fontFamily: "PoppinsRegular"
                                                        ),),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: MediaQuery.of(context).orientation ==Orientation.portrait
                                                          ?screenHeight>821? 3: screenWidth<321?40:2
                                                          :screenHeight>551? 4:screenHeight<321?36:4,
                                                      child: Container(
                                                        child: Text(": ${listMusteriler[index].mail}",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 13,//screenWidth/28,
                                                            fontFamily: "PoppinsRegular",
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: screenWidth/150,),
                                              //Web
                                              Padding(
                                                padding: EdgeInsets.only(left:3,right: 3),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        child: Text("Web",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 11,//screenWidth/32,
                                                            fontFamily: "PoppinsRegular"
                                                        ),),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: MediaQuery.of(context).orientation ==Orientation.portrait
                                                          ?screenHeight>821? 3: screenWidth<321?40:2
                                                          :screenHeight>551? 4:screenHeight<321?36:4,
                                                      child: Container(
                                                        child: Text(": ${listMusteriler[index].web}",style: TextStyle(
                                                          //color: AppColors.mainColor,
                                                            fontSize: 13,//screenWidth/28,
                                                            fontFamily: "PoppinsRegular",
                                                            fontWeight: FontWeight.bold
                                                        ),),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                        ),
                      );
                    },
                  )
                ),
              ),
            ),
            durum=="Müşteri Listesi Boş"?Center():
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        tooltip: "Müşteri Ekle",
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MusteriEkle()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
