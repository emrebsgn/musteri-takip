import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeriTabaniYardimcisi{
  static final String veritabaniAdi="musteri_takip.sqlite";



  static Future<Database> veritabaniErisim()async{
    String veritabaniYolu=join(await getDatabasesPath(),veritabaniAdi);
    if(await databaseExists(veritabaniYolu)){
      print("Veri tabanı zaten var.Kopyalamaya gerek yok");
    }else{
      //program içerisindeki dosya dizininde bulunan dosyası cihaza kaydet.
      ByteData data=await rootBundle.load("veritabani/${veritabaniAdi}");
      //eriştiğimiz dosyayı byte türüne dönüştür
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
      //Dosya oluştur
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true); //flush true=> Yazdırma işleminde sıkıntı olursa en son ki veriye kadar alacak.
      print("Veri tabanı kopyalandı");
    }
    return openDatabase(veritabaniYolu);

  }
}