import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/pages/info_odeme_aldim.dart';

import '../dao/veritabanidao.dart';
import '../model/model_borclar.dart';
import '../model/model_musteriler.dart';
import '../utils/color.dart';

class OdemeAldim extends StatefulWidget {
  const OdemeAldim({Key? key}) : super(key: key);

  @override
  State<OdemeAldim> createState() => _OdemeAldimState();
}

class _OdemeAldimState extends State<OdemeAldim> {

  //var listMusteriler=<String>["A firması","B firması","C firması"];
  //String selectedMusteri="A firması";


  late ModelMusteriler selectedMusteri;
  var listMusteriler=<ModelMusteriler>[];

  var listAylar=["","Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık"];


  var listBorclar=<ModelBorclar>[];

  int selectedIndex=-99;

  Future<void>getLocal()async{
    await getCustomer(); //Müşterileri DB den çek.
    //var listBorclar=<ModelBorclar>[];
    await getBorclar(); ///Borçları listele
  }

  Future<void>getBorclar()async{
    listBorclar=await VeritabaniDao().borcListesiOdemeAldim(musteriKod: selectedMusteri.musteriKod,musteriAd: selectedMusteri.musteriAd);
    print("Borçlu Cari: ${selectedMusteri.musteriAd}");
    print("Borç Sayısı: ${listBorclar.length}");

    for(var i in listBorclar){
      print(i.borcTutar);
      print(i.paraBirimi);
    }
    setState(() {
      listBorclar;
    });
  }

  Future<void>getCustomer()async{
    var a=ModelMusteriler(musteriKod: "", musteriAd: "Seç", cinsiyet: "ERKEK", ulke: "", il: "", ilce: "", tel: "", mail: "", web: "", not: "");
    listMusteriler.add(a);
    selectedMusteri=listMusteriler[0];
    var listDaoMusteriler=await VeritabaniDao().musteriListesi();
    if(listDaoMusteriler.isNotEmpty){
      for(var i in listDaoMusteriler){
        listMusteriler.add(i);
      }
    }

    if(listMusteriler.isNotEmpty){
      selectedMusteri=listMusteriler[0];
    }

    setState(() {
      listMusteriler;
    });
  }

  String ayBilgisiAl({required int intAy}){
    ///strBaslangicTarih.substring(8,10)+"-"+strBaslangicTarih.substring(5,7)+"-"+strBaslangicTarih.substring(0,4)
    String strTarih=listBorclar[selectedIndex].baslangicTarih;
    DateTime anlikTarih=DateTime(int.parse(strTarih.substring(0,4)),int.parse(strTarih.substring(5,7)),int.parse(strTarih.substring(8,10)));
    DateTime anlikTariheEklendi=DateTime(anlikTarih.year,anlikTarih.month+intAy,anlikTarih.day);



    return listAylar[anlikTariheEklendi.month];
  }

  String yilBilgisiAl({required int intAy}){
    ///strBaslangicTarih.substring(8,10)+"-"+strBaslangicTarih.substring(5,7)+"-"+strBaslangicTarih.substring(0,4)
    String strTarih=listBorclar[selectedIndex].baslangicTarih;
    DateTime anlikTarih=DateTime(int.parse(strTarih.substring(0,4)),int.parse(strTarih.substring(5,7)),int.parse(strTarih.substring(8,10)));
    DateTime anlikTariheEklendi=DateTime(anlikTarih.year,anlikTarih.month+intAy,anlikTarih.day);



    return anlikTariheEklendi.year.toString();
  }


  Future<void>taksitUpdate({required String musteriKod,required int yeniOdenenTaksitSayisi})async{
    //listBorclar=await VeritabaniDao().borcListesiOdemeAldim(musteriKod: selectedMusteri.musteriKod,musteriAd: selectedMusteri.musteriAd);
    VeritabaniDao().taksitGuncelle(musteri_kod: musteriKod, yeniOdenenTaksitSayisi: yeniOdenenTaksitSayisi);

    getBorclar();
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
        actions: [
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoOdemeAldim()));
              },
              child: Icon(Icons.info_outline)),
          SizedBox(width: 10,)
        ],
        title: Text("Ödeme Ekle"),
      ),
      backgroundColor: Colors.grey[300],
      body: Container(
        //color: Colors.teal,
        constraints: BoxConstraints(
            maxHeight: screenHeight-56-MediaQuery.of(context).padding.bottom-30,
        ),
        child: Column(
          children: [
            SizedBox(height: 8,),
            ///Müşteri Seç Card
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Container(
                width: screenWidth,
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
                        Text("Müşteri Seç"),
                        SizedBox(height: 6,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<ModelMusteriler>(
                                      borderRadius: BorderRadius.circular(12),
                                      isDense: true,
                                      value: selectedMusteri,
                                      items: listMusteriler.map<DropdownMenuItem<ModelMusteriler>>((ModelMusteriler value){

                                        return DropdownMenuItem<ModelMusteriler>(
                                          value: value,
                                          child: Text(value.musteriAd,style: TextStyle(
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
                                      onChanged: (ModelMusteriler? selectedData) async{
                                        setState(() {
                                          selectedMusteri=selectedData!;
                                        });
                                        getBorclar();

                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),



            ///Müşteri Seç Card
            /*
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Container(
                width: screenWidth,
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
                        Text("Müşteri Seç"),
                        SizedBox(height: 6,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(6)
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      borderRadius: BorderRadius.circular(12),
                                      isDense: true,
                                      value: selectedMusteri,
                                      items: listMusteriler.map<DropdownMenuItem<String>>((String value){

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
                                          selectedMusteri=selectedData!;
                                        });

                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            */


            Flexible(
              child: ListView.builder(
                itemCount: listBorclar.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      if(selectedIndex==-99){
                        setState(() {
                          selectedIndex=index;
                        });
                      }else if(selectedIndex==index){
                        setState(() {
                          selectedIndex=-99;
                        });
                      }else{
                        setState(() {
                          selectedIndex=index;
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 12,right: 12),
                      child: Container(
                        width: screenWidth,
                        child: Column(
                          children: [
                            Card(
                              color: Colors.grey[100],
                              elevation: 2,
                              shadowColor: Colors.grey,
                              child: Container(
                                padding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
                                width: screenWidth,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Toplam Borç:",style: TextStyle(
                                            fontSize: 16
                                        ),),
                                        Text(listBorclar.isNotEmpty? money_formatter(listBorclar[index].borcTutar) +" "+ listBorclar[index].paraBirimi:" - ",style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Taksit Sayısı:",style: TextStyle(
                                            fontSize: 13
                                        ),),
                                        Text(listBorclar.isNotEmpty?listBorclar[index].odenenTaksitSayisi.toString()+"/"+listBorclar[index].toplamTaksitSayisi.toString():" -/- ",style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      ],
                                    ),
                                    SizedBox(height: 6,),
                                    Icon(Icons.arrow_drop_down_outlined)

                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 6,),

                            selectedIndex==index?
                            Container(
                              height: screenHeight/2,
                              child: ListView.builder(
                                itemCount: listBorclar[selectedIndex].toplamTaksitSayisi,
                                itemBuilder: (context,indexBorc){
                                  return InkWell(
                                    onTap: (){
                                      ///Taksit Ödenmemiş İşe Yapılacak İşlemler
                                      if(listBorclar[selectedIndex].odenenTaksitSayisi<=indexBorc){
                                        var alert=AlertMessage();
                                        alert.alertProcessIcon(context, color: Colors.redAccent, infoText: "Taksit Ödemesi Alındı Mı ?", f: ()=>taksitUpdate(musteriKod: selectedMusteri.musteriKod, yeniOdenenTaksitSayisi: listBorclar[selectedIndex].odenenTaksitSayisi+1), alertType: "Uyarı");
                                      }else{
                                        var alert=AlertMessage();
                                        alert.alertProcessIcon(context, color: Colors.redAccent, infoText: "Son Alınan Taksit Silinecek ?", f: ()=>taksitUpdate(musteriKod: selectedMusteri.musteriKod, yeniOdenenTaksitSayisi: listBorclar[selectedIndex].odenenTaksitSayisi-1), alertType: "Uyarı");
                                      }

                                    },
                                    child: Card(
                                      color: Colors.grey[100],
                                      elevation: 2,
                                      shadowColor: Colors.grey,
                                      child: Column(
                                        children: [
                                          Container(
                                            //color: Colors.teal,
                                            child: Column(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                                    width: MediaQuery.of(context).size.width,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.all(8),
                                                                      decoration: BoxDecoration(
                                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                                      ),
                                                                      child: Text(listBorclar[selectedIndex].baslangicTarih.substring(8,10),style: TextStyle(
                                                                        fontSize: 14,
                                                                        color: Colors.white,
                                                                        fontFamily: "NotoSans",
                                                                      )),
                                                                    ),
                                                                    SizedBox(height: 4,),
                                                                    Text(ayBilgisiAl(intAy: indexBorc),style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontFamily: "NotoSans",
                                                                    ),),
                                                                    SizedBox(height: 4,),
                                                                    Text(yilBilgisiAl(intAy: indexBorc),style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontFamily: "NotoSans",
                                                                    ),),
                                                                    /*
                                                        Text("14:30:12",style: TextStyle(
                                                            fontSize: 11
                                                        ),)
                                                        */
                                                                  ],
                                                                )),
                                                            Expanded(
                                                                flex: 9,
                                                                child: Container(
                                                                  //color: Colors.teal,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(height: 4,),
                                                                      Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Container(
                                                                          child: Text(listBorclar[selectedIndex].odenenTaksitSayisi<=indexBorc?"${indexBorc+1}.Taksit Ödemesi Alınmadı.":"${indexBorc+1}.Taksit Ödemesi Alındı.",style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500,
                                                                            fontFamily: "NotoSans",
                                                                          )),
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 8,),
                                                                      Align(
                                                                          alignment: Alignment.center,
                                                                          child: Text(listBorclar[selectedIndex].aylikOdenecekTutar.toString()+" ${listBorclar[selectedIndex].paraBirimi}",style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight: FontWeight.w500,
                                                                            color:listBorclar[selectedIndex].odenenTaksitSayisi<=indexBorc? Colors.redAccent:Colors.green,
                                                                            fontFamily: "NotoSans",
                                                                          ))),
                                                                    ],
                                                                  ),
                                                                )),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                        padding: EdgeInsets.all(8),
                                                                        decoration: ShapeDecoration(
                                                                            shape: StadiumBorder(
                                                                                side: BorderSide(color: listBorclar[selectedIndex].odenenTaksitSayisi<=indexBorc? Colors.transparent:Colors.green,width: 0.4)
                                                                            )

                                                                        ),
                                                                        child: listBorclar[selectedIndex].odenenTaksitSayisi<=indexBorc? Icon(Icons.cancel,color: Colors.redAccent,):Icon(Icons.check,color: Colors.green,)
                                                                    ),
                                                                    SizedBox(height: 4,),
                                                                    Text("Taksit",style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontFamily: "NotoSans",
                                                                    ),),
                                                                    SizedBox(height: 4,),
                                                                    Text((indexBorc+1).toString(),style: TextStyle(
                                                                      fontSize: 12,
                                                                      fontFamily: "NotoSans",
                                                                    ),),
                                                                  ],
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),





                                                /*
                                    Container(
                                        padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(8),
                                                          decoration: BoxDecoration(
                                                            color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                          ),
                                                          child: Text("10",style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                        SizedBox(height: 4,),
                                                        Text("Mayıs",style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "NotoSans",
                                                        ),),
                                                        SizedBox(height: 4,),
                                                        Text("2023",style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "NotoSans",
                                                        ),),
                                                        /*
                                                        Text("14:30:12",style: TextStyle(
                                                            fontSize: 11
                                                        ),)
                                                        */
                                                      ],
                                                    )),
                                                Expanded(
                                                    flex: 9,
                                                    child: Container(
                                                      //color: Colors.teal,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(height: 4,),
                                                          Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Container(
                                                              child: Text("2.Taksidin ödenmesi bekleniyor",style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: "NotoSans",
                                                              )),
                                                            ),
                                                          ),
                                                          SizedBox(height: 4,),
                                                          Align(
                                                              alignment: Alignment.center,
                                                              child: Text("1.250"+" TL",style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.redAccent,
                                                                fontFamily: "NotoSans",
                                                              ))),
                                                        ],
                                                      ),
                                                    )),
                                                Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                            padding: EdgeInsets.all(8),
                                                            decoration: ShapeDecoration(
                                                                shape: StadiumBorder(
                                                                    side: BorderSide(color: Colors.transparent,width: 0.4)
                                                                )

                                                            ),
                                                            child: Icon(Icons.cancel,color: Colors.redAccent,)
                                                        ),
                                                        SizedBox(height: 4,),
                                                        Text("Taksit",style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "NotoSans",
                                                        ),),
                                                        SizedBox(height: 4,),
                                                        Text("2",style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "NotoSans",
                                                        ),),
                                                        /*
                                                        Text("14:30:12",style: TextStyle(
                                                            fontSize: 11
                                                        ),)
                                                        */
                                                      ],
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                                    ),
                                    */
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ):Center(),



                            SizedBox(height: 6,),

                            /*
                            Card(
                              color: Colors.grey[100],
                              elevation: 2,
                              shadowColor: Colors.grey,
                              child: Column(
                                children: [
                                  Container(
                                    //color: Colors.teal,
                                    child: Column(
                                      children: [
                                        /*
                                Container(
                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                      ),
                                                      child: Text("10",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: "NotoSans",
                                                      )),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Mayıs",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2023",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Container(
                                                  //color: Colors.teal,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 4,),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                          child: Text("1.Taksit Ödemesini Elden Aldım.",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8,),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Text("1.250"+" TL",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.green,
                                                            fontFamily: "NotoSans",
                                                          ))),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: ShapeDecoration(
                                                            shape: StadiumBorder(
                                                                side: BorderSide(color: Colors.green,width: 0.4)
                                                            )

                                                        ),
                                                        child: Icon(Icons.check,color: Colors.green,)
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Taksit",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("1",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                                */
                                        Container(
                                            padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                              ),
                                                              child: Text("10",style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.white,
                                                                fontFamily: "NotoSans",
                                                              )),
                                                            ),
                                                            SizedBox(height: 4,),
                                                            Text("Haziran",style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: "NotoSans",
                                                            ),),
                                                            SizedBox(height: 4,),
                                                            Text("2023",style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: "NotoSans",
                                                            ),),
                                                            /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                          ],
                                                        )),
                                                    Expanded(
                                                        flex: 9,
                                                        child: Container(
                                                          //color: Colors.teal,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(height: 4,),
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Container(
                                                                  child: Text("2.Taksidin ödenmesi bekleniyor",style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    fontFamily: "NotoSans",
                                                                  )),
                                                                ),
                                                              ),
                                                              SizedBox(height: 4,),
                                                              Align(
                                                                  alignment: Alignment.center,
                                                                  child: Text("6.250"+" TL",style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.redAccent,
                                                                    fontFamily: "NotoSans",
                                                                  ))),
                                                            ],
                                                          ),
                                                        )),
                                                    Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                padding: EdgeInsets.all(8),
                                                                decoration: ShapeDecoration(
                                                                    shape: StadiumBorder(
                                                                        side: BorderSide(color: Colors.transparent,width: 0.4)
                                                                    )

                                                                ),
                                                                child: Icon(Icons.cancel,color: Colors.redAccent,)
                                                            ),
                                                            SizedBox(height: 4,),
                                                            Text("Taksit",style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: "NotoSans",
                                                            ),),
                                                            SizedBox(height: 4,),
                                                            Text("2",style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: "NotoSans",
                                                            ),),
                                                            /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                          ],
                                                        )),
                                                  ],
                                                )
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
*/

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ///Reklam

            Container(
              //color: Colors.teal,
              //color: Colors.grey[350],
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: Center(child: AdWidget(ad: staticAd)),
            ),


            ///Yorum satırından kaldır.
            /*
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Container(
                width: screenWidth,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Toplam Borç:",style: TextStyle(
                                    fontSize: 16
                                ),),
                                Text(listBorclar.isNotEmpty? money_formatter(listBorclar[0].borcTutar) +" "+ listBorclar[0].paraBirimi:" - ",style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Taksit Sayısı:",style: TextStyle(
                                    fontSize: 13
                                ),),
                                Text(listBorclar.isNotEmpty?listBorclar[0].odenenTaksitSayisi.toString()+"/"+listBorclar[0].toplamTaksitSayisi.toString():" -/- ",style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold
                                ),),
                              ],
                            ),
                            SizedBox(height: 6,),
                            Icon(Icons.arrow_drop_down_outlined)

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),

                    ///Borc detay

                    /*
                    Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Column(
                        children: [
                          Container(
                            //color: Colors.teal,
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                      ),
                                                      child: Text("10",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: "NotoSans",
                                                      )),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Mayıs",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2023",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Container(
                                                  //color: Colors.teal,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 4,),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                          child: Text("1.Taksit Ödemesini Elden Aldım.",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8,),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Text("6.250"+" TL",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.green,
                                                            fontFamily: "NotoSans",
                                                          ))),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: ShapeDecoration(
                                                        shape: StadiumBorder(
                                                          side: BorderSide(color: Colors.green,width: 0.4)
                                                        )

                                                      ),
                                                      child: Icon(Icons.check,color: Colors.green,)
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Taksit",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("1",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                ),





                                /*
                                Container(
                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                      ),
                                                      child: Text("10",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: "NotoSans",
                                                      )),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Mayıs",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2023",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Container(
                                                  //color: Colors.teal,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 4,),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                          child: Text("2.Taksidin ödenmesi bekleniyor",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4,),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Text("1.250"+" TL",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.redAccent,
                                                            fontFamily: "NotoSans",
                                                          ))),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: ShapeDecoration(
                                                            shape: StadiumBorder(
                                                                side: BorderSide(color: Colors.transparent,width: 0.4)
                                                            )

                                                        ),
                                                        child: Icon(Icons.cancel,color: Colors.redAccent,)
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Taksit",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                                */
                              ],
                            ),
                          )
                        ],
                      ),
                    ),



                    SizedBox(height: 6,),
                    Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Column(
                        children: [
                          Container(
                            //color: Colors.teal,
                            child: Column(
                              children: [
                                /*
                                Container(
                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                      ),
                                                      child: Text("10",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: "NotoSans",
                                                      )),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Mayıs",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2023",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Container(
                                                  //color: Colors.teal,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 4,),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                          child: Text("1.Taksit Ödemesini Elden Aldım.",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8,),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Text("1.250"+" TL",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.green,
                                                            fontFamily: "NotoSans",
                                                          ))),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: ShapeDecoration(
                                                            shape: StadiumBorder(
                                                                side: BorderSide(color: Colors.green,width: 0.4)
                                                            )

                                                        ),
                                                        child: Icon(Icons.check,color: Colors.green,)
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Taksit",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("1",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                                */
                                Container(
                                    padding: EdgeInsets.only(left: 4,top: 5,right: 4,bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.mainColor.withOpacity(0.7),//Colors.grey[350]
                                                      ),
                                                      child: Text("10",style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: "NotoSans",
                                                      )),
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Haziran",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2023",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 9,
                                                child: Container(
                                                  //color: Colors.teal,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 4,),
                                                      Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: Container(
                                                          child: Text("2.Taksidin ödenmesi bekleniyor",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "NotoSans",
                                                          )),
                                                        ),
                                                      ),
                                                      SizedBox(height: 4,),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Text("6.250"+" TL",style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.redAccent,
                                                            fontFamily: "NotoSans",
                                                          ))),
                                                    ],
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        padding: EdgeInsets.all(8),
                                                        decoration: ShapeDecoration(
                                                            shape: StadiumBorder(
                                                                side: BorderSide(color: Colors.transparent,width: 0.4)
                                                            )

                                                        ),
                                                        child: Icon(Icons.cancel,color: Colors.redAccent,)
                                                    ),
                                                    SizedBox(height: 4,),
                                                    Text("Taksit",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    SizedBox(height: 4,),
                                                    Text("2",style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: "NotoSans",
                                                    ),),
                                                    /*
                                                    Text("14:30:12",style: TextStyle(
                                                        fontSize: 11
                                                    ),)
                                                    */
                                                  ],
                                                )),
                                          ],
                                        )
                                      ],
                                    )
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )

                    */
                  ],
                ),
              ),
            ),
            */

          ],
        ),
      ),
    );
  }

  String money_formatter(double amount){ //para birimi parametre olarak gelecek.
    MoneyFormatter fmf = new MoneyFormatter( //fmf objesi ile double değeri ile biçimlendirdik.
        amount: amount,
        settings: MoneyFormatterSettings(
            symbol: 'TL',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: '...',
            fractionDigits: 2,
            compactFormatType: CompactFormatType.short
        )
    );
    MoneyFormatterOutput fo = fmf.output;  //biçimlendirilen değerin çıktısını çıktı objesine atadık.
    var a=fo.nonSymbol.toString(); //bu çıktı objesini sembolsuz olarak stringe cevirdik.
    return a; //double girilen değer string olarak geri döndürülmüştür.
  }
}
