import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:musteri_takip/dao/veritabanidao.dart';
import 'package:musteri_takip/model/model_borclar.dart';
import 'package:musteri_takip/utils/color.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TaksitliBorcListe extends StatefulWidget {
  const TaksitliBorcListe({Key? key}) : super(key: key);

  @override
  State<TaksitliBorcListe> createState() => _TaksitliBorcListeState();
}

class _TaksitliBorcListeState extends State<TaksitliBorcListe> {

  var listBorcDurum=<String>["Aktif","Pasif"];
  String selectedBorcDurum="Aktif";


  var listAylar=<String>["01","02","03","04","05","06","07","08","09","10","11","12"];
  String selectedAy="01";


  var listYillar=<String>[DateTime.now().year.toString()];
  String selectedYil=DateTime.now().year.toString();

  ///Taksit ile aylık gelen borç listesi
  var listBorclar=<ModelBorclar>[];

  ///Tüm borçlar
  var listTumBorclar=<ModelBorclar>[];

  Future<String> getAyBilgisi()async{
    int ay=DateTime.now().month;
    String strAy="";
    if(ay<10){
      strAy="0"+ay.toString();
    }else{
      strAy=ay.toString();
    }
    return strAy;
  }

  Future<void>getList({required String borcDurum,required String ay,required String yil})async{
    listBorclar=await VeritabaniDao().borcListeFiltre(borcDurum: borcDurum, ay: ay, yil: yil);
    if(listBorclar.isEmpty){
      setState(() {
        durum="Bu Ay'a Ait Taksit Bulunmamaktadır";
      });
    }else{
      setState(() {
        durum="";
      });
    }

    setState(() {
      listBorclar;
    });
  }
  String durum="Yükleniyor...!";

  Future<void>getLocal()async{
    selectedAy=await getAyBilgisi();
    listYillar.clear();
    listBorclar=await VeritabaniDao().borcListesi(yil: DateTime.now().year,ay: DateTime.now().month);
    listTumBorclar=await VeritabaniDao().tumBorclarborcListesi();

    if(listBorclar.isEmpty){
      setState(() {
        durum="Bu Ay'a Ait Taksit Bulunmamaktadır";
      });
    }else{
      setState(() {
        durum="";
      });
    }

    setState(() {
      listBorclar;
      listTumBorclar;
    });
    for(int i=int.parse(selectedYil)-10;i<int.parse(selectedYil)+10;i++){
      setState(() {
        listYillar.add(i.toString());
      } );
    }


    print("*** BORÇLAR ***");
    for(var i in listBorclar){
      print("Müşteri Kod: ${i.musteriKod}");
      print("Müşteri Ad: ${i.musteriAd}");
      print("Başlangıç Tarih: ${i.baslangicTarih}");
      print("Bitiş Tarih: ${i.bitisTarih}\n\n\n");
    }
  }

  bool boolTumBorclar=false;

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


  ///Listede görüntülenecek mi kontrol et
  bool showCheck({required String strBaslangicTarih,required int odenenTaksit}){
    /// (Başlangıç Tarih+Ödenen Taksit) < Şuan ki Tarih
    DateTime guncelOdenenTarih=DateTime(int.parse(strBaslangicTarih.substring(0,4)),int.parse(strBaslangicTarih.substring(5,7))+odenenTaksit,int.parse(strBaslangicTarih.substring(8,10)));
    DateTime geciciTarih=DateTime(int.parse(selectedYil),int.parse(selectedYil),1);
    //DateTime sorgulananTarih=DateTime(int.parse(selectedYil),int.parse(selectedAy),infoLastDate(geciciTarih));
    DateTime sorgulananTarih=DateTime(int.parse(selectedYil),int.parse(selectedAy),int.parse(strBaslangicTarih.substring(8,10)));

    print("GÜNCEL TARİH: ${guncelOdenenTarih}     SORGULANAN TARİH: ${sorgulananTarih}");
    if(guncelOdenenTarih.compareTo(sorgulananTarih)<=0){
      print("TRUE");
      return true;
    }else{
      print("FALSE");
      return false;
    }

    

  }

  int infoLastDate(DateTime date){

    var infos=DateTime(date.year,date.month+1,date.day-date.day);

    return infos.day;
  }


  String strAylikOdenecekTutar(){
    double aylikToplam=0;
    if(boolTumBorclar){
      for(var i in listTumBorclar){
        aylikToplam+=i.aylikOdenecekTutar;
      }
      return money_formatter(aylikToplam);

    }else if(listBorclar.isEmpty){
      return "0.00";
    }else {
      for(var i in listBorclar){
        aylikToplam+=i.aylikOdenecekTutar;
      }
      return money_formatter(aylikToplam);
    }
  }

  String strTumBorclarToplamTutar(){
    double toplamTutar=0;
    if(boolTumBorclar){
      for(var i in listTumBorclar){
        toplamTutar+=(i.toplamTaksitSayisi-i.odenenTaksitSayisi)*i.aylikOdenecekTutar;
      }
      return money_formatter(toplamTutar);

    }else if(listBorclar.isEmpty){
      return "0.00";
    }else {
      for(var i in listBorclar){
        toplamTutar+=(i.toplamTaksitSayisi-i.odenenTaksitSayisi)*i.aylikOdenecekTutar;
      }
      return money_formatter(toplamTutar);
    }
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
        title: Text("Borç Liste"),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(height: 8,),
          ///Filtre
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
                      Text("Borç Durum"),
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
                                    value: selectedBorcDurum,
                                    items: listBorcDurum.map<DropdownMenuItem<String>>((String value){

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
                                        selectedBorcDurum=selectedData!;
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

                      /// Ay ve yıl text
                      Row(
                        children: [
                          SizedBox(width: 4,),
                          Expanded(
                              child: Text("Ay")),
                          SizedBox(width: 4,),
                          Expanded(
                              child: Text("Yıl")),
                        ],
                      ),
                      SizedBox(height: 6,),
                      /// Ay ve yıl değer
                      Row(
                        children: [
                          Expanded(
                            child: Container(
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
                                        value: selectedAy,
                                        items: listAylar.map<DropdownMenuItem<String>>((String value){

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
                                            selectedAy=selectedData!;
                                          });

                                          getList(borcDurum: selectedBorcDurum, ay: selectedAy, yil: selectedYil);

                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),),
                          SizedBox(width: 10,),
                          Expanded(
                            child: Container(
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
                                        value: selectedYil,
                                        items: listYillar.map<DropdownMenuItem<String>>((String value){

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
                                            selectedYil=selectedData!;
                                          });
                                          getList(borcDurum: selectedBorcDurum, ay: selectedAy, yil: selectedYil);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),)
                        ],
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: (){
                          if(boolTumBorclar){
                            setState(() {
                              boolTumBorclar=false;
                            });
                          }else{
                            setState(() {
                              boolTumBorclar=true;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Tüm Borçları Görüntüle",style: TextStyle(
                              fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 15: MediaQuery.of(context).size.width<321? 13:15
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?13:16,
                            ),),
                            SizedBox(width: 12,),
                            SizedBox(
                              height: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 15: MediaQuery.of(context).size.width<321? 13:15
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?13:16,
                              width: MediaQuery.of(context).orientation ==Orientation.portrait
                                  ?MediaQuery.of(context).size.height>821? 15: MediaQuery.of(context).size.width<321? 13:15
                                  :MediaQuery.of(context).size.height>551? 16:MediaQuery.of(context).size.height<321?13:16,
                              child: Transform.scale(
                                scale: 1.05,
                                child: Checkbox(
                                  value: boolTumBorclar,
                                  activeColor: AppColors.mainColor.withOpacity(0.8),//Color(0xFFD76F22),
                                  onChanged: (value){
                                    setState(() {
                                      boolTumBorclar=value!;
                                    });

                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),

                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),

          boolTumBorclar?Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Container(
                  width: screenWidth,
                  child: ListView.builder(
                    itemCount: listTumBorclar.length,
                    itemBuilder: (context,index){
                      return  Card(
                        color: Colors.grey[100],
                        elevation: 2,
                        shadowColor: Colors.grey,
                        child: Container(
                          padding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
                          width: screenWidth,
                          color: listTumBorclar[index].borcDurum=="Aktif"?Colors.orange.withOpacity(0.17):Colors.red.shade50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(listTumBorclar[index].musteriAd,style: TextStyle(
                                      fontWeight: FontWeight.w500
                                  )),
                                  Spacer(),
                                  Text(listTumBorclar[index].odenenTaksitSayisi.toString()+"/"+listTumBorclar[index].toplamTaksitSayisi.toString()),
                                ],
                              ),
                              SizedBox(height: 4,),
                              ///Taksit Tutar
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Taksit Tutar: ",style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey
                                  ),),
                                  Text(money_formatter(listTumBorclar[index].aylikOdenecekTutar)+" "+listTumBorclar[index].paraBirimi,style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                              SizedBox(height: 4,),
                              ///Toplam Borç
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("Toplam Tutar: ",style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey
                                  ),),
                                  Text(money_formatter(listTumBorclar[index].borcTutar)+" "+listTumBorclar[index].paraBirimi,style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                              SizedBox(height: 4,),
                              Row(
                                children: [
                                  Text("Gün: ",style: TextStyle(
                                      fontWeight: FontWeight.w400
                                  )),
                                  Container(
                                    padding: EdgeInsets.only(left:4,top: 1,right: 4,bottom: 1),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: AppColors.mainColor.withOpacity(0.8),
                                    ),
                                    child: Text(listTumBorclar[index].baslangicTarih.substring(8,10),style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white
                                    )),
                                  ),
                                  Spacer(),
                                  Text("Kalan Tutar: ",style: TextStyle(
                                      fontSize: 12.5,
                                      color: Colors.grey
                                  ),),
                                  Text(money_formatter(listTumBorclar[index].borcTutar-(listTumBorclar[index].aylikOdenecekTutar*listTumBorclar[index].odenenTaksitSayisi))+" "+listTumBorclar[index].paraBirimi,style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
              ),
            ),
          ):
          ///Liste
          listBorclar.isEmpty?Padding(
            padding: EdgeInsets.only(left:5,top: 5,right: 5),
            child: Card(
              child: Container(
                child: Column(
                  children: [
                    //durum=="Müşteri Listesi Boş"?Center():CircularProgressIndicator(),
                    durum=="Bu Ay'a Ait Taksit Bulunmamaktadır"?Center():SizedBox(height: 16,),
                    durum=="Bu Ay'a Ait Taksit Bulunmamaktadır"?Center():Center(child: CircularProgressIndicator()),
                    SizedBox(height: 16,),
                    Text(durum),
                    SizedBox(height: 16,),
                  ],
                ),
              ),
            ),
          ):
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8,right: 8),
              child: Container(
                width: screenWidth,
                child: ListView.builder(
                  itemCount: listBorclar.length,
                  itemBuilder: (context,index){
                    return showCheck(strBaslangicTarih: listBorclar[index].baslangicTarih, odenenTaksit: listBorclar[index].odenenTaksitSayisi)==false?Center():Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Container(
                        padding: EdgeInsets.only(left:10,top: 10,bottom: 10,right: 10),
                        width: screenWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(listBorclar[index].musteriAd,style: TextStyle(
                                  fontWeight: FontWeight.w500
                                )),
                                Spacer(),
                                Text(listBorclar[index].odenenTaksitSayisi.toString()+"/"+listBorclar[index].toplamTaksitSayisi.toString()),
                              ],
                            ),
                            SizedBox(height: 4,),
                            ///Taksit Tutar
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Taksit Tutar: ",style: TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.grey
                                ),),
                                Text(money_formatter(listBorclar[index].aylikOdenecekTutar)+" "+listBorclar[index].paraBirimi,style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500
                                )),
                              ],
                            ),
                            SizedBox(height: 4,),
                            ///Toplam Borç
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text("Toplam Tutar: ",style: TextStyle(
                                    fontSize: 12.5,
                                    color: Colors.grey
                                ),),
                                Text(money_formatter(listBorclar[index].borcTutar)+" "+listBorclar[index].paraBirimi,style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500
                                )),
                              ],
                            ),
                            SizedBox(height: 4,),
                            Row(
                              children: [
                                Text("Gün: ",style: TextStyle(
                                    fontWeight: FontWeight.w400
                                )),
                                Container(
                                  padding: EdgeInsets.only(left:4,top: 1,right: 4,bottom: 1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: AppColors.mainColor.withOpacity(0.8),
                                  ),
                                  child: Text(listBorclar[index].baslangicTarih.substring(8,10),style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white
                                  )),
                                ),
                                Spacer(),
                                Text("Kalan Tutar: ",style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.grey
                                ),),
                                Text(money_formatter(listBorclar[index].borcTutar-(listBorclar[index].aylikOdenecekTutar*listBorclar[index].odenenTaksitSayisi))+" "+listBorclar[index].paraBirimi,style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ),
            ),
          ),
          ///Reklam
          ///liste boş ise reklam koyma

          listBorclar.isEmpty?Center():Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left:5,top: 5,right: 5),
                  child: Container(
                    child: Card(
                      color: Colors.grey[100],
                      elevation: 2,
                      shadowColor: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(height: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Taksit Toplam: ",style: TextStyle(fontSize: 13)),
                              Text(strAylikOdenecekTutar(),style: TextStyle(color: AppColors.mainColor,fontWeight: FontWeight.bold,fontSize: 12),),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Genel Toplam: ",style: TextStyle(fontSize: 13),),
                              Text(strTumBorclarToplamTutar(),style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold,fontSize: 13),),
                            ],
                          ),
                          SizedBox(height: 2,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          listBorclar.isEmpty?Center():Container(
            //color: Colors.teal,
            //color: Colors.grey[350],
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: Center(child: AdWidget(ad: staticAd)),
          ),



        ],
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
