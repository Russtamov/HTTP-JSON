// To parse this JSON data, do
//
//     final araba = arabaFromMap(jsonString);

import 'dart:convert';

Araba arabaFromMap(String str) => Araba.fromMap(json.decode(str));

String arabaToMap(Araba data) => json.encode(data.toMap());

class Araba {
  final String arabaAdi;
  final String ulke;
  final int kurulusYili;
  final List<Model> model;

  Araba({
    required this.arabaAdi,
    required this.ulke,
    required this.kurulusYili,
    required this.model, required int kurulusYil,
  });

  factory Araba.fromMap(Map<String, dynamic> json) => Araba(
        arabaAdi: json["araba_adi"],
        ulke: json["ulke"],
        kurulusYili: json["kurulus_yili"],
        model: List<Model>.from(json["model"].map((x) => Model.fromMap(x))), kurulusYil: 1957,
      );

  Map<String, dynamic> toMap() => {
        "araba_adi": arabaAdi,
        "ulke": ulke,
        "kurulus_yili": kurulusYili,
        "model": List<dynamic>.from(model.map((x) => x.toMap())),
      };
}

class Model {
  final String modelAdi;
  final int fiyat;
  final String vitesTipi;
  final bool benzinli;

  Model({
    required this.modelAdi,
    required this.fiyat,
    required this.vitesTipi,
    required this.benzinli,
  });

  factory Model.fromMap(Map<String, dynamic> json) => Model(
        modelAdi: json["model_adi"],
        fiyat: json["fiyat"],
        vitesTipi: json["vites_tipi"],
        benzinli: json["benzinli"],
      );

  Map<String, dynamic> toMap() => {
        "model_adi": modelAdi,
        "fiyat": fiyat,
        "vites_tipi": vitesTipi,
        "benzinli": benzinli,
      };
}
