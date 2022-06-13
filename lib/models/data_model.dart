// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    this.time,
    this.assetIdBase,
    this.assetIdQuote,
    this.rate,
    this.srcSideBase,
  });

  DateTime ?time;
  String ?assetIdBase;
  String ?assetIdQuote;
  double? rate;
  List<SrcSideBase>? srcSideBase;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
    time: DateTime.parse(json["time"]),
    assetIdBase: json["asset_id_base"],
    assetIdQuote: json["asset_id_quote"],
    rate: json["rate"].toDouble(),
    srcSideBase: List<SrcSideBase>.from(json["src_side_base"].map((x) => SrcSideBase.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "time": time.toString(),
    "asset_id_base": assetIdBase,
    "asset_id_quote": assetIdQuote,
    "rate": rate,
    "src_side_base": List<dynamic>.from(srcSideBase!.map((x) => x.toJson())),
  };
}

class SrcSideBase {
  SrcSideBase({
    this.time,
    this.asset,
    this.rate,
    this.volume,
  });

  DateTime? time;
  String ?asset;
  double ?rate;
  double ?volume;

  factory SrcSideBase.fromJson(Map<String, dynamic> json) => SrcSideBase(
    time: DateTime.parse(json["time"]),
    asset: json["asset"],
    rate: json["rate"].toDouble(),
    volume: json["volume"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "time": time.toString(),
    "asset": asset,
    "rate": rate,
    "volume": volume,
  };
}
