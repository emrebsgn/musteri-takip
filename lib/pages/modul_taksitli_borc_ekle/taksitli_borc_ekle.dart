import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/pages/home_screen.dart';
import 'package:musteri_takip/utils/color.dart';

import '../../dao/veritabanidao.dart';
import '../../model/model_musteriler.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class TaksitliBorcEkle extends StatefulWidget {
  const TaksitliBorcEkle({Key? key}) : super(key: key);

  @override
  State<TaksitliBorcEkle> createState() => _TaksitliBorcEkleState();
}

class _TaksitliBorcEkleState extends State<TaksitliBorcEkle> {

  //var listMusteriler=<String>["A firması","B firması","C firması"];
  late ModelMusteriler selectedMusteri;


  var listParaBirimi=["TL","Dolar","Euro","Sterlin","Diğer"];
  String selectedParaBirimi="TL";

  var _tfToplamBorc=TextEditingController();
  var _tfTaksitSayisi=TextEditingController();

  late FocusNode focusToplamTutar;
  late FocusNode focusTaksitSayisi;

  String strBaslangicTarih="";
  String strBitisTarih="";

  DateTime newDatebaslangic=DateTime.now();
  DateTime newDateBitis=DateTime.now();
  DateTime fixedDate=DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+10);

  double aylikTutar=0;

  String errorBorcTutar="";
  String errorTaksitTutar="";

  var listMusteriler=<ModelMusteriler>[];

  Future<void>getLocal()async{
    var a=ModelMusteriler(musteriKod: "", musteriAd: "Seç", cinsiyet: "ERKEK", ulke: "", il: "", ilce: "", tel: "", mail: "", web: "", not: "");
    strBaslangicTarih=newDatebaslangic.toString().substring(0,11);
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

  void showSnackBar({required String hataMesaji}){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(hataMesaji))
    );
  }
  var alert=AlertMessage();

  ///Aylık tutarı hesaplayan foknsiyon
  void funcAylikTutar({required double prmBorcTutar,required int prmTaksitSayisi}){
    aylikTutar=prmBorcTutar/prmTaksitSayisi;

    if(prmBorcTutar<prmTaksitSayisi){
      //showSnackBar(hataMesaji: "Taksit Sayısı Borç Tutarını Geçemez");
      alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Taksit Sayısı Borç Tutarını Geçemez", alertType: "Hata");
    }

    setState(() {
      aylikTutar;
    });

  }

  Future<bool>redirectPage()async{
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    return true;
  }

  var listHarfler=<String>["a","b","c","ç","d","e","f","g","h","ı","i","j","k","l","m","n","o","ç","p","r","s","ş","t","u","ü","v","y","z","[","]","{","}","!","'","^","/","*","-","-","_","?"];

  bool boolGecersizDeger=false;


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
    focusToplamTutar=FocusNode();
    focusTaksitSayisi=FocusNode();
    super.initState();
    getLocal();
  }

  @override
  void dispose() {
    focusToplamTutar.dispose();
    focusTaksitSayisi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: ()=>redirectPage(),
        ),
        backgroundColor: AppColors.mainColor,
        title: Text("Borç Ekle"),
      ),
      backgroundColor: Colors.grey[300],
      body: WillPopScope(
        onWillPop: ()=>redirectPage(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 8,),

              Container(
                //color: Colors.teal,
                constraints: BoxConstraints(
                  maxHeight: screenHeight-56-MediaQuery.of(context).padding.bottom-110
                ),
                child: ListView(
                  children: [
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



                    ///Borç Tutar - Taksit Sayısı Card
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



                                Text("Para Birimi"),
                                SizedBox(height: 6,),
                                ///Para Birimi
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(left:16,top: 8,right: 4,bottom: 8),
                                        height: MediaQuery.of(context).orientation ==Orientation.portrait
                                            ?MediaQuery.of(context).size.width<321? 38:42
                                            :MediaQuery.of(context).size.height<321?38:42,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1,color: AppColors.mainColor),
                                            borderRadius: BorderRadius.circular(6),
                                            color: Colors.blue.withOpacity(0.08)
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            borderRadius: BorderRadius.circular(12),
                                            isDense: true,
                                            value: selectedParaBirimi,
                                            items: listParaBirimi.map<DropdownMenuItem<String>>((String value){
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            icon: Icon(Icons.arrow_drop_down),
                                            onChanged: (String? selectedData) async{
                                              setState(() {
                                                selectedParaBirimi=selectedData!;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),


                                Text("Borç Tutar"),
                                SizedBox(height: 6,),
                                ///Borç Tutar Gir
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
                                          controller:_tfToplamBorc,
                                          focusNode: focusToplamTutar,
                                          keyboardType: TextInputType.number,
                                          //textCapitalization: TextCapitalization.characters,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "NotoSans",
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Borç Tutar Gir",
                                            hintStyle: TextStyle(
                                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[400]
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: 3),
                                            //contentPadding: EdgeInsets.zero,
                                            enabledBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (onSubmitValue){
                                            setState(() {
                                              focusTaksitSayisi.requestFocus();
                                            });

                                          },
                                          onChanged: (value){
                                            try{
                                              if(_tfToplamBorc.text.isNotEmpty){
                                                double tutar=double.parse(_tfToplamBorc.text);
                                              }

                                              if(_tfToplamBorc.text.isNotEmpty && _tfTaksitSayisi.text.isNotEmpty){
                                                funcAylikTutar(prmBorcTutar: double.parse(_tfToplamBorc.text), prmTaksitSayisi: int.parse(_tfTaksitSayisi.text));
                                              }

                                              setState(() {
                                                errorBorcTutar="";
                                                boolGecersizDeger=false;
                                              });


                                            }catch(e){
                                              setState(() {
                                                errorBorcTutar="Lütfen Geçerli Bir Tutar Giriniz !";
                                                boolGecersizDeger=true;
                                              });
                                              //showSnackBar(hataMesaji: e.toString());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2,),


                                _tfToplamBorc.text.isEmpty?Center():
                                Padding(
                                  padding: EdgeInsets.only(top: 3,right: 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      boolGecersizDeger? Center():Text(money_formatter(double.parse(_tfToplamBorc.text))+" "+selectedParaBirimi,style: TextStyle(color: Colors.redAccent,fontSize: 12),)
                                    ],
                                  ),
                                ),

                                errorBorcTutar.isNotEmpty?Padding(
                                  padding: EdgeInsets.only(top:4),
                                  child: Text("${errorBorcTutar}",style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.redAccent
                                  ),),
                                ):Center(),
                                SizedBox(height: 6,),


                                Text("Taksit Sayısı"),
                                SizedBox(height: 6,),
                                ///Taksit Sayısı Gir
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
                                          controller:_tfTaksitSayisi,
                                          focusNode: focusTaksitSayisi,
                                          keyboardType: TextInputType.number,
                                          //textCapitalization: TextCapitalization.characters,
                                          textAlign: TextAlign.left,
                                          maxLines: 1,
                                          autofocus: false,
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "NotoSans",
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: "Taksit Sayısı Gir",
                                            hintStyle: TextStyle(
                                                fontSize: MediaQuery.of(context).orientation ==Orientation.portrait
                                                    ?MediaQuery.of(context).size.height>821? 14: MediaQuery.of(context).size.width<321?12:15
                                                    :MediaQuery.of(context).size.height>551? 15:MediaQuery.of(context).size.height<321?12:15,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "NotoSans",
                                                color: Colors.grey[400]
                                            ),
                                            //contentPadding: EdgeInsets.only(bottom: 3),
                                            //contentPadding: EdgeInsets.zero,
                                            enabledBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (onSubmitValue){


                                          },
                                          onChanged: (value){
                                            if(_tfTaksitSayisi.text.isEmpty){
                                              setState(() {
                                                errorTaksitTutar="";
                                              });
                                            }else if(_tfTaksitSayisi.text.startsWith("0")){
                                              setState(() {
                                                errorTaksitTutar="TAKSİT 0 GİRİLEMEZ";
                                              });
                                            }else{
                                              try{
                                                if(_tfTaksitSayisi.text.isNotEmpty){
                                                  int tutar=int.parse(_tfTaksitSayisi.text);
                                                }

                                                if(_tfToplamBorc.text.isNotEmpty && _tfTaksitSayisi.text.isNotEmpty){
                                                  funcAylikTutar(prmBorcTutar: double.parse(_tfToplamBorc.text), prmTaksitSayisi: int.parse(_tfTaksitSayisi.text));
                                                }
                                                setState(() {
                                                  errorTaksitTutar="";
                                                  if(newDatebaslangic.month+int.parse(_tfTaksitSayisi.text)>12){
                                                    /// 7. ayda borç eklenir. borç taksiti 10dur, 7+10=>17 olduğu için yeni tarihe 17-12 eklememiz gerekir.
                                                    newDateBitis=DateTime(newDatebaslangic.year+1,(newDatebaslangic.month+int.parse(_tfTaksitSayisi.text))-12,newDatebaslangic.day);
                                                  }else{
                                                    newDateBitis=DateTime(newDatebaslangic.year,newDatebaslangic.month+int.parse(_tfTaksitSayisi.text),newDatebaslangic.day);
                                                  }

                                                  fixedDate=DateTime(newDatebaslangic.year,newDatebaslangic.month+int.parse(_tfTaksitSayisi.text),newDatebaslangic.day+10);
                                                  strBitisTarih=newDateBitis.toString().substring(0,11);
                                                  print("str bitis tarih: ${strBitisTarih}");
                                                  boolGecersizDeger=false;
                                                });

                                              }catch(e){
                                                setState(() {
                                                  errorTaksitTutar="Lütfen Geçerli Bir Taksit Giriniz";
                                                  boolGecersizDeger=true;
                                                });
                                                //showSnackBar(hataMesaji: e.toString());
                                              }
                                            }


                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2,),

                                boolGecersizDeger? Center():_tfToplamBorc.text.isNotEmpty && _tfTaksitSayisi.text.isNotEmpty?
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Aylık Ödenecek Tutar: "),
                                      Text("${money_formatter(aylikTutar)} ${selectedParaBirimi}",style: TextStyle(fontWeight: FontWeight.bold)),
                                      //Text("${aylikTutar.toStringAsFixed(2 )} TL",style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ):Center(),



                                errorTaksitTutar.isNotEmpty?Padding(
                                  padding: EdgeInsets.only(top:4),
                                  child: Text("${errorTaksitTutar}",style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.redAccent
                                  ),),
                                ):Center(),
                                SizedBox(height: 6,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),


                    ///İlk Taksit Tarihi Card
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
                                Text("Taksit Başlangıç Tarih"),
                                SizedBox(height: 6,),

                                GestureDetector(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: AppColors.mainColor.withOpacity(0.8), // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.white, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        //initialDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1),
                                        initialDate: strBaslangicTarih==""?DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day):newDatebaslangic,
                                        firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-10),
                                        lastDate: DateTime(DateTime.now().year+10,DateTime.now().month,DateTime.now().day),
                                        currentDate: DateTime.now()
                                    ).then((alinanTarih) async {
                                      if(alinanTarih.toString().contains("null")){

                                      }else{
                                        setState(() {
                                          strBaslangicTarih=alinanTarih.toString().substring(0,11);
                                          newDatebaslangic=alinanTarih!;
                                        });
                                      }

                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left:10,top: 10,right: 2,bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(strBaslangicTarih.substring(8,10)+"-"+strBaslangicTarih.substring(5,7)+"-"+strBaslangicTarih.substring(0,4),style: TextStyle(
                                          //color: AppColors.mainColor,
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "PoppinsRegular",)),
                                        Icon(Icons.arrow_drop_down,color: Colors.black54,size: 18,)
                                      ],
                                    ),
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


                    ///Bitiş Tarihi Card
                    _tfToplamBorc.text.isNotEmpty && _tfTaksitSayisi.text.isNotEmpty? Padding(
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
                                Text("Taksit Bitiş Tarih"),
                                SizedBox(height: 6,),

                                GestureDetector(
                                  onTap: (){
                                    FocusScope.of(context).unfocus();
                                    showDatePicker(
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: AppColors.mainColor.withOpacity(0.8), // header background color
                                                onPrimary: Colors.white, // header text color
                                                onSurface: Colors.black, // body text color
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                style: TextButton.styleFrom(
                                                  backgroundColor: Colors.white, // button text color
                                                ),
                                              ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                        context: context,
                                        initialDate: strBitisTarih==""?DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day):newDateBitis,
                                        firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-10),
                                        lastDate: fixedDate,//DateTime(newDateBitis.year,newDateBitis.month,newDateBitis.day),
                                        //lastDate: DateTime(DateTime.now().year+(int.parse(_tfTaksitSayisi.text)),DateTime.now().month,DateTime.now().day),
                                        currentDate: DateTime.now()
                                    ).then((alinanTarih) async {
                                      if(alinanTarih.toString().contains("null")){

                                      }else{
                                        setState(() {
                                          strBitisTarih=alinanTarih.toString().substring(0,11);
                                          newDateBitis=alinanTarih!;
                                        });
                                      }

                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left:10,top: 10,right: 2,bottom: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        boolGecersizDeger? Center():Text(strBitisTarih.substring(8,10)+"-"+strBitisTarih.substring(5,7)+"-"+strBitisTarih.substring(0,4),style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontFamily: "PoppinsRegular",)),
                                        Icon(Icons.arrow_drop_down,color: Colors.black54,size: 18,)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12,),




                              ],
                            ),
                          ),
                        ),
                      ),
                    ):Center(),
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
                                        _tfToplamBorc.clear();
                                        _tfTaksitSayisi.clear();
                                      });

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

                                      print("*** EKLEMEDEN ÖNCE KONTROL ET ***");
                                      //print(" Taksit Sayısı: ${int.parse(_tfTaksitSayisi.text)}");
                                      print(" odenenTaksitSayisi: ${0}");

                                      if(selectedMusteri.musteriAd=="Seç"){
                                        //showSnackBar(hataMesaji: "Lütfen Müşteri Seçin");
                                        alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Lütfen Müşteri Seçin", alertType: "Hata");
                                      }else if(boolGecersizDeger){
                                        //showSnackBar(hataMesaji: "Tutar veya Taksit Değeri Hatalı");
                                        alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Tutar veya Taksit Değeri Hatalı", alertType: "Hata");
                                      }else if(_tfToplamBorc.text.isEmpty){
                                        alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Borç Tutar Boş Bırakılamaz", alertType: "Hata");
                                      }else if(_tfTaksitSayisi.text.isEmpty){
                                        alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Taksit Sayısı Boş Bırakılamaz", alertType: "Hata");
                                      }else{
                                        try{
                                          await VeritabaniDao().borcEkle(
                                              context: context,
                                              borcKod: "default",
                                              borcTutar: double.parse(_tfToplamBorc.text),
                                              toplamTaksitSayisi: int.parse(_tfTaksitSayisi.text),
                                              aylikOdenecekTutar: double.parse(_tfToplamBorc.text)/int.parse(_tfTaksitSayisi.text),
                                              odenenTaksitSayisi: 0,
                                              baslangicTarih: strBaslangicTarih,
                                              bitisTarih: strBitisTarih,
                                              borcDurum: "Aktif",
                                              paraBirimi: selectedParaBirimi,
                                              musteri_kod: selectedMusteri.musteriKod,
                                              musteri_ad:selectedMusteri.musteriAd
                                          );
                                        }catch(e){
                                          alert.alertInfoIcon(context, color: Colors.redAccent, infoText: "Lütfen Girdiğiniz Bilgileri Kontrol Edin", alertType: "Hata");
                                        }
                                      }



                                    }, child: Text("Oluştur", style: TextStyle(
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
