import 'package:bitcoin_ticker/data/coin_data.dart';
import 'package:bitcoin_ticker/models/newDataModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = "USD";
List <DataModel1?> data=[];
  bool flag = true;
  DropdownButton<String> AndroidDropdown_Currency() {
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

  CupertinoPicker iOSPicker_currency() {
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
      onSelectedItemChanged: (selectedIndex) {getData(pickerItemString[selectedIndex]);},
      children: pickerItem,
    );
  }

  void getData(String value) async {
    try {
      data = await CoinData().getCoinData(value);

      //print( "${data.length}");
      setState(() {
      });
    } catch (e) {
      //print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
     getData('USD');
    super.initState();

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
              child: data.isEmpty
                  ?  const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ))
                  : Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                child: Column(
                  children: List.generate(data.length, (index) =>   Text(
                    '1 ${cryptoList[index]} = ${(data[index]?.rate)?.toStringAsFixed(2)} $selectedCurrency',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0, color: Colors.white),
                  ),)
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150.0,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlueAccent,
            child: Theme.of(context).platform == TargetPlatform.iOS
                ? iOSPicker_currency()
                : AndroidDropdown_Currency(),
          )
        ],
      ),
    );
  }
}
/*
class CryptoCard extends StatelessWidget {
  final double? value;
  final String? selectedCurrency;
  final String? cryptoCurrency;



  CryptoCard({this.value, this.selectedCurrency, this.cryptoCurrency});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}*/
