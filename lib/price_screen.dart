import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '770B781E-9D45-44EF-B9A5-F1B21D411BC5';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int rat;
  int rat1;
  int rat2;
  String cityName;
  String selectedCurrency = currenciesList[0];
  Future<void> calc(String name) async {
    if (cityName == null) cityName = 'USD';
    cityName = name;
    print("Hel");
    print(cityName);
    var decodedData;
    var decodedData2;
    var decodedData3;
    var url =
        'https://rest.coinapi.io/v1/exchangerate/BTC/$cityName?apikey=770B781E-9D45-44EF-B9A5-F1B21D411BC5';
    var url2 =
        'https://rest.coinapi.io/v1/exchangerate/ETH/$cityName?apikey=770B781E-9D45-44EF-B9A5-F1B21D411BC5';
    http.Response response = await http.get(Uri.parse(url));
    http.Response response2 = await http.get(Uri.parse(url2));
    var url3 =
        'https://rest.coinapi.io/v1/exchangerate/LTC/$cityName?apikey=770B781E-9D45-44EF-B9A5-F1B21D411BC5';
    http.Response response3 = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      decodedData = jsonDecode(data);

      setState(() {
        rat = decodedData["rate"].toInt();
      });
      print(rat);
    } else {
      print("helo error");
      print(response.statusCode);
    }
    /*if (response2.statusCode == 200) {
      String data = response2.body;
      decodedData2 = jsonDecode(data);

      setState(() {
        rat1 = decodedData2["rate"].toInt();
      });
      print(rat1);
    } else {
      print("helo error");
      print(response.statusCode);
    }
    if (response3.statusCode == 200) {
      String data = response3.body;
      decodedData3 = jsonDecode(data);

      setState(() {
        rat2 = decodedData3["rate"].toInt();
      });
      print(rat1);
    } else {
      print("helo error");
      print(response.statusCode);
    }*/
  }

  DropdownButton<String> androidDropDown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      onChanged: (String newValue) {
        setState(() {
          selectedCurrency = newValue;
          calc(newValue);
        });
      },
      items: currenciesList.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: currenciesLt,
    );
  }

  Widget getPicker() {
    if (Platform.isIOS)
      return iOSPicker();
    else
      return androidDropDown();
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
          Expanded(
            child: Column(
              children: [
                Cardwid(curr: 'BTC', rat: rat, cityName: cityName),
                Cardwid(curr: 'ETH', rat: rat1, cityName: cityName),
                // Cardwid(curr: 'LTC', rat: rat2, cityName: cityName),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

class Cardwid extends StatelessWidget {
  const Cardwid({
    Key key,
    @required this.rat,
    @required this.cityName,
    @required this.curr,
  }) : super(key: key);
  final String curr;
  final int rat;
  final String cityName;

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
            '1 $curr = $rat $cityName',
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
} /*
*/
