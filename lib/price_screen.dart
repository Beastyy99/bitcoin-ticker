import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String rate = '?';
  bool isLoading = false;
  Map<String, dynamic> cryptoPrices = {};

  Future<dynamic> getCoinValue() async {
    for (String cryptoCoin in cryptoList) {
      isLoading = true;
      try {
        isLoading = false;
        double coinValue =
            await CoinData().coinDataValue(selectedCurrency, cryptoCoin);
        setState(() {
          cryptoPrices[cryptoCoin] = coinValue.toStringAsFixed(2);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  DropdownButton<String> androidDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropDownItems,
        onChanged: (value) async {
          setState(() {
            selectedCurrency = value;
            getCoinValue();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCoinValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            CryptoPriceCard(
              rate: isLoading ? '?' : cryptoPrices['BTC'],
              selectedCurrency: selectedCurrency,
              cryptoCoin: 'BTC',
            ),
            CryptoPriceCard(
                rate: isLoading ? '?' : cryptoPrices['ETH'],
                selectedCurrency: selectedCurrency,
                cryptoCoin: 'ETH'),
            CryptoPriceCard(
                rate: isLoading ? '?' : cryptoPrices['LTC'],
                selectedCurrency: selectedCurrency,
                cryptoCoin: 'LTC'),
          ]),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS ? iOSPicker() : androidDropDownButton()),
        ],
      ),
    );
  }
}

class CryptoPriceCard extends StatelessWidget {
  const CryptoPriceCard({
    Key key,
    @required this.rate,
    @required this.selectedCurrency,
    @required this.cryptoCoin,
  }) : super(key: key);

  final String rate;
  final String selectedCurrency;
  final String cryptoCoin;

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
            '1 $cryptoCoin = $rate $selectedCurrency',
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
}
//
