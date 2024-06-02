import 'package:flutter/material.dart';

import '../utils/color.dart';

class InfoOdemeAldim extends StatefulWidget {
  const InfoOdemeAldim({Key? key}) : super(key: key);

  @override
  State<InfoOdemeAldim> createState() => _InfoOdemeAldimState();
}

class _InfoOdemeAldimState extends State<InfoOdemeAldim> {
  @override
  Widget build(BuildContext context) {
    var screenInfos=MediaQuery.of(context); //Burada ekran boyutu alınacak.
    final double screenWidth=screenInfos.size.width;
    final double screenHeight=screenInfos.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Text("Ödeme Ekle Bilgi"),
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          Card(
            child: Container(
              padding: EdgeInsets.all(4),
              child: Text("Ödeme Ekle sayfasında kaydırma sırasında sorun yaşıyorsanız köşelerden kaydırmayı deneyiniz.\n\nBu sayfada müşteriden alınan ödemeler eklenir."),
            ),
          )
        ],
      ),
    );
  }
}
