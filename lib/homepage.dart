import 'dart:convert';
import 'package:cryptocurrency_app/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoinListScreen extends StatefulWidget {
  @override
  _CoinListScreenState createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  //List<Coin> coins = [];

  List<dynamic> currencies=[];

    @override
  void initState() {
    super.initState();
    fetchCoinData();
  }

  Future<void> fetchCoinData() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
     // coins=data.map((e) => Coin(id: e['name'], symbol: e['name'], name: e['name'], image: e['name'])).toList();
     setState(() {
      currencies= json.decode(response.body);
     });
    } else {
      print('Failed to fetch coin data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.grey.shade700,
        elevation: 0,
        title: Text('Cryptocurrency Prices'),
      ),
      body: currencies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      final Map currency = currencies[index];
                      return getListUi(currency);
                    },
                  ),
              ),
            ],
          ),
    );
  }
  Widget getListUi(Map currency){
    return ListTile(
      leading: Image.network(currency['image']),
      title: Text(currency['name'],style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
      subtitle: getSubTitleText(currency['current_price'].toString(), currency['price_change_24h'].toString()),
      isThreeLine: true,);
  }

  Widget getSubTitleText(String price, String percentageChange ) {
    TextSpan priceTextWidge= TextSpan(
      text: "₹$price\n",style: TextStyle(color: Colors.black)
    );
    String percentageChangeText="1 hour : ${percentageChange}";
    TextSpan percentageChangeTextWidget;
    if(double.parse(percentageChange)>0){
      percentageChangeTextWidget =TextSpan(
        text: percentageChangeText,style: TextStyle(color: Colors.red),
      );
    }else{
      percentageChangeTextWidget=TextSpan(
        text: percentageChangeText,style: TextStyle(color: Colors.green)
      );
    }
    return RichText(text: TextSpan(
      children: [
        priceTextWidge,
        percentageChangeTextWidget
      ]
    ));
  }
}