import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/data_model.dart';
const List<String> currenciesList =[
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const coinAPIURL ='https://rest.coinapi.io/v1/exchangerate';
const apiKey = '18EE2CDB-F9ED-443D-BDA3-859D20D5EA51';
class CoinData{
  Future<DataModel> getCoinData(String currency) async{
    String requestURL = '$coinAPIURL/BTC/$currency?apikey=$apiKey';
     http.Response response = await http.get(Uri.parse(requestURL));
     if(response.statusCode==200){

       return DataModel.fromJson(jsonDecode(response.body));
     }
     else {
       print(response.statusCode);

       throw'Problem with get Request. Status ';
     }

  }
}
