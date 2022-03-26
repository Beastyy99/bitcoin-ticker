import 'networking.dart';

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
  Future<dynamic> coinDataValue(String currency, String cryptoCoin) async {
    String url =
        'https://rest.coinapi.io/v1/exchangerate/$cryptoCoin/$currency?apikey=$apiKey';
    NetworkHelper networkHelper = url != null ? NetworkHelper(url) : '';
    try {
      var coinValue = await networkHelper.getCoinData();
      return coinValue['rate'];
    } catch (e) {
      print(e);
    }
  }
}
