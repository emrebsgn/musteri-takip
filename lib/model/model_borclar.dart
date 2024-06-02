class ModelBorclar{
  late String borcKod;
  late double borcTutar;
  late int toplamTaksitSayisi;
  late double aylikOdenecekTutar;
  late int odenenTaksitSayisi;
  late String baslangicTarih;
  late String bitisTarih;
  late String borcDurum;
  late String paraBirimi;
  late String musteriKod;
  late String musteriAd;

  ModelBorclar(
  {
    required this.borcKod,
    required this.borcTutar,
    required this.toplamTaksitSayisi,
    required this.aylikOdenecekTutar,
    required this.odenenTaksitSayisi,
    required this.baslangicTarih,
    required this.bitisTarih,
    required this.borcDurum,
    required this.paraBirimi,
    required this.musteriKod,
    required this.musteriAd
});
}