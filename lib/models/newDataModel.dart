// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel1 dataModelFromJson(String str) => DataModel1.fromJson(json.decode(str));

String dataModelToJson(DataModel1 data) => json.encode(data.toJson());

class DataModel1 {
  DataModel1({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
  });

  DateTime? time;
  String? assetIdBase;
  String? assetIdQuote;
  double? rate;

  factory DataModel1.fromJson(Map<String, dynamic> json) => DataModel1(
    time: DateTime.parse(json["time"]),
    assetIdBase: json["asset_id_base"],
    assetIdQuote: json["asset_id_quote"],
    rate: json["rate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time": time.toString(),
    "asset_id_base": assetIdBase,
    "asset_id_quote": assetIdQuote,
    "rate": rate,
  };
}
