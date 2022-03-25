import 'dart:convert';
import 'package:http/http.dart' as http;

const apiKey = '8B617A83-7221-451D-80B4-87EA36648B93';
const List<String> currenciesList = [
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

class CoinData {
  String url = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD?$apiKey';
  Future getCoinData() async {
    http.Response response = await http.get(Uri.parse(url));
    String data = response.body;
    var decodeData = jsonDecode(data);
    return decodeData['rate'];
  }
}
