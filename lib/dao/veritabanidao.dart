import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:musteri_takip/alert_class/alert_message.dart';
import 'package:musteri_takip/model/model_musteriler.dart';
import 'package:musteri_takip/pages/modul_musteri_kartlari/musteri_kartlari.dart';
import 'package:musteri_takip/pages/modul_taksitli_borc_ekle/taksitli_borc_ekle.dart';

import '../VeriTabaniYardimcisi.dart';
import '../model/model_borclar.dart';

class VeritabaniDao{



  ///                                                Gelir Gider Bilgileri


  /*

  Future<List<ModelGelirGider>> gelirGiderBilgileri({ required String islemTuru,required String zaman})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String sorgu="SELECT * from gelirgidertable";

    DateTime date=DateTime.now();
    String strDate=date.toString().substring(0,10);



    if(islemTuru=="Hepsi"){
      print("HEPSİ");
      if(zaman=="Bugün"){
        print("Bugün");
        //sorgu="select * from gelirgidertable WHERE tarih BETWEEN '2022-12-28' AND '2022-12-29'";
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
        //sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${strDate}' AND '2022-12-29'";
      }else if(zaman=="Dün"){
        print("Dün");
        //sorgu="SELECT * from gelirgidertable WHERE";
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        print("Son 7 gün");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        print("Son 15 gün");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        print("Bu Ay");
        sorgu="select * from gelirgidertable WHERE tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else{

      }
    }else if(islemTuru=="Gelenler"){
      if(zaman=="Bugün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Dün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gelir' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }

    }else if(islemTuru=="Gidenler"){
      /*
      print("Alternatif 2");
      sorgu="SELECT * from gelirgidertable WHERE islem_tipi='GİDER'";
      */
      if(zaman=="Bugün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${strDate}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Dün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 7 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-7).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Son 15 gün"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-15).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }else if(zaman=="Bu Ay"){
        sorgu="SELECT * from gelirgidertable WHERE islem_tipi='Gider' AND tarih BETWEEN '${DateTime(DateTime.now().year,DateTime.now().month,1).toString().substring(0,10)}' AND '${DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day+1).toString().substring(0,10)}' ORDER BY gelir_gider_ID DESC";
      }
    }else if(zaman=="TÜMÜ"){
      sorgu="SELECT * from gelirgidertable islem_tipi='Gider'";
    }else{

    }



    List<Map<String,dynamic>> maps=await db.rawQuery(sorgu);

    return List.generate(maps.length, (i) {

      var satir=maps[i];
      print("BAAAAAAK: ${satir["tutar"]}");

      late double tutar;

      if(satir["tutar"].toString().contains(".")){
        tutar=satir["tutar"];
      }else{
        tutar=double.parse(satir["tutar"].toString()+".0");
      }

      print("BAAAKMA :${tutar}");
      return ModelGelirGider(
        satir["gelir_gider_ID"],
        satir["islem_tipi"],
        satir["tarih"],
        satir["aciklama"],
        tutar,
      );

    });
  }
  */

  Future<double>islemTipiToplami({required islemTipi})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String sorgu="SELECT SUM (tutar) as toplamGider FROM gelirgidertable WHERE islem_tipi='${islemTipi}'";
    //double toplam=5;
    print("new sorgu: ${sorgu}");

    //var a= await db.rawQuery(sorgu);

    List<Map<String,dynamic>> maps=await db.rawQuery(sorgu);
    if(maps[0]["toplamGider"]==null){
      print("Null olduğu için ilk return'e girmektedir.");
      return 0;
    }else{
      print("ikinci return. ${maps[0]["toplamGider"]}");
      var toplamGider=maps[0]["toplamGider"];
      if(toplamGider.toString().contains(".")){
        return toplamGider;
      }else{
        return double.parse(toplamGider.toString()+".0");
      }
      //return maps[0]["toplamGider"];
    }



    /*
      List.generate(maps.length, (i) {

      var satir=maps[i];

      return ModelGelirGider(
        satir["gelir_gider_ID"],
        satir["islem_tipi"],
        satir["tarih"],
        satir["aciklama"],
        satir["tutar"],
      );
*/

  }



  Future<void>tableClear(String tableName)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.execute("DELETE FROM ${tableName}");

  }


  Future<void>musteriSil({required String musteri_kod})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.delete("musteriler",where: "musteri_kod=?",whereArgs: [musteri_kod]);
  }


  Future<void>borcSil({required String musteri_kod})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.delete("borclar",where: "musteri_kod=?",whereArgs: [musteri_kod]);
  }




  Future<void>taksitGuncelle({required String musteri_kod,required int yeniOdenenTaksitSayisi})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["odenen_taksit_sayisi"]=yeniOdenenTaksitSayisi;

    await db.update("borclar", bilgiler,where: "musteri_kod=?",whereArgs: [musteri_kod]);

  }


  Future<int> lineCount({required String tableName,required String columnName,required String columnValue})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    columnValue='"'"${columnValue}"'"';



    String baseQuery="Select COUNT(*) as 'sayi' from ${tableName} where ${columnName}=${columnValue}";
    print("Beni ellere sorma : ${baseQuery}");




    List<Map<String,dynamic>> maps=await db.rawQuery(baseQuery);


    var satir=maps[0];

    return satir["sayi"];
  }






  ///                                                Cari Güncelle Aktif/Pasif

  /*
  Future<List<ModelCariler>> aktifPasifChange(String tableName,String aktif_pasif,int cari_ID)async{
    //Veri tabanına eriş
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String idName="";
    if(tableName=="cariler"){
      idName="cari_ID";
    }
    if(tableName=="stoklar"){
      idName="stok_id";
    }

    List<Map<String,dynamic>> maps=await db.rawQuery("UPDATE ${tableName} SET aktif_pasif='${aktif_pasif}' WHERE ${idName}=${cari_ID}");

    return List.generate(maps.length, (i) {

      var satir=maps[i];

      return ModelCariler(
        satir["cari_ID"],
        satir["cari_kod"],
        satir["column1"],
        satir["cari_vdaire_no"],
        satir["cari_vdaire_adi"],
        satir["cari_Email"],
        satir["cari_Ceptel"],
        satir["adr_cadde"],
        satir["adr_mahalle"],
        satir["adr_il"],
        satir["adr_ilce"],
        satir["cari_wwwadresi"],
        satir["adr_ulke"],
        satir["adr_posta_kodu"],
        satir["adr_tel_bolge_kodu"],
        satir["adr_tel_no1"],
        satir["adr_tel_no2"],
        satir["aktif_pasif"],
      );

    });
  }
*/


/*
  Future<void>stokSil(int stok_id)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    await db.delete("stoklar",where: "stok_id=?",whereArgs: [stok_id] );

  }
  */



  ///                                                Stok Güncelle

  /*
  Future<void> stokUpdate({
    required context,
    required int stok_id,
    required String sto_kod,
    required String sto_isim,
    required String sto_perakende_vergi,
    required String sto_standartmaliyet,
    required String sto_birim1_ad,
    required String sto_GtipNo,
    required String aktif_pasif,

  })async{
    //Veri tabanına eriş
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    await db.execute(
        "UPDATE stoklar SET sto_kod='${sto_kod}', sto_isim='${sto_isim}', sto_perakende_vergi='${sto_perakende_vergi}', sto_standartmaliyet='${sto_standartmaliyet}', sto_birim1_ad='${sto_birim1_ad}', sto_GtipNo='${sto_GtipNo}', aktif_pasif='${aktif_pasif}' WHERE stok_id=${stok_id}"
    );
  }
*/

/*

  Future<void>tableClear(String tableName)async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    //await db.delete("teklifler",where: "tklf_id=?",whereArgs:[teklif_id] );
    await db.execute("DELETE FROM ${tableName}");

  }
*/


  ///                                                Müşteri Ekle
  Future<void>musteriEkle({
    required var context,
    required String musteriKod,
    required String musteriAd,
    required String cinsiyet,
    required String ulke,
    required String il,
    required String ilce,
    required String tel,
    required String mail,
    required String web,
    required String not,

  })async{


    var alert=AlertMessage();

    try{
      //id otomatik oluştuğu için diğer alanları ekleyeceğiz.
      var db=await VeriTabaniYardimcisi.veritabaniErisim();



      var bilgiler=Map<String,dynamic>();
      bilgiler["musteri_kod"]=musteriKod;
      bilgiler["musteri_ad"]=musteriAd;
      bilgiler["cinsiyet"]=cinsiyet;
      bilgiler["ulke"]=ulke;
      bilgiler["il"]=il;
      bilgiler["ilce"]=ilce;
      bilgiler["tel"]=tel;
      bilgiler["mail"]=mail;
      bilgiler["web"]=web;
      bilgiler["not"]=not;

      await db.insert("musteriler", bilgiler).then((value){

        alert.alertOnlyProcessIcon(context, color: Colors.black, infoText: "Müşteri Eklendi", f: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MusteriKartlari())), alertType: "Success");

      });

    }catch(e){
      alert.alertInfoIcon(context, color: Colors.black, infoText: "Müşteri Oluşturulamadı", alertType: "ERROR");
    }
  }



  ///                                                Firma Bilgileri
  Future<List<ModelMusteriler>> musteriListesi()async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from musteriler");

    return List.generate(maps.length, (i) {

      var satir=maps[i];

      /*
      satir["ent_ID"],
        satir["ent_vkn"],
        satir["ent_sube"],
        satir["ent_sifre"],
        satir["ent_apikey"],
      */

      return ModelMusteriler(
          musteriKod: satir["musteri_kod"],
          musteriAd: satir["musteri_ad"],
          cinsiyet: satir["cinsiyet"],
          ulke: satir["ulke"],
          il: satir["il"],
          ilce: satir["ilce"],
          tel: satir["tel"],
          mail: satir["mail"],
          web: satir["web"],
          not: satir["not"]);

    });
  }



  ///                                                Borç Ekle
  Future<void>borcEkle({
    required var context,
    required String borcKod,
    required double borcTutar,
    required int toplamTaksitSayisi,
    required double aylikOdenecekTutar,
    required int odenenTaksitSayisi,
    required String baslangicTarih,
    required String bitisTarih,
    required String borcDurum, //Açık , Kapalı
    required String paraBirimi, //TL , DOLAR
    required String musteri_kod,
    required String musteri_ad,

  })async{


    var alert=AlertMessage();

    try{
      //id otomatik oluştuğu için diğer alanları ekleyeceğiz.
      var db=await VeriTabaniYardimcisi.veritabaniErisim();



      var bilgiler=Map<String,dynamic>();
      bilgiler["borc_kod"]=borcKod;
      bilgiler["borc_tutar"]=borcTutar;
      bilgiler["toplam_taksit_sayisi"]=toplamTaksitSayisi;
      bilgiler["aylik_odenecek_tutar"]=aylikOdenecekTutar;
      bilgiler["odenen_taksit_sayisi"]=odenenTaksitSayisi;
      bilgiler["baslangic_tarih"]=baslangicTarih;
      bilgiler["bitis_tarih"]=bitisTarih;
      bilgiler["borc_durum"]=borcDurum;
      bilgiler["para_birimi"]=paraBirimi;
      bilgiler["musteri_kod"]=musteri_kod;
      bilgiler["musteri_ad"]=musteri_ad;

      await db.insert("borclar", bilgiler).then((value){
        //alert.alertInfoIcon(context, color: Colors.black, infoText: "Yeni Borç Listeye Eklendi", alertType: "Success");

        alert.alertOnlyProcessIcon(context, color: Colors.black, infoText: "Yeni Borç Listeye Eklendi", f: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaksitliBorcEkle())), alertType: "Success");

      });

    }catch(e){
      alert.alertInfoIcon(context, color: Colors.black, infoText: "Borç Eklenemedi", alertType: "ERROR");
    }
  }



  ///BorçListesini çağır
  Future<List<ModelBorclar>> borcListesi({required int yil,required int ay})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    //List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar ORDER BY borc_id DESC");
    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar WHERE borc_durum='Aktif' AND baslangic_tarih  ORDER BY borc_id DESC");

    return List.generate(maps.length, (i) {

      var satir=maps[i];
      late double borcTutar;
      late double aylikOdenecekTutar;

      if(satir["borc_tutar"].toString().contains(".")){
        borcTutar=satir["borc_tutar"];
      }else{
        borcTutar=double.parse(satir["borc_tutar"].toString()+".0");
      }

      if(satir["aylik_odenecek_tutar"].toString().contains(".")){
        aylikOdenecekTutar=satir["aylik_odenecek_tutar"];
      }else{
        aylikOdenecekTutar=double.parse(satir["aylik_odenecek_tutar"].toString()+".0");
      }

      /*
      print("borcKod:  ${satir["borc_kod"]}");
      print("Borç Tutar: ${borcTutar}");
      //print("toplamTaksitSayisi: ${int.parse(satir["toplam_taksit_sayisi"])}");
      print("aylikOdenecekTutar: ${aylikOdenecekTutar}");
      //print("odenenTaksitSayisi: ${int.parse(satir["odenen_taksit_sayisi"])}");
      print("baslangicTarih: ${satir["baslangic_tarih"]}");
      print("bitisTarih: ${satir["bitis_tarih"]}");
      print("borcDurum: ${satir["borc_durum"]}");
      print("paraBirimi: ${satir["para_birimi"]}");
      print("musteriKod: ${satir["musteri_kod"]}");
      */



      return ModelBorclar(
          borcKod: satir["borc_kod"],
          borcTutar: borcTutar,//double.parse(satir["borc_tutar"]),
          toplamTaksitSayisi: satir["toplam_taksit_sayisi"],//int.parse(satir["toplam_taksit_sayisi"]),
          aylikOdenecekTutar: aylikOdenecekTutar,//double.parse(satir["aylik_odenecek_tutar"]),
          odenenTaksitSayisi:satir["odenen_taksit_sayisi"],//int.parse(satir["odenen_taksit_sayisi"]),
          baslangicTarih: satir["baslangic_tarih"],
          bitisTarih: satir["bitis_tarih"],
          borcDurum: satir["borc_durum"],
          paraBirimi: satir["para_birimi"],
          musteriKod: satir["musteri_kod"],
          musteriAd: satir["musteri_ad"],
      );

    });
  }


  ///BorçListesini çağır
  Future<List<ModelBorclar>> borcListesiOdemeAldim({required String musteriKod,required String musteriAd})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    //List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar ORDER BY borc_id DESC");
    //List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar WHERE borc_durum='Aktif' AND baslangic_tarih  ORDER BY borc_id DESC");


    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar WHERE borc_durum='Aktif' AND musteri_kod='${musteriKod}' AND musteri_ad='${musteriAd}' ");

    return List.generate(maps.length, (i) {

      var satir=maps[i];
      late double borcTutar;
      late double aylikOdenecekTutar;

      if(satir["borc_tutar"].toString().contains(".")){
        borcTutar=satir["borc_tutar"];
      }else{
        borcTutar=double.parse(satir["borc_tutar"].toString()+".0");
      }

      if(satir["aylik_odenecek_tutar"].toString().contains(".")){
        aylikOdenecekTutar=satir["aylik_odenecek_tutar"];
      }else{
        aylikOdenecekTutar=double.parse(satir["aylik_odenecek_tutar"].toString()+".0");
      }

      /*
      print("borcKod:  ${satir["borc_kod"]}");
      print("Borç Tutar: ${borcTutar}");
      //print("toplamTaksitSayisi: ${int.parse(satir["toplam_taksit_sayisi"])}");
      print("aylikOdenecekTutar: ${aylikOdenecekTutar}");
      //print("odenenTaksitSayisi: ${int.parse(satir["odenen_taksit_sayisi"])}");
      print("baslangicTarih: ${satir["baslangic_tarih"]}");
      print("bitisTarih: ${satir["bitis_tarih"]}");
      print("borcDurum: ${satir["borc_durum"]}");
      print("paraBirimi: ${satir["para_birimi"]}");
      print("musteriKod: ${satir["musteri_kod"]}");
      */



      return ModelBorclar(
        borcKod: satir["borc_kod"],
        borcTutar: borcTutar,//double.parse(satir["borc_tutar"]),
        toplamTaksitSayisi: satir["toplam_taksit_sayisi"],//int.parse(satir["toplam_taksit_sayisi"]),
        aylikOdenecekTutar: aylikOdenecekTutar,//double.parse(satir["aylik_odenecek_tutar"]),
        odenenTaksitSayisi:satir["odenen_taksit_sayisi"],//int.parse(satir["odenen_taksit_sayisi"]),
        baslangicTarih: satir["baslangic_tarih"],
        bitisTarih: satir["bitis_tarih"],
        borcDurum: satir["borc_durum"],
        paraBirimi: satir["para_birimi"],
        musteriKod: satir["musteri_kod"],
        musteriAd: satir["musteri_ad"],
      );

    });
  }



  Future<List<ModelBorclar>> tumBorclarborcListesi()async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps=await db.rawQuery("SELECT * from borclar ORDER BY borc_id DESC");

    return List.generate(maps.length, (i) {

      var satir=maps[i];
      late double borcTutar;
      late double aylikOdenecekTutar;

      if(satir["borc_tutar"].toString().contains(".")){
        borcTutar=satir["borc_tutar"];
      }else{
        borcTutar=double.parse(satir["borc_tutar"].toString()+".0");
      }

      if(satir["aylik_odenecek_tutar"].toString().contains(".")){
        aylikOdenecekTutar=satir["aylik_odenecek_tutar"];
      }else{
        aylikOdenecekTutar=double.parse(satir["aylik_odenecek_tutar"].toString()+".0");
      }

      /*
      print("borcKod:  ${satir["borc_kod"]}");
      print("Borç Tutar: ${borcTutar}");
      //print("toplamTaksitSayisi: ${int.parse(satir["toplam_taksit_sayisi"])}");
      print("aylikOdenecekTutar: ${aylikOdenecekTutar}");
      //print("odenenTaksitSayisi: ${int.parse(satir["odenen_taksit_sayisi"])}");
      print("baslangicTarih: ${satir["baslangic_tarih"]}");
      print("bitisTarih: ${satir["bitis_tarih"]}");
      print("borcDurum: ${satir["borc_durum"]}");
      print("paraBirimi: ${satir["para_birimi"]}");
      print("musteriKod: ${satir["musteri_kod"]}");
      */



      return ModelBorclar(
        borcKod: satir["borc_kod"],
        borcTutar: borcTutar,//double.parse(satir["borc_tutar"]),
        toplamTaksitSayisi: satir["toplam_taksit_sayisi"],//int.parse(satir["toplam_taksit_sayisi"]),
        aylikOdenecekTutar: aylikOdenecekTutar,//double.parse(satir["aylik_odenecek_tutar"]),
        odenenTaksitSayisi:satir["odenen_taksit_sayisi"],//int.parse(satir["odenen_taksit_sayisi"]),
        baslangicTarih: satir["baslangic_tarih"],
        bitisTarih: satir["bitis_tarih"],
        borcDurum: satir["borc_durum"],
        paraBirimi: satir["para_birimi"],
        musteriKod: satir["musteri_kod"],
        musteriAd: satir["musteri_ad"],
      );

    });
  }


  //Ayın Son Gününü Verir.
  int infoLastDate(DateTime date){

    var infos=DateTime(date.year,date.month+1,date.day-date.day);

    return infos.day;
  }

  Future<List<ModelBorclar>>borcListeFiltre({ required String borcDurum,required String ay,required String yil})async{
    var db=await VeriTabaniYardimcisi.veritabaniErisim();
    String sorgu="SELECT * from borclar";

    DateTime date=DateTime.now();


    //print("select * from borclar WHERE borc_durum='Aktif' AND baslangic_tarih BETWEEN '${DateTime(int.parse(yil),int.parse(ay),1)}' AND '${DateTime(int.parse(yil),int.parse(ay),infoLastDate(DateTime(int.parse(yil),int.parse(ay))))})}' ORDER BY borc_id DESC");

    if(borcDurum=="Aktif"){
      print("HEPSİ");

      //sorgu='''select * from borclar WHERE borc_durum='Aktif' AND bitis_tarih >= '2023-06-05 00:00:00.000' ORDER BY borc_id DESC ''';

      ///Belirtilen Ayda borç var mı göster.
      sorgu='''select * from borclar WHERE 
borc_durum='Aktif' AND bitis_tarih >= '${DateTime(int.parse(yil),int.parse(ay),1)}' AND baslangic_tarih<='${DateTime(int.parse(yil),int.parse(ay),31)}' ORDER BY borc_id DESC''';

      print(sorgu);
      ///Çalışıyor.
      //sorgu="select * from borclar WHERE borc_durum='Aktif' AND baslangic_tarih BETWEEN '${DateTime(int.parse(yil),int.parse(ay),1)}' AND '${DateTime(int.parse(yil),int.parse(ay),infoLastDate(DateTime(int.parse(yil),int.parse(ay))))})}' ORDER BY borc_id DESC";
    }else if(borcDurum=="Pasif"){
      print("Pasif");
      sorgu="select * from borclar WHERE borc_durum='Pasif' AND tarih BETWEEN '${DateTime(int.parse(yil),int.parse(ay),1)}' AND '${DateTime(int.parse(yil),int.parse(ay),infoLastDate(DateTime(int.parse(yil),int.parse(ay))))})}' ORDER BY borc_id DESC";

    }else{
      print("Aktif ve Pasıf kullanılmadı.");
    }



    List<Map<String,dynamic>> maps=await db.rawQuery(sorgu);

    return List.generate(maps.length, (i) {

      var satir=maps[i];

      late double tutar;

      if(satir["borc_tutar"].toString().contains(".")){
        tutar=satir["borc_tutar"];
      }else{
        tutar=double.parse(satir["borc_tutar"].toString()+".0");
      }


      late double aylik_odenecek_tutar;

      if(satir["aylik_odenecek_tutar"].toString().contains(".")){
        aylik_odenecek_tutar=satir["aylik_odenecek_tutar"];
      }else{
        aylik_odenecek_tutar=double.parse(satir["aylik_odenecek_tutar"].toString()+".0");
      }


      print("toplam_taksit_sayisi: ${satir["toplam_taksit_sayisi"]}");
      print("aylik_odenecek_tutar: ${satir["aylik_odenecek_tutar"]}");
      print("odenen_taksit_sayisi: ${satir["odenen_taksit_sayisi"]}");
      var toplam_taksit_sayisi=satir["toplam_taksit_sayisi"];
      //var aylik_odenecek_tutar=satir["aylik_odenecek_tutar"];
      var odenen_taksit_sayisi=satir["odenen_taksit_sayisi"];





      return ModelBorclar(
          borcKod: satir["borc_kod"],
          borcTutar: tutar,//satir["borc_tutar"],
          toplamTaksitSayisi: toplam_taksit_sayisi,//satir["toplam_taksit_sayisi"],
          aylikOdenecekTutar: aylik_odenecek_tutar,//satir["aylik_odenecek_tutar"],
          odenenTaksitSayisi: odenen_taksit_sayisi,//satir["odenen_taksit_sayisi"],
          baslangicTarih: satir["baslangic_tarih"],
          bitisTarih: satir["bitis_tarih"],
          borcDurum: borcDurum,
          paraBirimi: satir["para_birimi"],
          musteriKod: satir["musteri_kod"],
          musteriAd: satir["musteri_ad"]);
      /*
      return ModelGelirGider(
        satir["gelir_gider_ID"],
        satir["islem_tipi"],
        satir["tarih"],
        satir["aciklama"],
        tutar,
      );
      */

    });
  }




}