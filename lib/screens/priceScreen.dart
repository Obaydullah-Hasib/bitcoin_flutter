import 'package:bitcoin_ticker/data/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/data_model.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = "USD";
  DataModel? data;
  bool flag = true;
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItem = [];
    for (String currency in currenciesList) {
      DropdownMenuItem<String> newItem =
          DropdownMenuItem<String>(child: Text(currency), value: currency);
      dropdownItem.add(newItem);
    }
    return DropdownButton<String>(
      alignment: Alignment.center,
      value: selectedCurrency,
      items: dropdownItem,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData(selectedCurrency!);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItem = [];
    List <String> pickerItemString=[];
    for (String currency in currenciesList) {
      Text(currency);
      pickerItem.add(Text(currency));
      pickerItemString.add(currency);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        getData(pickerItemString[selectedIndex]);},
      children: pickerItem,
    );
  }

  void getData(String value) async {
    try {
      data = await CoinData().getCoinData(value);

      flag = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData('USD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: flag
                  ? const Center(
                      child: CircularProgressIndicator(
                      color: Colors.red,
                    ))
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      child: Text(
                        '1 BTC = ${data?.rate} $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 20.0, color: Colors.white),
                      ),
                    ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150.0,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: Theme.of(context).platform == TargetPlatform.android
                ?androidDropdown()
                :  iOSPicker(),
          )
        ],
      ),
    );
  }
}
